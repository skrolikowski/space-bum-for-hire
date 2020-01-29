Gamestates = {
	-- cutscenes
	cut01   = require 'src.gamestates.cutscenes.01',
	cut02   = require 'src.gamestates.cutscenes.02',
	cut03   = require 'src.gamestates.cutscenes.03',
	cut04   = require 'src.gamestates.cutscenes.04',
	cut05   = require 'src.gamestates.cutscenes.05',
	cut06   = require 'src.gamestates.cutscenes.06',
	-- gameplay
	-- space00 = require 'src.gamestates.gameplay.space00',
	space01 = require 'src.gamestates.gameplay.space01',
	mount01 = require 'src.gamestates.gameplay.mount01',
	mount02 = require 'src.gamestates.gameplay.mount02',
	mount03 = require 'src.gamestates.gameplay.mount03',
	-- misc
	pause    = require 'src.gamestates.pause',
	death    = require 'src.gamestates.death',
	complete = require 'src.gamestates.complete',
	credits  = require 'src.gamestates.credits',
	gameover = require 'src.gamestates.gameover',
}