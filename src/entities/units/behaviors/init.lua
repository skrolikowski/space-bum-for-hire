-- Entity Behaviors
return {
	-- Doctor
    Doctor_attack = require 'src.entities.units.behaviors.npc.attack',
    Doctor_fall   = require 'src.entities.units.behaviors.npc.fall',
    Doctor_guard  = require 'src.entities.units.behaviors.npc.guard',
    Doctor_idle   = require 'src.entities.units.behaviors.npc.idle',
    Doctor_run    = require 'src.entities.units.behaviors.npc.run',
    Doctor_talk   = require 'src.entities.units.behaviors.npc.talk',
    Doctor_walk   = require 'src.entities.units.behaviors.npc.walk',
    -- Double
    Double_attack = require 'src.entities.units.behaviors.npc.attack',
    Double_fall   = require 'src.entities.units.behaviors.npc.fall',
    Double_guard  = require 'src.entities.units.behaviors.npc.guard',
    Double_idle   = require 'src.entities.units.behaviors.npc.idle',
    Double_run    = require 'src.entities.units.behaviors.npc.run',
    Double_talk   = require 'src.entities.units.behaviors.npc.talk',
    Double_walk   = require 'src.entities.units.behaviors.npc.walk',
    -- player
    Player_idle    = require 'src.entities.units.behaviors.player.idle',
    Player_die     = require 'src.entities.units.behaviors.player.die',
    Player_crouch  = require 'src.entities.units.behaviors.player.crouch',
    Player_standup = require 'src.entities.units.behaviors.player.standup',
    Player_jump    = require 'src.entities.units.behaviors.player.jump',
    Player_fall    = require 'src.entities.units.behaviors.player.fall',
    Player_run     = require 'src.entities.units.behaviors.player.run',
    Player_slide   = require 'src.entities.units.behaviors.player.slide',
    -- executioner
    Executioner_attack = require 'src.entities.units.behaviors.enemy.attack',
    Executioner_die    = require 'src.entities.units.behaviors.enemy.die',
    Executioner_fall   = require 'src.entities.units.behaviors.enemy.fall',
    Executioner_hurt   = require 'src.entities.units.behaviors.enemy.hurt',
    Executioner_idle   = require 'src.entities.units.behaviors.enemy.idle',
    Executioner_jump   = require 'src.entities.units.behaviors.enemy.jump',
    Executioner_run    = require 'src.entities.units.behaviors.enemy.run',

}