local display = false
local client_id = -1

AddEventHandler("Qooz:onDuty:showDialog", function(source, args)
    SetDisplay(true)
    if client_id == -1 then
        client_id = source
    end

    -- chat("testtt", {255, 0, 0})
    -- chat("op234234en", {0, 255, 0})
    
end)

AddEventHandler("Qooz:onDuty:closeDialog", function(source, args)
    SetDisplay(false)
    if client_id == -1 then
        client_id = source
    end

    -- chat("clxcvose", {0, 0, 0})
    
end)

--very important cb 
RegisterNUICallback("exit", function(data)
    chat("wthhhh", {0,255,0})
    SetDisplay(false)
end)

-- this cb is used as the main route to transfer data back 
-- and also where we hanld the data sent from js
RegisterNUICallback("main", function(data, cb)
    if data.ans then
        chat("Do your duty", {0,255,0})
    else 
        chat("Just free", {255 ,255, 255})
    end
    -- TriggerServerEvent("Qooz:server:selectRole", client_id, data.role)
    -- TriggerEvent("Qooz:client:system_function:setRoleDisplay", data.role)
    -- result = TriggerServerEvent("Qooz:server:getAllRole")
    SetDisplay(false)
end)

RegisterNUICallback("error", function(data)
    chat("wtffff", {255,0,0})
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