local display = false
local client_id = -1

-- RegisterKeyMapping('nui', 'show nui', 'keyboard', 'N')

AddEventHandler("Qooz:client:select_role:openCloseDialog", function(source, args)
    SetDisplay(not display)
    if client_id == -1 then
        client_id = source
    end
    
end)

--very important cb 
RegisterNUICallback("exit", function(data)
    chat("exited", {0,255,0})
    SetDisplay(false)
end)

-- this cb is used as the main route to transfer data back 
-- and also where we hanld the data sent from js
RegisterNUICallback("main", function(data, cb)
    chat("Your role is ".. data.role, {0,255,0})
    TriggerServerEvent("Qooz:server:selectRole", GetPlayerServerId(), data.role)
    TriggerEvent("Qooz:client:system_function:setRoleDisplay", data.role)
    -- result = TriggerServerEvent("Qooz:server:getAllRole")
    SetDisplay(false)
end)

RegisterNUICallback("error", function(data)
    chat(data.error, {255,0,0})
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

RegisterNetEvent("Qooz:client")