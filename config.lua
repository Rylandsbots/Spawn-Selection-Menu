Config = {}

-- Teleport Locations
Config.Locations = {
    {name = "🌟 Maze Bank", x = -75.015, y = -818.215, z = 326.176},
    {name = "🏖️ Beach", x = -1712.37, y = -1082.91, z = 13.027},
    {name = "🎡 Pier", x = -1605.03, y = -1039.35, z = 13.017},
    {name = "🏔️ Mount Chiliad", x = 495.969, y = 5586.44, z = 794.184},
    {name = "🎰 Casino", x = 935.946, y = 47.063, z = 81.095},
    {name = "🌳 Vinewood Sign", x = 785.979, y = 1175.523, z = 345.214}
}

-- UI Settings
Config.UI = {
    title = "🌎 Teleport Menu",
    randomOptionText = "🎲 Random Location",
    lastLocationText = "📍 Last Location",
    successMessage = "Teleported successfully! Use /spawn to open the menu again.",
    messageColor = {255, 100, 100},
    messagePrefix = "Teleport"
}

-- Commands
Config.Commands = {
    openMenu = "spawn"
}

-- Settings
Config.Settings = {
    requirePermissions = true,
    permissionGroup = "teleport",
    LoadingDelay = 1000
}

return Config
