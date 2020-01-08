
--

Spawner = require 'src.world.spawner'
World   = require 'src.world.world'

-- Dialogue
-- Narrate story and add humor to the game :)
Dialogue = {
	-- narration = require 'src.world.dialogue.narration',
	speech    = require 'src.world.dialogue.speech',
	comment   = require 'src.world.dialogue.comment',
	emote     = require 'src.world.dialogue.emote',
}

-- Effects
-- Non-interactive sprite animations to add flare!
Effects = {
	explosion1 = require 'src.world.effects.explosion',
	explosion2 = require 'src.world.effects.explosion_short',
	flame1     = require 'src.world.effects.flame_continously',
	flame2     = require 'src.world.effects.flame_pulse',
	warp       = require 'src.world.effects.warp',
}

-- Events
-- Actions that shape the world and it's entities (e.g. moving platforms)
Events = {
	PlayerEnter = require 'src.world.events.player_enter',
	Boomarang   = require 'src.world.events.boomarang',
	Translate   = require 'src.world.events.translate',
}

-- Sensors
-- Interact with world entities in various ways (e.g. cause/receive damage)
-- May or may not be fixture of Entity (e.g. projectile)
Sensors = {
	hitbox     = require 'src.world.sensors.hitbox',
	sight      = require 'src.world.sensors.sight',
	strike     = require 'src.world.sensors.strike',
	dispatcher = require 'src.world.sensors.dispatcher',	
	projectile = require 'src.world.sensors.projectile',
}