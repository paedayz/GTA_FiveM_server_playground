fx_version 'cerulean'
game 'gta5'

author 'Qooz'
description 'This is luaScript'
version '1.0.0'

client_script 'nui.lua'

server_script {
    "server.lua",
    "@mysql-async/lib/MySQL.lua"
}

ui_page 'html/index.html'

file {
    "html/index.html",
    "html/index.js",
    "html/reset.css",
    "html/index.css"
}