-- Cutscene 03
-- Rescue Ensign Victor
--

local Base  = require 'src.gamestates.cutscenes.cutscene'
local Cut03 = Base:extend()
local Double, Victor

function Cut03:init()
	Base.init(self, {
		name = 'Cut03',
		id   = 'cut03',
		map  = Config.world.maps['cut03'],
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
		self.map:drawTileLayer('Decoratives (BG)')
		self.map:drawTileLayer('Castle')
		self.map:drawTileLayer('Decoratives (MG)')
		self.map:drawTileLayer('Platforms')
	lg.setCanvas()
end

-- Enter Scene
--
function Cut03:enter(from, ...)
	Base.enter(self, from, ...)
	--
	-- Casting Call ---------------
	Double = Entities['Double']({
		title   = 'Player',
		x       = Config.tileSize * 12,
		y       = Config.tileSize * 14,
		width   = Config.spawn.width,
		height  = Config.spawn.height,
		visible = true
	})
	Victor = Entities['Ensign']({
		title   = 'Ensign Victor',
		x       = Config.tileSize * 18,
		y       = Config.tileSize * 14,
		width   = Config.spawn.width,
		height  = Config.spawn.height,
		visible  = true,
		isMirrored = true,
	}):interrupt()

	-- ACTION!!! ------------------
    self.timer:script(function(wait)
    	--
    	-- Player & Captain enter scene..
    	Double:huh('right', 2)
    	Victor:shock('left', 2)
    	wait(2)
		--
		-- Ensign Victor is caught off guard..
		Victor:interrupt():say('left', 'Yikes! You have an interesting approach to entering a room..', 6)
		wait(4)
		Double:huh('right', 2)
		wait(2.5)
		Victor:interrupt():say('left', 'Clarence sent you, didn\'t he. Tell him I didn\'t eat his lunch!', 6)
		wait(4)
		Double:shock('right', 2)
		wait(2.5)
		--
		-- Player is here to save the day!
		Double:explain('right', 3)
		wait(2.5)
		Victor:happy('left', 2)
		wait(2.5)
		--
		-- Ensign is on board..
		Victor:say('left', 'Oh! The Commander sent you? No, I haven\'t seen the Captain.', 6)
		wait(6.5)
		Victor:say('left', 'However, B.', 6)
		wait(6.5)
		-- Double:shock('right', 2)
		-- wait(2)
		-- Scott:interrupt():worry('left', 1)
		-- wait(1)
		-- Scott:interrupt():say('left', 'I appologize. I haven\'t even introduced myself.. I\'m Commander Scott. Second in command of the startship Senturi.', 8)
		-- wait(8.5)
		-- Scott:interrupt():say('left', 'We are in quite the pickle. Resources are low and part of the crew is somewhere on this planet.', 8)
		-- wait(8.5)
		-- Scott:interrupt():say('left', 'We are but a research crew. We aren\'t equipped for such harsh conditions.', 8)
		-- wait(8.5)
		-- --
		-- -- Player asks to get to business..
		-- Double:greed('right', 2)
		-- wait(2)
		-- Scott:interrupt():say('left', 'Of course, we are a people of our word. You will be compensated for your work.', 8)
		-- wait(8.5)
		-- Double:okay('right', 2)
		-- wait(2)
		-- Scott:happy('left', 2)
		-- wait(2.5)
		-- --
		-- -- Next steps..
		-- Scott:say('left', 'The last crew member I saw was Ensign Victor. He went to explore the structure to the east.', 8)
		-- wait(8.5)
		-- Double:okay('right', 2)
		-- wait(2.5)
		--
		-- ~ fin ~
		-- self:complete()
	end)
	-- CUT!!! ---------------------
end

-- Tear down
--
function Cut03:complete()
	Base.complete(self)
	--
	Double:destroy()
	Victor:destroy()
	
	--
	Gamestate.pop()
end

return Cut03