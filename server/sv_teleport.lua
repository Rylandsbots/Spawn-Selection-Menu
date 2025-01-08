MySQL = exports['mysql-async']

RegisterServerEvent('teleport:saveLastLocation')
AddEventHandler('teleport:saveLastLocation', function(coords)
    local identifier = GetPlayerIdentifier(source, 0)
    
    MySQL.query('INSERT INTO player_last_location (identifier, last_x, last_y, last_z) VALUES (@identifier, @x, @y, @z) ON DUPLICATE KEY UPDATE last_x = @x, last_y = @y, last_z = @z', {
        ['@identifier'] = identifier,
        ['@x'] = coords.x,
        ['@y'] = coords.y,
        ['@z'] = coords.z
    })
end)

RegisterServerEvent('teleport:getLastLocation')
AddEventHandler('teleport:getLastLocation', function()
    local source = source
    local identifier = GetPlayerIdentifier(source, 0)
    
    exports['mysql-async']:mysql_fetch_all('SELECT last_x, last_y, last_z FROM player_last_location WHERE identifier = @identifier', {
        ['@identifier'] = identifier
    }, function(result)
        if result[1] then
            TriggerClientEvent('teleport:receiveLastLocation', source, {
                x = result[1].last_x,
                y = result[1].last_y,
                z = result[1].last_z
            })
        end
    end)
end)

AddEventHandler('playerDropped', function(reason)
    local source = source
    local identifier = GetPlayerIdentifier(source, 0)
    local playerPed = GetPlayerPed(source)
    local lastPos = GetEntityCoords(playerPed)
    
    exports['mysql-async']:mysql_execute('INSERT INTO player_last_location (identifier, last_x, last_y, last_z) VALUES (@identifier, @x, @y, @z) ON DUPLICATE KEY UPDATE last_x = @x, last_y = @y, last_z = @z', {
        ['@identifier'] = identifier,
        ['@x'] = lastPos.x,
        ['@y'] = lastPos.y,
        ['@z'] = lastPos.z
    })
end)

RegisterServerEvent('teleport:checkSpawnCommand')
AddEventHandler('teleport:checkSpawnCommand', function()
    local source = source
    local identifiers = GetPlayerIdentifiers(source)
    local steamId = nil
    
    for _, identifier in pairs(identifiers) do
        if string.find(identifier, "steam:") then
            steamId = identifier
            break
        end
    end
    
    print("Steam ID Found:", steamId)
    print("Checking permission for:", "identifier."..steamId)
    
    local hasPermission = not Config.Settings.requirePermissions or IsPlayerAceAllowed(source, Config.Settings.permissionGroup..".use")
    TriggerClientEvent('teleport:permissionResponse', source, hasPermission)
end)
