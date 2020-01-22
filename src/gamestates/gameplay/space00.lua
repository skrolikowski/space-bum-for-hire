-- Space00 Screen
--

local Gameplay = require 'src.gamestates.gameplay.gameplay'
local Space00 = Gameplay:extend()

-- Init
--
function Space00:init()
	Gameplay.init(self, {
        name = 'Warp Room',
        id   = 'space00',
        map  = Config.world.maps['space00'],
    })
    --
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

function Space00:enter(from, ...)
	Gameplay.enter(self, from, ...)
    --
    -- Player will enter from..
    if self.settings.from == 'space01' then
    -- Spaceship - Main Room
        self:playerEnterDoor(Config.tileSize*32,Config.tileSize*17, 'left')
    end
end

return Space00