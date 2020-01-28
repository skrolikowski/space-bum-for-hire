-- Mount01 Screen
--

local Gameplay = require 'src.gamestates.gameplay.gameplay'
local Mount01  = Gameplay:extend()

-- Init
--
function Mount01:init()
	Gameplay.init(self, {
        name = 'Mountains',
        id   = 'mount01',
        map  = Config.world.maps['mount01'],
    })
	--
	-- background canvas
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

function Mount01:enter(from, ...)
    Gameplay.enter(self, from, ...)
    --
    -- Player will enter from..
    if self.settings.from == 'mount02' then
    -- Mountains - Castle
        if self.settings['section'] == 'A' then
            self:playerEnterDoor(Config.tileSize*115, Config.tileSize*13, 'left')
        elseif self.settings['section'] == 'B' then
            self:playerEnterDoor(Config.tileSize*113, Config.tileSize*31, 'left')
        elseif self.settings['section'] == 'C' then
            self:playerEnterDoor(Config.tileSize*114, Config.tileSize*55, 'left')
        else
        -- Error!
            error('Missing map section!')
        end
    elseif self.settings.from == 'mount03' then
    -- West End
        if self.settings['section'] == 'A' then
            self:playerEnterDoor(Config.tileSize*2, Config.tileSize*78, 'right')
        else
        -- Error!
            error('Missing map section!')
        end
    end
end

return Mount01