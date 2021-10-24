RegisterNetEvent('EventManager:Server:updateSaveLocation')
AddEventHandler('EventManager:Server:updateSaveLocation', function(source, vector)
    print(source)
    MySQL.Async.fetchAll("UPDATE `save_location` SET `x`=@x,`y`=@y,`z`=@z WHERE id=@source",
    
        {["@x"] = vector.x, ["@y"] = vector.y, ["@z"] = vector.z, ["@source"] = source },
        function(result)
            print("update success")
        end)
end)

RegisterNetEvent('EventManager:Server:getSaveLocation')
AddEventHandler('EventManager:Server:getSaveLocation', function(source)
    print(source)
    MySQL.Async.fetchAll("SELECT * FROM `save_location` WHERE id=@source",
    {["source"] = source},
    function(result)
        TriggerClientEvent("clientSpawn", -1, result[1].x, result[1].y, result[1].z, "csb_money")
    end)
end)

RegisterNetEvent("Qooz:server:system_function:getUserRole")
AddEventHandler("Qooz:server:system_function:getUserRole", function(source)
    MySQL.Async.fetchAll('SELECT * FROM role_client WHERE id=@source',
    {["source"] = source},
    function(result)
        tableSize = 0
        for _ in pairs(result) do tableSize = tableSize + 1 end

        userRole = "No Role"

        if tableSize ~= 0 then userRole = result[1].role end
        
        TriggerClientEvent("Qooz:client:system_function:setRoleDisplay", -1, userRole)
    end)
end)