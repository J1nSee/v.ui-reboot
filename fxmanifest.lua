fx_version 'cerulean'
games { 'gta5' }

description ''

ui_page 'nui/index.html'

dependency "vrp"

client_scripts {
  'client.lua',
}

server_scripts {
  '@vrp/lib/utils.lua',
  'server.lua'
}

files {
  'nui/**',
}