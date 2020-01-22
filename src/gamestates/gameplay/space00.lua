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
    local ok, map = pcall(function() return from.id end)
    local spawnPos
    local Double

    -- Player will enter from..
    if map == 'space01' then
    -- Enter from `space01`
    	spawnPos    = Vec2(Config.tileSize*32,Config.tileSize*17)
    	self.timer:script(function(wait)
            -- spawn double and film
            Double = Entities['Double']({
                x      = spawnPos.x,
                y      = spawnPos.y,
                width  = Config.spawn.width,
                height = Config.spawn.height,
            })
            self.filming = Double
            --
    		Double:move('left', 350, 1.5)
			wait(1.5)
            -- spawn player and film
            self.player = Entities['Player']({
                x      = Double:getX() - Config.spawn.width/2,
                y      = Double:getY() - Config.spawn.height/2,
                width  = Config.spawn.width,
                height = Config.spawn.height,
            })
            self.filming = self.player
            self.player.isMirrored = true
			-- give controls to player
            self:setControl('gameplay')
            Double:destroy()
    	end)
    else
    -- Error!
    -- error('Must come from another map!')
    	spawnPos    = Vec2(Config.tileSize*25,Config.tileSize*17)
    	self.timer:script(function(wait)
        -- spawn player and film
            self.player = Entities['Player']({
                x      = spawnPos.x,
                y      = spawnPos.y,
                width  = Config.spawn.width,
                height = Config.spawn.height,
            })
            self.filming = self.player
            self:setControl('gameplay')
    	end)
	end
end

return Space00