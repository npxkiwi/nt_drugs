fx_version 'cerulean'
game 'gta5'

author 'Notepad x Kiwi'
description 'A drug script by Notepad and Kiwi'

shared_scripts {
    '@ox_lib/init.lua',
}

client_scripts {
    'lib/Tunnel.lua',
    'lib/Proxy.lua',
    'Config.lua',
    'client.lua'
}

server_scripts {
    '@vrp/lib/utils.lua',
    'server.lua'
}

lua54 'yes'