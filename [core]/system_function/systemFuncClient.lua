right_text = ""

AddEventHandler("onClientGameTypeStart", function(source)
    TriggerServerEvent('EventManager:Server:getSaveLocation', source)
end)

RegisterNetEvent("clientSpawn")
AddEventHandler("clientSpawn", function(x, y, z)
    exports.spawnmanager:spawnPlayer({
        x = x,
        y = y,
        z = z,
        heading = 291.71,
        model = 'a_m_y_latino_01',
        skipFade = false
    })
    TriggerServerEvent("Qooz:server:system_function:getUserRole", GetPlayerServerId())
end)

RegisterCommand("clientRespawn", function(source, args)
    TriggerServerEvent('EventManager:Server:getSaveLocation', source)
end, false)

RegisterCommand("saveFunc", function(source, args)
    saveFunc(source)
end, false)

function saveFunc(source)
    ped = PlayerPedId();
    coords = GetEntityCoords(ped)
    print(coords)
    TriggerServerEvent('EventManager:Server:updateSaveLocation', source, coords)
    showText("Game save", 5000, false)
end

RegisterNetEvent("Qooz:client:system_function:setRoleDisplay")
AddEventHandler("Qooz:client:system_function:setRoleDisplay", function(role)
    right_text = role
end)

function showText(text, timeout, isRight)
    isShow = true
    Citizen.CreateThread(function()
        if timeout ~= -1 then
            Citizen.SetTimeout(timeout, function()
                isShow = false
            end)
        end


        while isShow do
        Citizen.Wait(0)
            SetTextRightJustify(isRight)
            SetTextFont(2)
            SetTextProportional(1)
            SetTextScale(0.0, 2.0)
            SetTextColour(128, 128, 128, 255)
            SetTextDropshadow(0, 0, 0, 0, 255)
            SetTextEdge(1, 0, 0, 0, 255)
            SetTextDropShadow()
            SetTextOutline()
            SetTextEntry("STRING")
            AddTextComponentString(text)
            DrawText(0.005, 0.005)
        end
    end)
end

Citizen.CreateThread(function()
    while true do
    Citizen.Wait(0)
        SetTextRightJustify(true)
        SetTextFont(2)
        SetTextProportional(1)
        SetTextScale(0.0, 2.0)
        SetTextColour(128, 128, 128, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(1, 0, 0, 0, 255)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        AddTextComponentString(right_text)
        DrawText(0.005, 0.005)
    end
end)