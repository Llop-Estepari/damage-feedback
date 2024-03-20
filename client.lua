-- Font code https://forum.cfx.re/t/free-standalone-hitmarker-script/5212641

--TODO
-- ADD CONFIG FILE
local enbaled = true

local showHit = false
local lifeTime = 0
local hitAmount = ''
local position = { x = 0.0, y = 0.0, z = 0.0 }
local acummulatedDmg = 0
local firstShotPos = { x = 0.0, y = 0.0, z = 0.0 }
local colorText = Config.normalColor

local function Draw3DText(text)
  local onScreen, _x, _y = GetScreenCoordFromWorldCoord(position.x, position.y, position.z)
  if onScreen then
    _x += Config.xOffset / 10
    SetTextScale(0.0, .5)
    SetTextFont(7)
    SetTextColour(colorText.r, colorText.g, colorText.b, colorText.a)
    SetTextDropshadow(0, 0, 0, 0, 255)
    SetTextOutline()
    SetTextCentre(true)
    BeginTextCommandDisplayText("STRING")
    AddTextComponentSubstringPlayerName(text)
    EndTextCommandDisplayText(_x, _y)
  end
end

local function resetHitmarker()
  lifeTime = 0
  showHit = false
  position = { x = 0.0, y = 0.0, z = 0.0 }
  acummulatedDmg = 0
  firstShotPos = { x = 0.0, y = 0.0, z = 0.0 }
  hitAmount = ''
  colorText.a = Config.indicatorOpacity
end

RegisterNetEvent('hitmarker:hit')
AddEventHandler('hitmarker:hit', function(coords, damage, weaponType, armour)
  if (not enbaled) or (damage == 500) or (weaponType == -728555052 or weaponType == 1548507267 or weaponType == -1609580060) then return end
  coords = { x = coords.x, y = coords.y, z = coords.z + Config.verticalOffset }
  local hasArmour = armour > 0
  local crackArmour = armour - damage <= 0
  local criticalHit = damage >= Config.minCritic

  if lifeTime < Config.desapearTime then
    if criticalHit then
      colorText = Config.critColor
    else
      if hasArmour and not crackArmour then
        colorText = Config.armorColor
      else
        colorText = Config.normalColor
      end
    end
  end

  if criticalHit then
    if Config.critIndicator == "" then
      hitAmount = damage
    else
      hitAmount = Config.critIndicator
    end
    position = coords
  else
    if lifeTime < Config.acummulateTime then
      if firstShotPos.x == 0 and firstShotPos.y == 0 and firstShotPos.z == 0 then
        firstShotPos = coords
      end
      position = firstShotPos
      acummulatedDmg += damage
      hitAmount = acummulatedDmg
    else
      hitAmount = damage
      colorText.a = Config.indicatorOpacity
    end
  end

  lifeTime = 0
  showHit = true
end)

RegisterCommand('togglehitmarker', function(source, args, rawCommand)
  enbaled = not enbaled
end, false)

CreateThread(function()
  while true do
    if showHit then
      lifeTime += 1
      Draw3DText(hitAmount)
      if lifeTime >= Config.drawTime then
        colorText.a -= 2
        if lifeTime >= Config.desapearTime then
          resetHitmarker()
        end
      end
      Wait(0)
    else
      Wait(50)
    end
  end
end)
