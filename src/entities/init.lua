-- Game Entities
-- Shane Krolikowski
--

-- Shapes
Shapes = {
	rectangle = require 'src.entities.shapes.rectangle',
	polygon   = require 'src.entities.shapes.polygon',
	edge      = require 'src.entities.shapes.edge',
	circle    = require 'src.entities.shapes.circle',
}

-- Entities
Entities = {
	Player         = require 'src.entities.player',
    MovingPlatform = require 'src.entities.environments.moving_platform',
    Environment    = require 'src.entities.environments.environment',
    Spikes         = require 'src.entities.environments.spikes',
}

-- Entity Behaviors
Behaviors = {
    idle    = require 'src.entities.behaviors.idle',
    crouch  = require 'src.entities.behaviors.crouch',
    standup = require 'src.entities.behaviors.standup',
    jump    = require 'src.entities.behaviors.jump',
    fall    = require 'src.entities.behaviors.fall',
    run     = require 'src.entities.behaviors.run',
    slide   = require 'src.entities.behaviors.slide',
}

-- Entity Weapons
Weapons = {
    pistol = require 'src.entities.weapons.pistol'
}

-- Entity Weapon Rounds
WeaponRounds = {
    pistol = require 'src.entities.rounds.pistol'
}
Contact = require 'src.entities.rounds.contact'