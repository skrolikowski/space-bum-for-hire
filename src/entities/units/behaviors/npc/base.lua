-- Base Doctor Behavior
--

local Behavior = require 'src.entities.units.behaviors.behavior'
local Base     = Behavior:extend()

-- Set environmental bounds
-- Doctor sprite
--
function Base:setBounds()
	local x, y, w, h = unpack(self.host.shapeData)

	self.bounds = AABB:fromContainer(x, y, w/3, h)
end

return Base