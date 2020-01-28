-- Cutscene 04
-- Found Bishop, but no Captain
-- ...and now we're trapped in the Castle.
--

local Base  = require 'src.gamestates.cutscenes.cutscene'
local Cut04 = Base:extend()
local Double, Bishop

function Cut04:init()
	Base.init(self, {
		name = 'Cut04',
		id   = 'cut04',
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
		self.map:drawTileLayer('Castle')
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
	Double = Entities['Double']({
		title   = 'Player',
		x       = Config.tileSize * 2,
		y       = Config.tileSize * 14,
		width   = Config.spawn.width,
		height  = Config.spawn.height,
		visible = true
	})
	Bishop = Entities['Engineer']({
		title   = 'Bishop',
		x       = Config.tileSize * 10,
		y       = Config.tileSize * 14,
		width   = Config.spawn.width,
		height  = Config.spawn.height,
		visible  = true,
		isMirrored = true,
	}):interrupt()

	-- ACTION!!! ------------------
    self.timer:script(function(wait)
    	--
    	-- Player & Bishop enter scene..
		Bishop:shock('right', 1)
		wait(1)
		Bishop:say('right', 'Who\'s there!? I know karate!!', 3)
		wait(3)
		Bishop:interrupt():blame('left', 2)
		wait(1)
		Double:anger('right', 3)
		wait(1)
		Bishop:worry('left', 1)
		wait(2)
		--
		-- Player asks about captain..
		Bishop:say('left', 'Oh! I apologize human. I thought you were a hostile. You do smell like one..', 8)
		wait(6)
		Double:anger('right', 2)
		wait(2.5)
		Double:explain('right', 3)
		wait(3.5)
		Bishop:say('left', 'Affirmative. The Captain was with me earlier. She is now in the West End.', 8)
		wait(8.5)
		--
		-- Player follows up..
		Double:huh('right', 3, 'speech')
		wait(3.5)
		Bishop:say('left', 'Affirmative. She ventured off alone without accompaniment on a hostile planet.. without anything to defend herself.', 9)
		wait(8)
		Double:huh('right', 2, 'speech')
		wait(2)
		Bishop:say('left', 'Simple. Humans do not take orders from robots. It is, in fact, the other way around.', 8)
		wait(8.5)
		--
		-- Player looks for solution..
		Double:okay('right', 2.5)
		wait(2.5)
		Double:interrupt():explain('right', 2)
		wait(2.5)
		Bishop:say('left', 'Affirmative. The Captain is undoubtedly in danger. Death percentage: 87.333333333333333333...', 8)
		wait(8.5)
		Double:worry('right', 2)
		wait(2)
		Bishop:say('left', 'There is no need to worry human, the hostiles will not touch you as your smell matches theirs.', 8)
		wait(6)
		Double:anger('right', 2, 'thought')
		wait(2)
		Double:interrupt():huh('right', 2, 'speech')
		wait(2)
		Bishop:say('left', 'The exit is 80 pixels South of our current position. Upon exit head West through the cave.', 8)
		wait(8.5)
		Double:okay('right', 2)
		wait(2)
		Bishop:say('left', 'Good luck on your journey, human.', 5)
		wait(6.5)
		--
		-- ~ fin ~
		self:complete()
	end)
	-- CUT!!! ---------------------
end

-- Tear down
--
function Cut04:complete()
	Base.complete(self)
	--
	Double:destroy()
	Bishop:destroy()
	
	--
	Gamestate.pop()
end

return Cut04