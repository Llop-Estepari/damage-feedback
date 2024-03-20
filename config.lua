Config = {}

local drawTime = 120                --The time when the hitmarker will be shown.
local acummulateTime = 40           --The time used to accumulate the damage.
local desapearTime = drawTime + 40  --The time used desapear the hitmarker. Set to 0 if you want to desapear instantly.


local verticalOffset = 1.0          --Vertical offset (in gta units)
local xOffset = .15                 --Horizontal offset (not in gta units)
local indicatorOpacity = 255
local critColor = { r = 255, g = 255, b = 0, a = indicatorOpacity }
local normalColor = { r = 255, g = 25, b = 0, a = indicatorOpacity }
local armorColor = { r = 0, g = 120, b = 255, a = indicatorOpacity }


local critIndicator = 'CRIT'        --Modifiy if you want to show a different indicator for crist. Leave in blank if you want to show the damage.
local minCritic = 394               --The minimum damage done by the lower damage weapon (Micro SMG) with a crit. (If you modified the weapon damage, change it here too)
