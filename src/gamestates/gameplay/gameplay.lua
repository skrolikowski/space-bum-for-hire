-- Base Gameplay Scene
--

local Base     = require 'src.gamestates.base'
local Gameplay = Base:extend()

-- New cutscene
function Gameplay:init(data)
	Base.init(self, data)
	--
	-- UI/HUD
    self.hud = UI['player_hud']()

    -- default foreground canvas
	self.foreground = lg.newCanvas(self.width, self.height)
	lg.setCanvas(self.foreground)
		self.map:drawTileLayer('Foreground')
	lg.setCanvas()

	-- default background canvas
	self.background = lg.newCanvas(self.width, self.height)
	lg.setCanvas(self.background)
		self.map:drawTileLayer('Background')
		self.map:drawTileLayer('Decoratives (BG)')
		self.map:drawTileLayer('Walls')
		self.map:drawTileLayer('Platforms')
		self.map:drawTileLayer('Decoratives (FG)')
	lg.setCanvas()
end

-- Enter cutscene
--
function Gameplay:enter(from, ...)
	-- default controls
	self:setControl('none')

	-- update hud
	self.hud:set('location', self.name)

	--
	Base.enter(self, from, ...)
end

-- Reward Player and item
--
function Gameplay:rewardPlayer(name, value)
	if name == 'health' or name == 'shield' or name == 'ammo' then
	-- Let HUD handle it
		self.hud:increase(name, value)
	else
	-- Error!
		error('Unidentifiable Player Reward!!')
	end
end

-- Update HUD
--
function Gameplay:update(dt)
	Base.update(self, dt)
	--
	self.hud:update(dt)
end

-- Draw HUD
function Gameplay:draw()
	Base.draw(self)
	--
	self.hud:draw()
end

return Gameplay