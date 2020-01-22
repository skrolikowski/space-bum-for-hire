-- Space01 Screen
--

local Gameplay = require 'src.gamestates.gameplay.gameplay'
local Space01  = Gameplay:extend()

-- Init
--
function Space01:init()
	Gameplay.init(self, {
        name = 'Spaceship',
        id   = 'space01',
        map  = Config.world.maps['space01'],
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

function Space01:enter(from, ...)
	Gameplay.enter(self, from, ...)
	--
    local ok, map = pcall(function() return from.id end)
    local spawnPos, spawnScript
    local Double

    -- Player will enter from..
    if map == 'space00' then
	-- Enter from `space00`
		spawnPos    = Vec2(Config.tileSize*12,Config.tileSize*45)
		spawnScript = function(wait)
			Double:move('right', 350, 1.5)
			wait(1.5)
			--
			-- spawn player and film
			self.player = Entities['Player']({
		        x       = Double:getX() - Config.spawn.width/2,
		        y       = Double:getY() - Config.spawn.height/2,
		        width   = Config.spawn.width,
		        height  = Config.spawn.height,
		    })
		    self.filming = self.player
			-- give controls to player
			self:setControl('gameplay')
			Double:destroy()
		end
	else
	-- Error!
		error('Must come from another map!')
	end

    -- Enter cutscene double..
    Double = Entities['Double']({
        x       = spawnPos.x,
        y       = spawnPos.y,
        width   = Config.spawn.width,
        height  = Config.spawn.height,
    })

    self.filming = Double
	self.timer:script(spawnScript)
end

return Space01