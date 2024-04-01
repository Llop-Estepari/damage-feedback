local enabled = true
local hitmarkerIds = 0
local dmgDone = 0
local drawTime = 0
local acummulateTime = 30 --The time used to accumulate the damage.

local function loadSettings()
  SendNUIMessage({
    type = 'SETTINGS',
    color, Config.hitmarkerColor,
    outlineWidth = Config.hitmarkerOutlineWidth,
    outlineColor = Config.hitmarkerOutlineColor,
    font = Config.hitmarkerFont,
    fontSize = Config.hitmarkerFontSize,
    indicatorLifetime = Config.markerTimer,
  })
end

RegisterNetEvent('hitmarker:hit')
AddEventHandler('hitmarker:hit', function(targetId, coords, damage, weaponType, armour)
  --local FoundLastDamagedBone, LastDamagedBone = GetPedLastDamageBone(GetPlayerPed(GetPlayerFromServerId(targetId)))
  --If is disabled, or the damage is 500(the damage done by hitting mele with a gun), or the weapon is not allowed, return.
  if (not enabled) or (damage == 500) or (weaponType == -728555052 or weaponType == 1548507267 or weaponType == -1609580060) then return end
  coords = { x = coords.x, y = coords.y, z = coords.z}
  if (drawTime < acummulateTime) then
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

    local onScreen, _x, _y = GetScreenCoordFromWorldCoord(coords.x, coords.y, coords.z)
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

CreateThread(function()
  Wait(100)
  loadSettings()
end)