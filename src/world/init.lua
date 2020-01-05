
--

Spawner = require 'src.world.spawner'
World   = require 'src.world.world'

Dialogue = {
	comment = require 'src.world.dialogue.comment',
	emote   = require 'src.world.dialogue.emote',
}

-- Events
Events = {
	PlayerEnter = require 'src.world.events.player_enter',
	Dialogue    = require 'src.world.events.dialogue',
	Move        = require 'src.world.events.move',
	Call        = require 'src.world.events.call',
}

Sensors = {
	hitbox     = require 'src.world.sensors.hitbox',
	sight      = require 'src.world.sensors.sight',
	strike     = require 'src.world.sensors.strike',
	dispatcher = require 'src.world.sensors.dispatcher',	
	projectile = require 'src.world.sensors.projectile',
}