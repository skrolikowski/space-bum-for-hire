-- Cutscene 02
-- Meeting w/ Commander Scott
--

local Base  = require 'src.gamestates.cutscenes.cutscene'
local Cut02 = Base:extend()
local Double, Scott

function Cut02:init()
	Base.init(self, {
		name = 'Cut02',
		id   = 'cut02',
		map  = Config.world.maps['cut02'],
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
function Cut02:enter(from, ...)
	Base.enter(self, from, ...)
	--
	-- Casting Call ---------------
	Double = Entities['Double']({
		title   = 'Player',
		x       = Config.tileSize * 11,
		y       = Config.tileSize * 12,
		width   = Config.spawn.width,
		height  = Config.spawn.height,
		visible = true
	}):interrupt()
	Scott = Entities['Ensign']({
		title   = 'Commander Scott',
		x       = Config.tileSize * 20,
		y       = Config.tileSize * 12,
		width   = Config.spawn.width,
		height  = Config.spawn.height,
		visible  = true,
		isMirrored = true,
	}):interrupt()

	-- ACTION!!! ------------------
    self.timer:script(function(wait)
    	--
    	-- Player & Captain enter scene..
		Scott:move('left', 350, 2)
		wait(2.5)
		--
		-- Commander fills in Player..
		Scott:say('left', 'Thank goodness you\'re here. The Captain is missing, we\'re out of fuel...', 6)
		wait(4)
		Double:shock('right', 2)
		wait(2)
		Scott:interrupt():worry('left', 1)
		wait(1)
		Scott:interrupt():say('left', 'I appologize. I haven\'t even introduced myself.. I\'m Commander Scott. Second in command of the startship Senturi.', 8)
		wait(8.5)
		Scott:interrupt():say('left', 'We are in quite the pickle. Resources are low and part of the crew is somewhere on this planet.', 8)
		wait(8.5)
		Scott:interrupt():say('left', 'We are but a research crew. We aren\'t equipped for such harsh conditions.', 8)
		wait(8.5)
		--
		-- Player asks to get to business..
		Double:greed('right', 2)
		wait(2)
		Scott:interrupt():say('left', 'Of course, we are a people of our word. You will be compensated for your work.', 8)
		wait(8.5)
		Double:okay('right', 2)
		wait(2)
		Scott:happy('left', 2)
		wait(2.5)
		--
		-- Next steps..
		Scott:say('left', 'The last crew member I saw was Ensign Victor. He went to explore the structure to the east.', 8)
		wait(8.5)
		Double:okay('right', 2)
		wait(2.5)
		--
		-- ~ fin ~
		self:complete()
	end)
	-- CUT!!! ---------------------
end

-- Tear down
--
function Cut02:complete()
	Base.complete(self)
	--
	Double:destroy()
	Scott:destroy()
	
	--
	Gamestate.pop()
end

return Cut02