-- Game Entities
-- Shane Krolikowski
--

-- Entities
Entities = {
	Player         = require 'src.entities.units.player',
	Doctor         = require 'src.entities.units.npcs.doctor',
	Executioner    = require 'src.entities.units.enemies.executioner',
    MovingPlatform = require 'src.entities.environments.moving_platform',
    Environment    = require 'src.entities.environments.environment',
    Spikes         = require 'src.entities.environments.spikes',
}

-- Unit Behaviors
Behaviors = require 'src.entities.units.behaviors'
-- Unit Weapons
Weapons   = require 'src.entities.units.weapons'
