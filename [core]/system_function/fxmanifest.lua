fx_version 'cerulean'
game 'gta5'

author 'Qooz'
description 'All system function script'
version '1.0.0'

client_script 'systemFuncClient.lua'
server_script {
    "systemFuncServer.lua",
    "@mysql-async/lib/MySQL.lua"
}