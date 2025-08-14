if GetCurrentResourceName() ~= "abdiez_geimport" then
    print("^1The resource must be named 'abdiez_geimport' to work correctly.^0")
    while true do
        Wait(3000)
        TriggerEvent('chat:addMessage', {
            color = {255, 0, 0},
            multiline = true,
            args = {"^1The resource must be named 'abdiez_geimport' to work correctly.^0"}
        })
    end
    return
end

ESX = exports['es_extended']:getSharedObject()

RegisterNetEvent('abdiez_importerafordon')
AddEventHandler('abdiez_importerafordon', function(model, adminSrc)
    local playerPed = PlayerPedId()
    local coords = GetEntityCoords(playerPed)
    local heading = GetEntityHeading(playerPed)

    ESX.Game.SpawnVehicle(model, coords, heading, function(vehicle)
        local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
        local plate = string.upper(randomLetters(3) .. randomNumbers(3))
        SetVehicleNumberPlateText(vehicle, plate)
        vehicleProps.plate = plate
        TriggerServerEvent('abdiez_sparafordon', vehicleProps, adminSrc)
        ESX.ShowNotification("🚗 Vehicle has been added to your garage. Plate: " .. plate)
        DeleteVehicle(vehicle)
    end)
end)

function randomLetters(length)
    local result = ""
    for i = 1, length do
        result = result .. string.char(math.random(65, 90))
    end
    return result
end

function randomNumbers(length)
    local result = ""
    for i = 1, length do
        result = result .. tostring(math.random(0, 9))
    end
    return result
end

TriggerEvent('chat:addSuggestion', '/geimport', 'Import a vehicle into a player\'s garage', {
    { name = 'id', help = 'Player\'s server ID' },
    { name = 'model', help = 'Vehicle model name (e.g., sultan)' }
})
