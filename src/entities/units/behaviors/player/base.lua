-- Base Player Behavior
--

local Behavior = require 'src.entities.units.behaviors.behavior'
local Base     = Behavior:extend()

-- Set environmental bounds
-- Player sprite
--
function Base:setBounds()
	local x, y, w, h = unpack(self.host.shapeData)

	self.bounds = AABB:fromContainer(x, y, w/3, h)
end

-- Set sensors for: Player
--   - Hit Boxes
--
function Base:setSensors()
	local x, y, w, h = self.bounds:scale(0.5, 0.5):container()
	local bodyShape  = Shapes['rectangle'](x, y+h*0.1, w, h)
	local bodySensor

	-- body hitbox
	bodySensor = Sensors['hitbox'](self.host)
	bodySensor:setShape(bodyShape)

	-- add sensors
	table.insert(self.sensors, bodySensor)
end

return Base