-- Cutscene 04
-- Meeting the Captain
--

local Base  = require 'src.gamestates.cutscenes.cutscene'
local Cut04 = Base:extend()

function Cut04:init()
	Base.init(self, {
		name = 'Cut04',
		map  = Config.world.maps['cut04'],
	})
	--
	-- foreground canvas
	self.foreground = lg.newCanvas(self.width, self.height)
	lg.setCanvas(self.foreground)
		self.map:drawTileLayer('Foreground')
	lg.setCanvas()

	-- background canvas
	self.background = lg.newCanvas(self.width, self.height)
	lg.setCanvas(self.background)
		self.map:drawTileLayer('Background')
		self.map:drawTileLayer('Sharp Cliffs')
		self.map:drawTileLayer('Decoratives (BG)')
		self.map:drawTileLayer('Castle')
		self.map:drawTileLayer('Cliffs')
		self.map:drawTileLayer('Decoratives (MG)')
		self.map:drawTileLayer('Platforms')
	lg.setCanvas()
end

-- Enter Scene
--
function Cut04:enter(from, ...)
	Base.enter(self, from, ...)
	--
	-- Casting Call ---------------
	local Double, Captain
	
	Double = Entities['Double']({
		x          = Config.tileSize * 10,
		y          = Config.tileSize * 14,
		width      = 80,
		height     = 80,
		isMirrored = true,
	})
	Captain = Entities['Captain']({
		name   = 'Captain',
		x      = Config.tileSize * 19,
		y      = Config.tileSize * 14,
		width  = 80,
		height = 80,
	}):interrupt()

	-- ACTION!!! ------------------
    self.timer:script(function(wait)
    	-- Player & Captain enter scene..
		Double:huh('left', 1)
		wait(1.5)
		Double:interrupt():worry('right', 1)
		Captain:move('left', 350, 2)
		wait(2.5)
		--
		-- Player & Captain meet..
		Captain:say('left', 'Oh! Thank goodness!!', 3)
		wait(3)
		Captain:interrupt():shock('left', 1)
		wait(1.5)
		Captain:say('left', 'Wait.. who are you? I don\'t recognize you.', 5)
		wait(4)
		Double:explain('right', 3)
		wait(3.5)
		Captain:say('left', 'Ensign Victor sent you? So he is okay. Well that\'s good.', 5)
		wait(6)
		--
		-- Captain tells Player about cave..
		Captain:say('left', 'Listen, I know you aren\'t a crew member, but I need your help.', 5)
		wait(4.5)
		Double:huh('right', 2)
		wait(2.5)
		Captain:say('left', 'I went to explore that cave, but accidently dropped the dilitium crystals I was carrying.', 6)
		wait(6.5)
		Captain:say('left', 'There is a terrible monster in there and I had to retreat, but with the two of us...', 6)
		wait(4.5)
		Double:shock('right', 2)
		wait(2)
		--
		-- Player shares idea..
		Double:interrupt():huh('right', 2, 'speech')
		wait(2.5)
		Captain:say('left', 'Of course! We can help you get home, but without the crystals we can\'t even power our ship.', 6.5)
		wait(5.5)
		Double:interrupt():okay('right', 2)
		wait(2.5)
		Captain:happy('left', 3)
		wait(3.5)
		Captain:interrupt():say('left', 'Great! Let me know when you\'re ready and I\'ll be right behind you.', 6)
		wait(6.5)
		--
		-- ~ fin ~
		self:skip()
	end)
	-- CUT!!! ---------------------
end

return Cut04