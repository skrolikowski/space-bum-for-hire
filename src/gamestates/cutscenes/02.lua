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
		Scott:say('left', 'Greetings. I am Commander Scott. Second in command of the startship Senturi, a research vessel.', 8)
		wait(8.5)
		Scott:say('left', 'I do not wish to bore you with details so I will get right into the situation.', 8)
		wait(8.5)
		Scott:say('left', 'We are an independent research team hired to find and study an unknown crystal on this planet.', 8)
		wait(8.5)
		Scott:worry('left', 2)
		wait(2)
		Scott:interrupt():say('left', 'Only problem is we weren\'t told there would be hostile life here as well.', 8)
		wait(6)
		Double:shock('right', 2, 'thought')
		wait(2.5)
		--
		-- Commander continues..
		Scott:say('left', 'Needless to say, we were attacked shortly after we split up...', 8)
		wait(8)
		Scott:interrupt():worry('left', 2)
		wait(2)
		Scott:interrupt():say('left', '...and Jenny, my soon to be wife, is among the away team I only pray she\'s okay.', 8)
		wait(6)
		Double:shock('right', 2)
		wait(2.5)
		--
		-- Player offers to help
		Double:explain('right', 2)
		wait(2)
		Double:okay('right', 1)
		wait(1)
		Scott:say('left', 'Thank you for helping us. We are but a research team without military training.', 8)
		wait(8.5)
		Double:explain('right', 2)
		wait(2)
		Double:huh('right', 2, 'speech')
		wait(2)
		Scott:say('left', 'The last crew member I saw was Ensign Victor. He went to explore a Castle structure to the East.', 8)
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