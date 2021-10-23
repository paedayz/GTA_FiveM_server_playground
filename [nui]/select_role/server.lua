RegisterNetEvent("Qooz:server:selectRole")
AddEventHandler("Qooz:server:selectRole", function(source, role)
    print("select role")
    tableSize = 0
    MySQL.Async.fetchAll('SELECT * FROM role_client WHERE id=@source',
    {["source"] = source},
    function(result)
        for _ in pairs(result) do tableSize = tableSize + 1 end
        -- print("table sizeeee")
        -- print(tableSize)
        if tableSize == 0 then
            MySQL.Async.fetchAll('INSERT INTO role_client (id, role, role_id) value(@source, @role, @role_id)',
            {["@source"] = source, ["role"] = role, ["role_id"] = 0},
            function(result)
                print("Update role successfully")
            end)
        else
            MySQL.Async.fetchAll('UPDATE role_client SET id=@source, role=@role, role_id=@role_id  WHERE id=@source',
            {["@source"] = source, ["role"] = role, ["role_id"] = 0},
            function(result)
                print("Update role successfully")
            end)
        end
    end)
    
    
    -- MySQL.Async.fetchAll('INSERT INTO role_client (id, role, role_id) value(@source, @role, @role_id) ON DUPLICATE KEY UPDATE role=@role, role_id=@role_id',
    -- {["@source"] = source, ["role"] = role, ["role_id"] = 0},
    -- function(result)
    --     print("Select role successfully")
    -- end)

    -- MySQL.Async.fetchAll('UPDATE role_client SET id=@source, role=@role, role_id=@role_id  WHERE id=@source',
    -- {["@source"] = source, ["role"] = role, ["role_id"] = 0},
    -- function(result)
    --     print("Update role successfully")
    -- end)
end)

RegisterNetEvent("Qooz:server:getAllRole")
AddEventHandler("Qooz:server:getAllRole", function(source, role)
    print("get all roleee")
    MySQL.Async.fetchAll('SELECT * FROM role',
    {},
    function(result)
        print("resulttttt")
        return "result"
    end)
end)