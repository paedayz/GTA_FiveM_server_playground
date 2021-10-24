RegisterNetEvent("Qooz:server:on_duty:getUserRole")
AddEventHandler("Qooz:server:on_duty:getUserRole", function(source)
    print("wtffffxxzzz ".. source)
    MySQL.Async.fetchAll('SELECT * FROM role_client WHERE id=@source',
    {["source"] = source},
    function(result)
        tableSize = 0
        for _ in pairs(result) do tableSize = tableSize + 1 end

        userRole = "No Role"

        if tableSize ~= 0 then userRole = result[1].role end
        
        TriggerClientEvent("Qooz:client:on_duty:setRoleModel", -1, userRole)
    end)
end)