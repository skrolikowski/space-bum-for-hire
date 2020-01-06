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
end

-- Update camera position
--
function PlayerCamera:update(dt)
	self.x, self.y = _Player:getPosition()

	self.camera:lookAt(self.x, self.y)
	-- 
	Base.update(self, dt)
end

return PlayerCamera