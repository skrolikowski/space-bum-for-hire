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
    local transition = 'spawn'

    -- Player enters level..
    if transition == 'spawn' then
        local spawnPos = Vec2(Config.tileSize*9,Config.tileSize*69)
        -- focus camera
        self:lookAt(
            spawnPos.x + Config.spawn.width  / 2,
            spawnPos.y + Config.spawn.height / 2
        )
        -- teleportation effect w/ adjustments
        -- Effects['warp']({
        --     x      = spawnPos.x  - 15,
        --     y      = spawnPos.y  - 25,
        --     width  = Config.spawn.width  * 1.25,
        --     height = Config.spawn.height * 1.25,
        -- })

        -- self.timer:after(0.85, function(wait)
            -- spawn player
            self.player = Entities['Player']({
                x       = spawnPos.x,
                y       = spawnPos.y,
                width   = Config.spawn.width,
                height  = Config.spawn.height,
            })

            -- give controls to player
            self.filming = self.player
            self:setControl('player')
        -- end)
    end
end

return Mount01