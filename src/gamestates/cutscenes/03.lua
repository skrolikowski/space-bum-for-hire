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
		x       = Config.tileSize * 10,
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
		Victor:shock('left', 2)
		wait(2)
		--
		-- Ensign Victor is caught off guard..
		Victor:interrupt():say('left', 'Yikes! You made quite the entrance. Remind me to bring you to the next party I go to.', 8)
		wait(7)
		Double:huh('right', 2)
		wait(2)
		Victor:interrupt():say('left', 'Clarence sent you, didn\'t he? Tell him I didn\'t eat his lunch!', 8)
		wait(7)
		Double:shock('right', 2)
		wait(2)
		--
		-- Player is here to save the day!
		Double:explain('right', 3)
		wait(3)
		--
		-- Ensign is on board..
		Victor:say('left', 'Oh! The Commander sent you? Yes, The Captain was here...', 8)
		wait(8.5)
		Victor:say('left', 'However, I haven\'t seen her since she left with Bishop. They took off West.', 8)
		wait(8.5)
		--
		-- Player understands and offers to help..
		Double:okay('right', 2)
		wait(2.5)
		Double:explain('right', 3)
		wait(3)
		--
		-- Victor decides to stay behind..
		Victor:say('left', 'Thank you, but I will be okay here. My mining drill should keep me safe.', 8)
		wait(8)
		Victor:interrupt():fiddle('left', 1)
		wait(1)
		Victor:interrupt():fiddle('right', 1)
		Double:shock('right', 2)
		wait(1)
		Victor:say('left', 'Plus, I\'ve watched like every Bruce Lee movie!', 8)
		wait(5)
		--
		-- Player agrees and moves on..
		Double:okay('right', 2)
		wait(3)
		--
		-- ~ fin ~
		self:complete()
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