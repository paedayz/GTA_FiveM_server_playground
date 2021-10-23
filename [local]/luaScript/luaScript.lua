-- AddEventHandler("onClientGameTypeStart", function(source)
--     TriggerServerEvent('EventManager:Server:getSaveLocation', source)
-- end)

-- RegisterNetEvent("clientSpawn")
-- AddEventHandler("clientSpawn", function(x, y, z)
--     exports.spawnmanager:spawnPlayer({
--         x = x,
--         y = y,
--         z = z,
--         heading = 291.71,
--         model = 'a_m_y_latino_01',
--         skipFade = false
--     })
-- end)

-- function ShowNotification(text)
--     SetNotificationTextEntry("STRING")
--     AddTextComponentSubstringTextLabel(text)
--     DrawNotification(false, true)
-- end

-- RegisterCommand("clientRespawn", function(source, args)
--     TriggerServerEvent('EventManager:Server:getSaveLocation', source)
--     showText('Respawn')
-- end, false)

-- RegisterCommand("saveFunc", function(source, args)
--     ped = PlayerPedId();
--     saveFunc(source)
-- end, false)

-- function saveFunc(source)
--     isShow = true
--     ped = PlayerPedId();
--     coords = GetEntityCoords(ped)
--     print(coords)
--     TriggerServerEvent('EventManager:Server:TriggerBasicEvent', source, coords)
--     showText("Game save")
-- end

-- function showText(text)
--     Citizen.CreateThread(function()
--         Citizen.SetTimeout(5000, function()
--             isShow = false
--         end)

--         while isShow do
--         Citizen.Wait(0)
--             SetTextFont(2)
--             SetTextProportional(1)
--             SetTextScale(0.0, 1.0)
--             SetTextColour(128, 128, 128, 255)
--             SetTextDropshadow(0, 0, 0, 0, 255)
--             SetTextEdge(1, 0, 0, 0, 255)
--             SetTextDropShadow()
--             SetTextOutline()
--             SetTextEntry("STRING")
--             AddTextComponentString(text)
--             DrawText(0.005, 0.005)
--         end
--     end)
-- end

-- Citizen.CreateThread(function()
--     while true do
--         -- SetEntityHealth(-1, GetEntityMaxHealth(-1))
--         print("healt")
--     end
-- end)

-- Citizen.CreateThread(function()
--     while true do
--         Citizen.Wait(0)
--         SetEntityHealth(-1, GetEntityMaxHealth(-1))
--         SetPedMaxHealth(PlayerPedId(), 90000000)
--         GiveWeaponToPed(PlayerPedId(), 2132975508, 500, false, true)
--         GiveWeaponToPed(PlayerPedId(), 1119849093, 500, false, true)
--     end
-- end)