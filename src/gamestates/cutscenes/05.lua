-- Cutscene 05
-- Finding the Captain
--

local Base  = require 'src.gamestates.cutscenes.cutscene'
local Cut05 = Base:extend()
local Double, Captain

function Cut05:init()
	Base.init(self, {
		name  = 'Cut05',
		id    = 'cut05',
		map   = Config.world.maps['cut05'],
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
function Cut05:enter(from, ...)
	Base.enter(self, from, ...)
	--
	-- Casting Call ---------------
	Double = Entities['Double']({
		x       = Config.tileSize * 8,
		y       = Config.tileSize * 10,
		width   = Config.spawn.width,
		height  = Config.spawn.height,
		isMirrored = true,
		visible = true,
	})
	Captain = Entities['Captain']({
		x      = Config.tileSize * 15,
		y      = Config.tileSize * 14,
		width  = Config.spawn.width,
		height = Config.spawn.height,
		visible = true,
	}):interrupt()

	-- ACTION!!! ------------------
    self.timer:script(function(wait)
    	-- Player & Captain enter scene..
		Captain:move('left', 350, 2)
		wait(1.5)
		Double:huh('right', 1)
		wait(2)
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
		Captain:say('left', 'Scott sent you? And the rest of the crew is okay? Well that\'s good.', 6)
		wait(6.5)
		Captain:say('left', 'I have been trying to contact everyone, but our Comm signal is down.', 6)
		wait(6.5)
		--
		-- Captain tells Player about cave..
		Captain:say('left', 'Listen, I know you aren\'t a crew member, but I need to ask you a favor.', 8)
		wait(6)
		Double:huh('right', 2)
		wait(2.5)
		Captain:say('left', 'The crystals we were sent here to collect are more than just pretty gemstones...', 8)
		wait(6)
		Double:huh('right', 2)
		wait(2.5)
		Captain:say('left', 'They have regenerative capabilities I think we could use to make repairs to our ship.', 8)
		wait(6)
		Double:okay('right', 2)
		wait(2.5)
		Captain:say('left', 'I collected some in that cave, but dropped them when a large hostile attacked me!', 8)
		wait(6)
		Double:shock('right', 2)
		wait(2.5)
		--
		-- -- Player shares idea..
		-- Double:interrupt():huh('right', 2, 'speech')
		-- wait(2.5)
		-- Captain:say('left', 'Of course! We can help you get home, but without the crystals we can\'t even power our ship.', 6.5)
		-- wait(5.5)
		-- Double:interrupt():okay('right', 2)
		-- wait(2.5)
		-- Captain:happy('left', 3)
		-- wait(3.5)
		-- Captain:interrupt():say('left', 'Great! Let me know when you\'re ready and I\'ll be right behind you.', 6)
		-- wait(6.5)
		--
		-- ~ fin ~
		self:complete()
	end)
	-- CUT!!! ---------------------
end

-- Tear down
--
function Cut05:complete()
	Base.complete(self)
	--
	Double:destroy()
	Captain:destroy()
	
	Gamestate.pop()
end

return Cut05