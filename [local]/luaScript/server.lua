-- RegisterNetEvent('EventManager:Server:TriggerBasicEvent')
-- AddEventHandler('EventManager:Server:TriggerBasicEvent', function(source, vector)
--     MySQL.Async.fetchAll("UPDATE `save_location` SET `x`=@x,`y`=@y,`z`=@z WHERE id=@source",
--         {["@x"] = vector.x, ["@y"] = vector.y, ["@z"] = vector.z, ["@source"] = source },
--         function(result)
--             print("update success")
--         end)
-- end)

-- RegisterNetEvent('EventManager:Server:getSaveLocation')
-- AddEventHandler('EventManager:Server:getSaveLocation', function(source)
--     print(source)
--     print("getSaveLocation")
--     MySQL.Async.fetchAll("SELECT * FROM `save_location` WHERE id=@source",
--     {["source"] = source},
--     function(result)
--         TriggerClientEvent("clientSpawn", -1, result[1].x, result[1].y, result[1].z)
--     end)
-- end)