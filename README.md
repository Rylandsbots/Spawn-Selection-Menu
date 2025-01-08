# Cobra Modifications - Teleport Menu 🌟

A sleek and modern teleport menu system for FiveM servers with last location tracking and smooth UI.

## Features
- 🎯 Preset teleport locations with emojis
- 🎲 Random location option
- 📍 Last location tracking
- 💫 Smooth UI transitions
- ⚡ Auto-opens on first spawn only

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

## Dependencies
- mysql-async

## Usage
- /spawn - Opens teleport menu
- ESC - Closes menu

## Support
Discord: [Your Discord]
Version: 1.0.0

## License
© 2024 Cobra Modifications. All Rights Reserved.```
