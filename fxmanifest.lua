fx_version 'cerulean'
game 'gta5'
lua54 'true'

name 'damage_indicator'
author 'llop'
description 'A damage feedback display that shows the damage done to a player when using firearms. Displays the damage dealt to a player in a configurable marker on the screen.'
version '1.1.0'

client_scripts { 'client/client.lua', }
server_scripts { 'server/server.lua', }
shared_script 'config.lua'

ui_page 'nui/nui.html'

files {
  'nui/*',
}

escrow_ignore {
  'config.lua',  -- Only ignore one file
}