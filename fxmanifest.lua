fx_version 'cerulean'
game 'gta5'
lua54 'true'

name 'damage_feedback'
author 'llop'
description 'A damage feedback display that shows the damage done to a player when using firearms. Displays the damage dealt to a player in a configurable marker on the screen.'
version '1.1.0'
--Credit to the author of this topic (https://forum.cfx.re/t/free-standalone-hitmarker-script/5212641) for a lot of copy pasted code!

client_scripts { 'client.lua', }
server_scripts { 'server.lua', }
shared_script 'config.lua'


ui_page 'nui/nui.html'

files {
  'nui/*',
}
