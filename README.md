# Cobra Modifications - Teleport Menu :star2:

A sleek and modern teleport menu system for FiveM servers with last location tracking and smooth UI.

## Features
- :dart: Preset teleport locations with emojis
- :game_die: Random location option
- :round_pushpin: Last location tracking
- :dizzy: Smooth UI transitions
- :zap: Auto-opens on first spawn only

## Installation
1. Place in your resources folder
2. Import SQL:
CREATE TABLE IF NOT EXISTS `player_last_location` (
  `identifier` varchar(50) NOT NULL,
  `last_x` float NOT NULL,
  `last_y` float NOT NULL,
  `last_z` float NOT NULL,
  PRIMARY KEY (`identifier`)
);

3. Add to server.cfg:
ensure teleport-menu
# Group Creation
add_ace group.teleport teleport.use allow

# Add Steam IDs to group (replace with actual Steam IDs)
add_principal identifier.steam:Hex-Here group.teleport
## Dependencies
- mysql-async

## Usage
- /spawn - Opens teleport menu
click the location you wish to go to !

## Support
Discord: [Cobra Modifications](https://discord.gg/GK4GAvaya7)
Version: 1.0.0

## License
© 2024 Cobra Modifications. All Rights Reserved.```


