-- Mount02 Screen
--

local Gameplay = require 'src.gamestates.gameplay.gameplay'
local Mount02  = Gameplay:extend()

-- Init
--
function Mount02:init()
	Gameplay.init(self, {
        name = 'Mountain Castle',
        id   = 'mount02',
        map  = Config.world.maps['mount02'],
    })
	--
	-- background canvas
    self.background = lg.newCanvas(self.width, self.height)
    lg.setCanvas(self.background)
    self.map:drawTileLayer('Background')
    self.map:drawTileLayer('Decoratives (BG)')
    self.map:drawTileLayer('Castle')
    self.map:drawTileLayer('Decoratives (MG)')
    self.map:drawTileLayer('Platforms')
    lg.setCanvas()

    --TODO: keep state of level
end

function Mount02:enter(from, ...)
    Gameplay.enter(self, from, ...)
    --
    local ok, map = pcall(function() return from.id end)

    -- Player will enter from..
    if map == 'mount01' then
        if self.settings['section'] == 'A' then
            self:playerEnterDoor(0, Config.tileSize*5, 'right')
        elseif self.settings['section'] == 'B' then
            self:playerEnterDoor(0, Config.tileSize*26, 'right')
        elseif self.settings['section'] == 'C' then
            -- self:playerEnterDoor(0, Config.tileSize*26, 'right')
        else
        -- Error!
            error('Missing map section!')
        end
    elseif map == 'space00' then
        self:playerEnterBeam(
            Config.tileSize * self.col,
            Config.tileSize * self.row
        )
    else
    -- Default Spawn
        self:playerEnterBeam(
            Config.tileSize * 40,
            Config.tileSize * 45
        )
    end
end

return Mount02