RegisterNetEvent("Qooz:server:on_duty:getUserRole")
AddEventHandler("Qooz:server:on_duty:getUserRole", function(source)
    MySQL.Async.fetchAll('SELECT * FROM role_client WHERE id=@source',
    {["source"] = source},
    function(result)
        tableSize = 0
        for _ in pairs(result) do tableSize = tableSize + 1 end

        userRole = "No Role"
        userWorkingTime = 0

        if tableSize ~= 0 then 
            userRole = result[1].role 

            MySQL.Async.fetchAll('SELECT * FROM role WHERE name=@userRole',
            {["userRole"] = userRole},
            function(result)
                userWorkingTime = result[1].working_time
                TriggerClientEvent("Qooz:client:on_duty:setRoleModel", -1, userRole, userWorkingTime)
            end)
        else 
            TriggerClientEvent("Qooz:client:on_duty:setRoleModel", -1, userRole, userWorkingTime)
        end
        
    end)
end)