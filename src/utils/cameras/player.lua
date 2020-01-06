-- Player camera
--

local Base         = require 'src.utils.cameras.camera'
local PlayerCamera = Base:extend()

function PlayerCamera:new()
	Base.new(self, 'PlayerCamera')
	--
	self.x, self.y = _Player:getPosition()
	self.width     = Config.width
	self.height    = Config.height

	-- UI/HUD
    --self.hud = UI['player_hud']()
end

-- Update Camera Focus/HUD
--
-- function PlayerCamera:update(dt)
-- 	local cx, cy = _Player:getPosition()

-- 	self.x = cx
-- 	self.y = cy
-- 	self.camera:lookAt(cx, cy)
-- 	--
-- 	self.hud:update(dt)
-- end

-- -- Draw Player HUD
-- --
-- function PlayerCamera:draw(callback)
-- 	Base.draw(self, callback)
-- 	--
-- 	self.hud:draw()
-- end

return PlayerCamera