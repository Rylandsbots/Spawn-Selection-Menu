local menuOpen = false
local lastLocation = nil
local hasShownMenu = false

RegisterNetEvent('teleport:receiveLastLocation')
AddEventHandler('teleport:receiveLastLocation', function(coords)
    if coords and coords.x and coords.y and coords.z then
        lastLocation = {
            name = Config.UI.lastLocationText,
            x = coords.x,
            y = coords.y,
            z = coords.z
        }
    end
end)

function OpenTeleportMenu()
    menuOpen = true
    SetNuiFocus(true, true)
    
    local elements = {}
    
    -- Add last location first if available
    if lastLocation then
        table.insert(elements, {
            label = lastLocation.name,
            value = {x = lastLocation.x, y = lastLocation.y, z = lastLocation.z}
        })
    end
    
    -- Add predefined locations
    for _, loc in ipairs(Config.Locations) do
        table.insert(elements, {
            label = loc.name,
            value = {x = loc.x, y = loc.y, z = loc.z}
        })
    end
    
    -- Add random option last
    table.insert(elements, {
        label = Config.UI.randomOptionText,
        value = "random"
    })
    
    SendNUIMessage({
        type = "openMenu",
        locations = elements,
        title = Config.UI.title
    })
end
AddEventHandler('playerSpawned', function()
    if not hasShownMenu then
        TriggerServerEvent('teleport:getLastLocation')
        Wait(Config.LoadingDelay)
        OpenTeleportMenu()
        hasShownMenu = true
    end
end)

RegisterNUICallback('teleport', function(data, cb)
    if data.location == "random" then
        local randomLoc = Config.Locations[math.random(#Config.Locations)]
        SetEntityCoords(PlayerPedId(), randomLoc.x, randomLoc.y, randomLoc.z)
    else
        SetEntityCoords(PlayerPedId(), data.location.x, data.location.y, data.location.z)
    end
    
    menuOpen = false
    SetNuiFocus(false, false)
    SendNUIMessage({
        type = "closeMenu"
    })
    
    TriggerEvent('chat:addMessage', {
        color = Config.UI.messageColor,
        multiline = true,
        args = {Config.UI.messagePrefix, Config.UI.successMessage}
    })
    
    cb('ok')
end)

RegisterNUICallback('closeMenu', function(data, cb)
    menuOpen = false
    SetNuiFocus(false, false)
    cb('ok')
end)

RegisterCommand('spawn', function()
    TriggerServerEvent('teleport:checkSpawnCommand')
end, false)

AddEventHandler('playerSpawned', function()
    if not hasShownMenu then
        TriggerServerEvent('teleport:checkSpawnCommand')
        hasShownMenu = true
    end
end)

RegisterNetEvent('teleport:permissionResponse')
AddEventHandler('teleport:permissionResponse', function(hasPermission)
    if hasPermission then
        TriggerServerEvent('teleport:getLastLocation')
        Wait(1000)
        OpenTeleportMenu()
    end
end)