local enabled = true
local hitmarkerIds = 0
local dmgDone = 0
local drawTime = 0

RegisterNUICallback('loadsettings', function()
  SendNUIMessage({
    type = 'SETTINGS',
    color = Config.hitmarkerColor,
    outlineWidth = Config.hitmarkerOutlineWidth,
    outlineColor = Config.hitmarkerOutlineColor,
    font = Config.hitmarkerFont,
    fontSize = Config.hitmarkerFontSize,
    indicatorLifetime = Config.markerTimer,
  })
end)

RegisterNetEvent('hitmarker:hit')
AddEventHandler('hitmarker:hit', function(targetId, coords, damage, weaponType, armour)
  coords = GetWorldPositionOfEntityBone(GetPlayerPed(GetPlayerFromServerId(targetId)), GetPedBoneIndex(PlayerPedId(), 31086))
  local hideSelfDmg = GetPlayerPed(GetPlayerFromServerId(targetId)) == PlayerPedId()
  local weaponGroup = GetWeapontypeGroup(weaponType)

  if (not enabled) or (hideSelfDmg) or (damage == 500) or (weaponGroup == -728555052 or weaponGroup == 1548507267 or weaponGroup == -1609580060) then return end
  if (drawTime < Config.acummulateTime) then
    dmgDone += damage
  else
    dmgDone = damage
  end

  drawTime = 0
  hitmarkerIds += 1

  local id = hitmarkerIds --Asign an id for the damage event.
  local resetMarker = false --If true reset the indicator transform.

  while (drawTime <= Config.markerTimer) and (id == hitmarkerIds) do
    resetMarker = drawTime == 0

    local onScreen, _x, _y = GetScreenCoordFromWorldCoord(coords.x, coords.y, coords.z + .5)
    SendNUIMessage({
      type = 'HITDATA',
      x = _x,
      y = _y,
      damage = dmgDone,
      distance = #(GetEntityCoords(PlayerPedId()) - vector3(coords.x, coords.y, coords.z)),
      resetMarker = resetMarker,
    })
    drawTime += 1
    Wait(0)
  end
  SendNUIMessage({
    type = 'DELETE',
    marker = curMarker,
  })
end)

RegisterCommand('damage', function(source, args, rawCommand)
  enabled = not enabled
end, false)