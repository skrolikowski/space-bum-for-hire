
--

Spawner = require 'src.world.spawner'
World   = require 'src.world.world'

Dialogue = {
	comment = require 'src.world.dialogue.dialogue',
	emote   = require 'src.world.dialogue.emote',
}

-- Events
Events = {
	PlayerEnter = require 'src.world.events.player_enter',
	Move        = require 'src.world.events.move',
}

Sensors = {
	hitbox     = require 'src.world.sensors.hitbox',
	sight      = require 'src.world.sensors.sight',
	strike     = require 'src.world.sensors.strike',
	flagger    = require 'src.world.sensors.flagger',	
	projectile = require 'src.world.sensors.projectile',
}