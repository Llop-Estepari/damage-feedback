AddEventHandler('weaponDamageEvent', function (sender, data)
  local targetPed = NetworkGetEntityFromNetworkId(data.hitGlobalId)
  if IsPedAPlayer(targetPed) then
    local coords = GetEntityCoords(targetPed)
    local damage = data.weaponDamage
    local weaponType = data.weaponType
    local willKill = data.willKill
    local currentArmour = GetPedArmour(targetPed)
    TriggerClientEvent('hitmarker:hit', sender, coords, damage, weaponType, currentArmour)
  end
end)