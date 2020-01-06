-- Cutscene 01
--

local Cutscene = require 'src.gamestates.cutscenes.cutscene'
local Cut01    = Cutscene:extend()

function Cut01:init()
	Cutscene.init(self, {
		name    = 'Cutscene',
		map     = Config.world.maps['cut01'],
		onLeave = function() Gamestate.switch(Gamestates['space01']) end
	})
	--
	-- set canvas
	self.background = lg.newCanvas(self.width, self.height)
	lg.setCanvas(self.background)
	--
	self.map:drawTileLayer('Background')
	self.map:drawTileLayer('Decorative (BG)')
	self.map:drawTileLayer('Walls')
	self.map:drawTileLayer('Platforms')
	self.map:drawTileLayer('Decorative (FG)')
	--
	lg.setCanvas()
end

-- Enter cutscene
--
function Cut01:enter(from, ...)
	Cutscene.enter(self, from, ...)
	--
	-- cutscene
    self.timer:script(function(wait)
		
		--
		--self:onLeave()
	end)
end

-- Draw
--
function Cut01:draw()
    self.camera:draw(function()
        lg.setColor(Config.color.white)
        lg.draw(self.background)

        _World:draw()

        lg.setColor(Config.color.white)
        self.map:drawTileLayer('Foreground')
    end)
end

return Cut01