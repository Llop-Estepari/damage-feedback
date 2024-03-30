-- Font code https://forum.cfx.re/t/free-standalone-hitmarker-script/5212641

local enabled = true

local hitmarkerIds = 0
local markerTime = 90
local acumulateDamage = 30

-- local function DrawHimarker(damage, coords, marker)
--   local onScreen, _x, _y = GetScreenCoordFromWorldCoord(coords.x, coords.y, coords.z)
--   SendNUIMessage({
--     type = 'hitmarker',
--     x = _x,
--     y = _y,
--     damage = damage,
--     marker = marker,
--   })
-- end

-- RegisterNetEvent('hitmarker:hit')
-- AddEventHandler('hitmarker:hit', function(targetId, coords, damage, weaponType, armour)
--   local FoundLastDamagedBone, LastDamagedBone = GetPedLastDamageBone(GetPlayerPed(GetPlayerFromServerId(targetId)))
--   if (not enabled) or (damage == 500) or (weaponType == -728555052 or weaponType == 1548507267 or weaponType == -1609580060) then return end
--   coords = { x = coords.x, y = coords.y, z = coords.z + Config.yOffset }
--   local drawTime = 0
--   hitmarkerIds += 1

--   local curMarker = hitmarkerIds
--   while drawTime < markerTime do
--     DrawHimarker(damage, coords, curMarker)
--     drawTime += 1
--     Wait(1)
--   end
--   SendNUIMessage({
--     type = 'delete',
--     marker = curMarker,
--   })

-- end)

local dmgDone = 0

local drawTime = 0


RegisterNetEvent('hitmarker:hit')
AddEventHandler('hitmarker:hit', function(targetId, coords, damage, weaponType, armour)
  local FoundLastDamagedBone, LastDamagedBone = GetPedLastDamageBone(GetPlayerPed(GetPlayerFromServerId(targetId)))
  if (not enabled) or (damage == 500) or (weaponType == -728555052 or weaponType == 1548507267 or weaponType == -1609580060) then return end
  coords = { x = coords.x, y = coords.y, z = coords.z + Config.yOffset }
  if (drawTime < acumulateDamage) then
    dmgDone += damage
  else
    dmgDone = damage
  end

  drawTime = 0
  hitmarkerIds += 1
  local id = hitmarkerIds

  while (drawTime <= markerTime) and (id == hitmarkerIds) do
    Wait(0)
    drawTime += 1
    local onScreen, _x, _y = GetScreenCoordFromWorldCoord(coords.x, coords.y, coords.z)
    print(drawTime)
    SendNUIMessage({
      type = 'hitmarker',
      x = _x,
      y = _y,
      damage = dmgDone,
      distance = #(GetEntityCoords(PlayerPedId()) - vector3(coords.x, coords.y, coords.z)),
      timer = drawTime,
    })
  end
  SendNUIMessage({
    type = 'delete',
    marker = curMarker,
  })
end)

RegisterCommand('togglehitmarker', function(source, args, rawCommand)
  enabled = not enabled
end, false)

