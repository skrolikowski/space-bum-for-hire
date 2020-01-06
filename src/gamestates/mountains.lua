-- Mountains Gamestate
-- Shane Krolikowski
--

local Base      = require 'src.gamestates.base'
local Mountains = Base:extend()

-- Init
--
function Mountains:init()
	Base.init(self, 'Mountains')
	--
	-- canvas
    self.background = lg.newCanvas(_World.width, _World.height)
    lg.setCanvas(self.background)
    self.map:drawTileLayer('Background')
    self.map:drawTileLayer('Sharp Cliffs')
    self.map:drawTileLayer('Decoratives (BG)')
    self.map:drawTileLayer('Cliffs')
    self.map:drawTileLayer('Castle')
    self.map:drawTileLayer('Decoratives (MG)')
    self.map:drawTileLayer('Platforms')
    lg.setCanvas()
end

-- Draw Mountains
--
function Mountains:draw()
	_Camera:draw(function()
        lg.setColor(Config.color.white)
        lg.draw(self.background)

        _World:draw()

        lg.setColor(Config.color.white)
        self.map:drawTileLayer('Foreground')
    end)
end

return Mountains