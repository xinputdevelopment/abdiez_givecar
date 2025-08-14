if GetCurrentResourceName() ~= "abdiez_geimport" then
    print("^1The resource must be named 'abdiez_geimport' to work correctly.^0")
    while true do
        Wait(3000)
        print("^1The resource must be named 'abdiez_geimport' to work correctly.^0")
    end
    return
end

ESX = exports['es_extended']:getSharedObject()

local function generatePlate()
    local letters, numbers = "", ""
    for i = 1, 3 do letters = letters .. string.char(math.random(65, 90)) end
    for i = 1, 3 do numbers = numbers .. tostring(math.random(0, 9)) end
    return letters .. numbers
end

local function get_license(playerId)
    local identifiers = GetPlayerIdentifiers(playerId)
    for _, id in ipairs(identifiers) do
        if string.sub(id, 1, 8) == "license:" then
            return id
        end
    end
    return nil
end

RegisterCommand("givecar", function(source, args)
    local adminSrc = source
    local license = get_license(adminSrc)

    if not license then
        TriggerClientEvent('esx:showNotification', adminSrc, '⛔ Could not read your license identifier.')
        return
    end

    local allowed = false
    for _, v in pairs(Config.Personer) do
        if v == license then
            allowed = true
            break
        end
    end

    if not allowed then
        TriggerClientEvent('esx:showNotification', adminSrc, '⛔ You do not have permission to use this command.')
        return
    end

    local targetId = tonumber(args[1])
    local modelName = args[2]

    if not targetId or not modelName then
        TriggerClientEvent('esx:showNotification', adminSrc, '❌ Usage: /givecar [id] [model]')
        return
    end

    local xPlayer = ESX.GetPlayerFromId(targetId)
    if not xPlayer then
        TriggerClientEvent('esx:showNotification', adminSrc, '❌ Player not found.')
        return
    end

    local plate = generatePlate()
    local hash = GetHashKey(modelName)

    local vehicleProps = {
        model = hash,
        plate = plate,
        fuelLevel = 100.0,
        bodyHealth = 1000.0,
        engineHealth = 1000.0
    }

    MySQL.insert('INSERT INTO owned_vehicles (owner, plate, vehicle, type, stored) VALUES (?, ?, ?, ?, ?)', {
        xPlayer.identifier,
        plate,
        json.encode(vehicleProps),
        'car',
        1
    }, function()
        TriggerClientEvent('esx:showNotification', adminSrc, '✅ Added ' .. modelName .. ' to ID ' .. targetId .. "'s garage with plate " .. plate .. '.')
        TriggerClientEvent('esx:showNotification', targetId, '🚗 You received a ' .. modelName .. ' with plate ' .. plate .. ' in your garage!')
    end)
end, false)

RegisterNetEvent('abdiez_sparafordon')
AddEventHandler('abdiez_sparafordon', function(vehicleProps, adminSrc)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)

    MySQL.insert('INSERT INTO owned_vehicles (owner, plate, vehicle, type, stored) VALUES (?, ?, ?, ?, ?)', {
        xPlayer.identifier,
        vehicleProps.plate,
        json.encode(vehicleProps),
        'car',
        1
    }, function()
        TriggerClientEvent('esx:showNotification', adminSrc, '✅ Vehicle with plate ' .. vehicleProps.plate .. " was added to ID " .. src .. "'s garage.")
    end)
end)
