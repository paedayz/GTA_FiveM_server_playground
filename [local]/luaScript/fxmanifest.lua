fx_version 'cerulean'
game 'gta5'

author 'Qooz'
description 'This is luaScript'
version '1.0.0'

client_script 'luaScript.lua'
server_script {
    "server.lua",
    "@mysql-async/lib/MySQL.lua"
}