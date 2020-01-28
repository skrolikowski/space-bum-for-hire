-- Mount03 Screen
--

local Gameplay = require 'src.gamestates.gameplay.gameplay'
local Mount03  = Gameplay:extend()

-- Init
--
function Mount03:init()
	Gameplay.init(self, {
        name = 'West End',
        id   = 'mount03',
        map  = Config.world.maps['mount03'],
    })
	--
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

function Mount03:enter(from, ...)
    Gameplay.enter(self, from, ...)
    --
    -- Player will enter from..
    if self.settings.from == 'mount01' then
        if self.settings['section'] == 'A' then
            self:playerEnterDoor(Config.tileSize*96, Config.tileSize*47, 'left')
        else
        -- Error!
            error('Missing map section!')
        end
    end
end

return Mount03