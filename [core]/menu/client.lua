local display = false
local client_id = -1
local finishWork = false
local markerStatus = "idle"
local userWorkingTime = 0

RegisterCommand("Qooz:client:menu:showDialog", function(source, args)
    print("wtffff menu")
    SetDisplay(not display)
    if client_id == -1 then
        client_id = source
    end
end, false)

--very important cb 
RegisterNUICallback("exit", function(data)
    SetDisplay(false)
end)

-- this cb is used as the main route to transfer data back 
-- and also where we hanld the data sent from js
RegisterNUICallback("main", function(data, cb)
    chat(data.menu, {255, 0, 0})
    if data.menu == "save" then
        TriggerEvent("saveFunc")
    elseif data.menu == "respawn" then
        chat("respawnnn", {255, 0, 0})
        TriggerEvent("clientRespawn")
    elseif data.menu == "select_role" then
        TriggerEvent("Qooz:client:select_role:openCloseDialog")
    else 
        chat("Something went wrong", {255, 0, 0})
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