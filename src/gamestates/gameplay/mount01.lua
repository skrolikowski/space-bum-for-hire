-- Mount01 Screen
--

local Gameplay = require 'src.gamestates.gameplay.gameplay'
local Mount01  = Gameplay:extend()

-- Init
--
function Mount01:init()
	Gameplay.init(self, {
        name = 'Mountains',
        map  = Config.world.maps['mount01'],
    })
	--
	-- canvas
    self.background = lg.newCanvas(self.width, self.height)
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

-- Draw
--
function Mount01:draw()
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

return Mount01