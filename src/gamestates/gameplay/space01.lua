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
		self.map:drawTileLayer('Decoratives (MG)')
		self.map:drawTileLayer('UI')
	lg.setCanvas()
end

-- Teardown
--
function Space01:leave()
	Gameplay.leave(self)
	--
	self.questText:destroy()
end

-- Enter
--
function Space01:enter(from, ...)
	Gameplay.enter(self, from, ...)
	--
	-- Retry Parkour!!
	if self.settings.from == self.id then
		self:playerEnterBeam(Config.tileSize*58, Config.tileSize*62)
	end

	-- Display current quest
	--
    self.questText = UI['text']({
    	x      = Config.tileSize*65,
    	y      = Config.tileSize*83,
    	width  = Config.tileSize*10,
    	height = Config.tileSize*10,
    	visible = true,
    	fontfamily = 'Marksman',
    	pixelsize = 18,
    	text = Config.world.quest[Config.world.hud.quest].text,
    })
end

return Space01