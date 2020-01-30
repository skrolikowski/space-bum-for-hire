-- Cutscene 06
-- You did it! Congratulations!
--

local Base  = require 'src.gamestates.cutscenes.cutscene'
local Cut06 = Base:extend()
local Double, Captain, Scott, Bishop, Clarence, Roger

function Cut06:init()
	Base.init(self, {
		name = 'Cut06',
		id   = 'cut06',
		map  = Config.world.maps['cut06'],
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
function Cut06:enter(from, ...)
	Base.enter(self, from, ...)
	--
	-- Casting Call ---------------
	Double = Entities['Double']({
		x       = Config.tileSize * 8,
		y       = Config.tileSize * 17,
		width   = Config.spawn.width,
		height  = Config.spawn.height,
		visible = true,
	})
	Captain = Entities['Captain']({
		x      = Config.tileSize * 12,
		y      = Config.tileSize * 17,
		width  = Config.spawn.width,
		height = Config.spawn.height,
		visible = true,
	}):interrupt()
	Scott = Entities['Ensign']({
		x      = Config.tileSize * 15,
		y      = Config.tileSize * 17,
		width  = Config.spawn.width,
		height = Config.spawn.height,
		visible = true,
	}):interrupt()
	Roger = Entities['Doctor']({
		title   = 'Dr. Roger',
		x       = Config.tileSize * 24,
		y       = Config.tileSize * 17,
		width   = Config.spawn.width,
		height  = Config.spawn.height,
		visible  = true,
	}):interrupt()
	Clarence = Entities['Doctor']({
		title   = 'Dr. Clarence',
		x       = Config.tileSize * 28,
		y       = Config.tileSize * 17,
		width   = Config.spawn.width,
		height  = Config.spawn.height,
		visible  = true,
	}):interrupt()
	Bishop = Entities['Engineer']({
		title   = 'Bishop',
		x       = Config.tileSize * 20,
		y       = Config.tileSize * 17,
		width   = Config.spawn.width,
		height  = Config.spawn.height,
		visible  = true,
	}):interrupt()

	-- ACTION!!! ------------------
    self.timer:script(function(wait)
    	--
		-- Enter scene
		Captain:say('right', 'Let\'s hear it for our new friend and hero of the day: The Space Bum', 8)
		wait(7)
		Scott:okay('left', 4, 'speech')
		Roger:fiddle('right', 2)
		Clarence:fiddle('right', 2)
		wait(2)
		Bishop:huh('right', 2, 'thought')
		Roger:interrupt():fiddle('left', 2)
		Clarence:interrupt():fiddle('left', 2)
		wait(2.5)
		Bishop:happy('left', 2, 'thought')
		Roger:okay('right', 2)
		Clarence:okay('right', 2)
		wait(2.5)
		--
		-- Bishop gives his praise..
		Bishop:say('left', 'I must admit, human, I am impressed with your survival skills.', 8)
		wait(1)
		Captain.isMirrored = true
		Scott.isMirrored = true
		wait(5)
		Double:happy('right', 2, 'thought')
		wait(2.5)
		Bishop:say('left', 'Going through all plausible scenarios I predicted you would end up a smear on the cliffside.', 9)
		wait(6)
		Double:shock('right', 2.5, 'thought')
		wait(3)
		--
		-- Captain cuts in..
		Scott:say('left', 'I think what Bishop is trying to say is you are One True Badass!!', 8)
		wait(6)
		Double:happy('right', 4, 'thought')
		Captain:laugh('left', 6)
		Roger:fiddle('right', 3)
		Clarence:fiddle('right', 3)
		wait(3)
		Scott:laugh('left', 3)
		Bishop:huh('right', 3, 'thought')
		Roger:interrupt():fiddle('left', 3)
		Clarence:interrupt():fiddle('left', 3)
		wait(3.5)
		Bishop.isMirrored = true
		--
		-- Farewell!
		Captain:say('left', 'Well farewell, Space Bum. And good luck on your next adventure!', 8)
		wait(8.5)
		Double:move('left', 350, 3)
		wait(3)
		Double:interrupt():okay('right', 2)
		wait(2.5)
		--
		-- teleportation effect w/ adjustments
		Effects['warp']({
		    x      = Double:getX()-Config.spawn.width/2-15,
		    y      = Double:getY()-Config.spawn.height/2-15,
		    width  = Config.spawn.width  * 1.25,
		    height = Config.spawn.height * 1.25,
		})
		wait(0.75)
		Double:destroy()
		wait(3)
		--
		-- ~ fin ~
		self:complete()
	end)
	-- CUT!!! ---------------------
end

-- Tear down
--
function Cut06:complete()
	Base.complete(self)
	--
	if Double and not Double:isDestroyed() then
		Double:destroy()
	end
	Captain:destroy()
	Scott:destroy()
	Bishop:destroy()
	Clarence:destroy()
	Roger:destroy()
	--
	Gamestate.push(Gamestates['complete'])
end

return Cut06