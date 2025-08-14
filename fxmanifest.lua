fx_version 'cerulean'
game 'gta5'

author 'Abdiez'
description '/geimport skript för sweden roleplay'
version '1.0.0'

shared_scripts {
    'configuration/*.lua',
}
server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'src/server/*.lua'
}

client_scripts {
    'src/client/*.lua'
}

dependency 'oxmysql'
dependency 'es_extended'
