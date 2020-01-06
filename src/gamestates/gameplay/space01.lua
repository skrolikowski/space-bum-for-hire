-- Space01 Screen
--

local Gameplay = require 'src.gamestates.gameplay.gameplay'
local Space01  = Gameplay:extend()

-- Init
--
function Space01:init()
	Gameplay.init(self, {
        name = 'Spaceship',
        map  = Config.world.maps['space01'],
    })
    --
    -- canvas
    self.background = lg.newCanvas(self.width, self.height)
    lg.setCanvas(self.background)
    self.map:drawTileLayer('Background')
    self.map:drawTileLayer('Decoratives (BG)')
    self.map:drawTileLayer('Walls')
    self.map:drawTileLayer('Platforms')
    self.map:drawTileLayer('Decoratives (FG)')
    lg.setCanvas()
end

-- Draw
--
function Space01:draw()
    self.camera:draw(function()
        lg.setColor(Config.color.white)
        lg.draw(self.background)

        _World:draw()

        lg.setColor(Config.color.white)
        self.map:drawTileLayer('Foreground')
    end)
    --
    Gameplay.draw(self)
end

return Space01