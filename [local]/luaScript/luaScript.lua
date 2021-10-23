RegisterKeyMapping('saveFunc', 'save function', 'keyboard', 'K')

RegisterCommand("saveFunc", function()
    saveFunc()
end, false)

function saveFunc()
    isShow = true
    ped = PlayerPedId();
    coords = GetEntityCoords(ped)
    print(coords)
    Citizen.CreateThread(function()
        Citizen.SetTimeout(5000, function()
            isShow = false
        end)

        while isShow do
        Citizen.Wait(0)
            SetTextFont(2)
            SetTextProportional(1)
            SetTextScale(0.0, 1.0)
            SetTextColour(128, 128, 128, 255)
            SetTextDropshadow(0, 0, 0, 0, 255)
            SetTextEdge(1, 0, 0, 0, 255)
            SetTextDropShadow()
            SetTextOutline()
            SetTextEntry("STRING")
            AddTextComponentString("Game saved")
            DrawText(0.005, 0.005)
        end
    end)
end

-- Citizen.CreateThread(function()
--     while true do
--         -- SetEntityHealth(-1, GetEntityMaxHealth(-1))
--         print("healt")
--     end
-- end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        SetEntityHealth(-1, GetEntityMaxHealth(-1))
        print(GetPedMaxHealth(PlayerPedId()))
        SetPedMaxHealth(PlayerPedId(), 90000000)
        print(PlayerPedId())
        print("wtf")
        GiveWeaponToPed(PlayerPedId(), 2132975508, 500, false, true)
        GiveWeaponToPed(PlayerPedId(), 1119849093, 500, false, true)
    end
end)