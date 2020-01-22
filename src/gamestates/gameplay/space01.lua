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
	-- Player will enter from..
    if self.settings.from == 'space01' then
    -- Spaceship - Main Room
        self:playerEnterDoor(Config.tileSize*12, Config.tileSize*45, 'right')
    end
end

return Space01