-- Cutscene 01
-- Intro
--

local Base  = require 'src.gamestates.cutscenes.cutscene'
local Cut01 = Base:extend()
local Double, Captain, Roger, Clarence

function Cut01:init()
	Base.init(self, {
		name = 'Cut01',
		id   = 'cut01',
		map  = Config.world.maps['cut01'],
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
		self.map:drawTileLayer('Walls')
		self.map:drawTileLayer('Platforms')
		self.map:drawTileLayer('Decoratives (FG)')
	lg.setCanvas()
end

-- Enter Scene
--
function Cut01:enter(from, ...)
	Base.enter(self, from, ...)
	--
	-- Casting Call ---------------
	Captain = Entities['Captain']({
		title   = 'Captain Jenny',
		x       = Config.tileSize * 10,
		y       = Config.tileSize * 17,
		width   = Config.spawn.width,
		height  = Config.spawn.height,
		visible  = false,
	}):interrupt()
	Roger = Entities['Doctor']({
		title   = 'Dr. Roger',
		x       = Config.tileSize * 32,
		y       = Config.tileSize * 17,
		width   = Config.spawn.width,
		height  = Config.spawn.height,
		visible  = false,
		isMirrored = true,
	}):interrupt()
	Clarence = Entities['Doctor']({
		title   = 'Dr. Clarence',
		x       = Config.tileSize * 32,
		y       = Config.tileSize * 17,
		width   = Config.spawn.width,
		height  = Config.spawn.height,
		visible  = false,
		isMirrored = true,
	}):interrupt()

	-- ACTION!!! ------------------
    self.timer:script(function(wait)
		--
    	-- Something is wrong!!
    	Effects['flame2']({
			x = Config.tileSize * 10,
			y = Config.tileSize * 10,
			width  = Config.tileSize * 5,
			height = Config.tileSize * 5,
			total  = 2,
		})
		wait(2)
		Effects['flame2']({
			x = Config.tileSize * 0,
			y = Config.tileSize * 10,
			width  = Config.tileSize * 5,
			height = Config.tileSize * 5,
			isMirrored = true,
			total = 4,
		})
		wait(3)
		--
    	-- Roger & Clarence enter room together
    	Roger.visible = true
		Roger:move('left', 500, 3)

		Clarence.visible = true
		Clarence:move('left', 450, 2)
		wait(3)
		--
		-- Clueless..
		Roger:interrupt():worry('right', 1)
		Clarence:interrupt():worry('left', 1)
		wait(2)
		Roger:say('right', 'What the heck is happening!?', 4)
		wait(4.5)
		Clarence:say('left', 'We never should have torrented all those hospital dramas!', 6)
		wait(6.5)
		--
		-- Captain calls in..
		Captain:say('left', 'Hello? Come in! Is anyone reading this? This is Captain Jenny... Please come in..', 7)
		wait(5.5)
		Roger:interrupt():worry('right', 2)
		Clarence:interrupt():worry('left', 2)
		wait(2.5)
		Captain:say('left', 'There is hostile life on the planet and I haven\'t been able to contact any other crew members.', 8)
		wait(8.5)
		--
		-- Doctors come up with a plan..
		Clarence:say('left', 'What are we going to do? Comm is down and our security is down on the planet!', 6)
		wait(4.5)
		Roger:huh('right', 2)
		wait(2)
		Roger:interrupt():idea('right', 1)
		wait(1)
		--
		-- Space Bum to the rescue
		Roger:interrupt():say('right', 'Wait..! They say there is a space venturer who deals in these kinds of matters.', 6)
		wait(6.5)
		Clarence:huh('left', 1)
		wait(1)
		Clarence:interrupt():say('left', 'Who?', 3)
		wait(3.5)
		Roger:say('right', 'They call him.. \'Space Bum\'.', 5)
		wait(3.5)
		Clarence:happy('left', 3)
		wait(5)
		--
		-- ~ fin ~
		self:complete()
	end)
	-- CUT!!! ---------------------
end

-- Tear down
--
function Cut01:complete()
	Base.complete(self)
	--
	Captain:destroy()
	Roger:destroy()
	Clarence:destroy()
	
	--
	-- start game
	local checkpoint = Config.world.checkpoint.player

	Gamestate.switch(Gamestates[checkpoint.map], {
		from = 'beam',
		col  = checkpoint.col,
		row  = checkpoint.row
	})
end

return Cut01