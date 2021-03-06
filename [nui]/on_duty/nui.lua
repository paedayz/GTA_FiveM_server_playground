local display = false
local client_id = -1
local finishWork = false
local markerStatus = "idle"
local userWorkingTime = 0

AddEventHandler("Qooz:onDuty:showDialog", function(source, args)
    SetDisplay(true)
    if client_id == -1 then
        client_id = source
    end
end)

AddEventHandler("Qooz:onDuty:closeDialog", function(source, args)
    SetDisplay(false)
    if client_id == -1 then
        client_id = source
    end
end)

--very important cb 
RegisterNUICallback("exit", function(data)
    SetDisplay(false)
end)

-- this cb is used as the main route to transfer data back 
-- and also where we hanld the data sent from js
RegisterNUICallback("main", function(data, cb)
    if data.ans then
        chat("Do your duty", {0,255,0})
        markerStatus = "work"
        -- ped = GetPlayerPed(-1)
        -- pedId = PlayerPedId()
        -- chat(PlayerId(), {255, 0, 0})
        -- chat(PlayerPedId(), {255, 0, 0})
        -- chat(GetPlayerServerId(), {255, 0, 0})
        TriggerServerEvent("Qooz:server:on_duty:getUserRole", GetPlayerServerId())
    else 
        chat("Just free", {255 ,255, 255})
    end
    SetDisplay(false)
end)

RegisterNUICallback("error", function(data)
    SetDisplay(false)
end)

function SetDisplay(bool)
    display = bool
    SetNuiFocus(bool, bool)
    SendNUIMessage({
        type = "ui",
        status = bool,
    })
    
end

Citizen.CreateThread(function()
    while display do
        Citizen.Wait(0)
        -- https://runtime.fivem.net/doc/natives/#_0xFE99B66D079CF6BC
        --[[ 
            inputGroup -- integer , 
	        control --integer , 
            disable -- boolean 
        ]]
        DisableControlAction(0, 1, display) -- LookLeftRight
        DisableControlAction(0, 2, display) -- LookUpDown
        DisableControlAction(0, 142, display) -- MeleeAttackAlternate
        DisableControlAction(0, 18, display) -- Enter
        DisableControlAction(0, 322, display) -- ESC
        DisableControlAction(0, 106, display) -- VehicleMouseControlOverride
    end
end)

function chat(str, color)
    TriggerEvent(
        'chat:addMessage',
        {
            color = color,
            multiline = true,
            args = {str}
        }
    )
end


RegisterNetEvent("Qooz:client:on_duty:setRoleModel")
    
AddEventHandler("Qooz:client:on_duty:setRoleModel", function(role, workingTime)
    if role == "police" then
        model = "s_m_y_cop_01"
    elseif role == "mechanic" then 
        model = "mp_m_waremech_01"
    elseif role == "farmer" then
        model = "a_m_m_hillbilly_01"
    else 
        model = "csb_money"
    end

    userWorkingTime = workingTime

    ped = GetPlayerPed(-1)
    coords = GetEntityCoords(ped)

    TriggerEvent("clientSpawn", coords.x, coords.y, coords.z, model)

    Citizen.SetTimeout(userWorkingTime * 1000, function()
        markerStatus = "finish"
    end)
end)

CreateThread(function() 
    while true do
        if(markerStatus == "work" and userWorkingTime > 0) then
            userWorkingTime = userWorkingTime - 1
        end
        Citizen.Wait(1000)
    end
end)

CreateThread(function() 
    while true do
        Citizen.Wait(0)
        if(markerStatus == "work" and userWorkingTime > 0) then
            SetTextFont(2)
            SetTextProportional(1)
            SetTextScale(0.0, 2.0)
            SetTextColour(128, 128, 128, 255)
            SetTextDropshadow(0, 0, 0, 0, 255)
            SetTextEdge(1, 0, 0, 0, 255)
            SetTextDropShadow()
            SetTextOutline()
            SetTextEntry("STRING")
            AddTextComponentString(userWorkingTime)
            DrawText(0.005, 0.005)
        end
    end
end)

CreateThread(function()
    isOpen = false
    green = 0
    red = 255
    justFinish = false
    
	while true do
		-- draw every frame
		Citizen.Wait(0)

		local pedCoords = GetEntityCoords(PlayerPedId())

        if math.abs(pedCoords.x - 1462.6295166015625) <= 1 
           and math.abs(pedCoords.y - 6545.54736328125) <= 1 then 

            if markerStatus == "idle" then 

                if isOpen == false then 
                    TriggerEvent("Qooz:onDuty:showDialog")
                    isOpen = true
                end
            elseif markerStatus == "finish" and justFinish == false  then 
                TriggerEvent("clientSpawn", 
                1459.6295166015625,
                6545.54736328125,
                14.433249473571777 - 0.8, 
                "csb_money")

                justFinish = true

                Citizen.SetTimeout(1000, function()
                    markerStatus = "idle"
                    justFinish = false
                end)
                
                chat("finish your work", {0, 255, 0})
            end
        else 
            if isOpen == true then
                TriggerEvent("Qooz:onDuty:closeDialog")
                isOpen = false
            end
        end
        
        if markerStatus == "idle" then 
            red = 255
            green = 255
        elseif markerStatus == "work" then
            red = 255
            green = 0
        else
            red = 0
            green = 255
        end

		DrawMarker(
            23,
            1462.6295166015625,
            6545.54736328125,
            14.433249473571777 - 0.8,
            0.0,
            0.0,
            0.0,
            0.0,
            180.0,
            0.0,
            2.0,
            2.0,
            2.0,
            red,
            green,
            0,
            150,
            false,
            true,
            2,
            nil,
            nil,
            false)
	end
end)