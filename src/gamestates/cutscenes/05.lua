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
		x      = Config.tileSize * 17,
		y      = Config.tileSize * 14,
		width  = Config.spawn.width,
		height = Config.spawn.height,
		visible = true,
	}):interrupt()

	-- ACTION!!! ------------------
    self.timer:script(function(wait)
    	--
    	-- Player & Captain enter scene..
		Captain:huh('right', 1)
		wait(1)
		Captain:interrupt():move('left', 350, 3)
		wait(3)
		--
		-- Player & Captain meet..
		Captain:interrupt():say('left', 'Oh! Thank goodness!!', 3)
		wait(3)
		Captain:interrupt():shock('left', 1)
		wait(1.5)
		Captain:say('left', 'Wait.. who are you? I don\'t recognize you.', 5)
		wait(4)
		Double:explain('right', 3)
		wait(3.5)
		Captain:say('left', 'Scott sent you? And the rest of the crew is okay? Well that\'s a relief.', 6)
		wait(6.5)
		Captain:say('left', 'I have been trying to contact everyone, but our Comm signal is down.', 6)
		wait(6.5)
		--
		-- Captain tells Player about cave..
		Captain:say('left', 'Listen, I know you aren\'t a crew member, but I need to ask you a favor.', 8)
		wait(6)
		Double:huh('right', 2)
		wait(2.5)
		Captain:say('left', 'The crystals we were sent here to study are more than just pretty gemstones...', 8)
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
		Captain:say('left', 'Once we have those crystals, we can repair our ship and get off this horrible planet!', 8)
		wait(6)
		Double:greed('right', 2)
		wait(2.5)
		Captain:say('left', 'Oh! ...and of course we will reimburse you for your services.', 8)
		wait(6)
		Double:okay('right', 2)
		wait(3.5)
		Captain:say('left', 'Plus! I\'ll even throw in my Freddy\'s Milkshake Hut card. You just need one more stamp to get a free milkshake!', 10)
		wait(8)
		Double:huh('right', 2, 'thought')
		wait(2)
		Double:interrupt():okay('right', 2)
		wait(3.5)
		--
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