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

-- Reward Player a payload
--
function Gameplay:rewardPlayer(payload)
	-- if payload.name == '' then
	-- 	-- TODO: key items?
	-- else
	-- Let HUD handle it
		self.hud:increase(payload)
	-- end
end

-- Player has died
--
function Gameplay:playerDeath()
	--TODO: reboot
	print('Player Death')
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