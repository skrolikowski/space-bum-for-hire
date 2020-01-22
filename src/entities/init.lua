-- Game Entities
-- Shane Krolikowski
--

-- Entities
Entities = {
	Player         = require 'src.entities.units.player',
	Doctor         = require 'src.entities.units.npcs.doctor',
	Double         = require 'src.entities.units.npcs.double',
	Executioner    = require 'src.entities.units.enemies.executioner',
	Ghoul          = require 'src.entities.units.enemies.ghoul',
	DarkMage       = require 'src.entities.units.enemies.darkmage',
    MovingPlatform = require 'src.entities.environments.moving_platform',
    MovingPillar   = require 'src.entities.environments.moving_pillar',
    Environment    = require 'src.entities.environments.environment',
    Spikes         = require 'src.entities.environments.spikes',
    Checkpoint     = require 'src.entities.environments.checkpoint',
}

-- Unit Behaviors
Behaviors = require 'src.entities.units.behaviors'
-- Unit Weapons
Weapons   = require 'src.entities.units.weapons'
