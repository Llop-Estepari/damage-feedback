AddEventHandler('weaponDamageEvent', function (sender, data)
  local targetPed = NetworkGetEntityFromNetworkId(data.hitGlobalId)
  if IsPedAPlayer(targetPed) then
    local coords = GetEntityCoords(targetPed)
    local damage = data.weaponDamage
    local weaponType = data.weaponType
    local targetId = NetworkGetEntityOwner(targetPed)
    local willKill = data.willKill
    local currentArmour = GetPedArmour(targetPed)
    TriggerClientEvent('hitmarker:hit', sender, targetId, coords, damage, weaponType, currentArmour)
  end
end)