-- Entity Behaviors
return {
	-- Doctor/NPC
    Doctor_fall    = require 'src.entities.units.behaviors.npc.fall',
    Doctor_flee    = require 'src.entities.units.behaviors.npc.flee',
    Doctor_guard   = require 'src.entities.units.behaviors.npc.guard',
    Doctor_idle    = require 'src.entities.units.behaviors.npc.idle',
    Doctor_attack  = require 'src.entities.units.behaviors.npc.attack',
    Doctor_talk    = require 'src.entities.units.behaviors.npc.talk',
    Doctor_walk    = require 'src.entities.units.behaviors.npc.walk',
    -- player
    Player_idle    = require 'src.entities.units.behaviors.player.idle',
    Player_crouch  = require 'src.entities.units.behaviors.player.crouch',
    Player_standup = require 'src.entities.units.behaviors.player.standup',
    Player_jump    = require 'src.entities.units.behaviors.player.jump',
    Player_fall    = require 'src.entities.units.behaviors.player.fall',
    Player_run     = require 'src.entities.units.behaviors.player.run',
    Player_slide   = require 'src.entities.units.behaviors.player.slide',
    -- executioner
    Executioner_attack = require 'src.entities.units.behaviors.executioner.attack',
    Executioner_die    = require 'src.entities.units.behaviors.executioner.die',
    Executioner_fall   = require 'src.entities.units.behaviors.executioner.fall',
    Executioner_hurt   = require 'src.entities.units.behaviors.executioner.hurt',
    Executioner_idle   = require 'src.entities.units.behaviors.executioner.idle',
    Executioner_jump   = require 'src.entities.units.behaviors.executioner.jump',
    Executioner_chase  = require 'src.entities.units.behaviors.executioner.chase',

}