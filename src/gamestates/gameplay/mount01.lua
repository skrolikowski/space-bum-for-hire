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
        self.spawnPos    = Vec2(144,1104)
        self.spawnWidth  = 80
        self.spawnHeight = 80
        -- focus camera
        self:lookAt(
            self.spawnPos.x + self.spawnWidth  / 2,
            self.spawnPos.y + self.spawnHeight / 2
        )
        -- teleportation effect w/ adjustments
        Effects['warp']({
            x      = self.spawnPos.x  - 15,
            y      = self.spawnPos.y  - 25,
            width  = self.spawnWidth  * 1.25,
            height = self.spawnHeight * 1.25,
        })

        self.timer:after(0.85, function(wait)
            -- spawn player
            self.player = Entities['Player']({
                x       = self.spawnPos.x,
                y       = self.spawnPos.y,
                width   = self.spawnWidth,
                height  = self.spawnHeight,
            })

            -- give controls to player
            self:setControl('player')
        end)
    end
end

return Mount01