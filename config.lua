Config = {}

Config.drawTime = 120                --The time when the hitmarker will be shown.
Config.acummulateTime = 40           --The time used to accumulate the damage.
Config.desapearTime = Config.drawTime + 40  --The time used desapear the hitmarker. Set to 0 if you want to desapear instantly.


Config.yOffset = 1.5          --Vertical offset (in gta units)
Config.xOffset = .15                 --Horizontal offset (not in gta units)
Config.critColor = { r = 255, g = 255, b = 0, a = 255 }
Config.normalColor = { r = 255, g = 25, b = 0, a = 255 }
Config.armorColor = { r = 0, g = 120, b = 255, a = 255 }

Config.critIndicator = ''        --Modifiy if you want to show a different indicator for crist. Leave in blank if you want to show the damage.
