-- Base Executioner Behavior
--

local Behavior = require 'src.entities.units.behaviors.behavior'
local Base     = Behavior:extend()

-- Set environmental bounds
-- Executioner sprite
--
function Base:setBounds()
	local x, y, w, h = unpack(self.host.shapeData)

	self.ox = w/10
	self.oy = 0
	self.sx = self.sx * -1  -- default facing ==>

	self.bounds = AABB:fromContainer(x, y, w/2, h)
end

-- Set sensors for: Executioner
--   - Hit Boxes
--
function Base:setSensors()
	local x, y, w, h = self.bounds:scale(0.35, 0.40):container()
	local bodyShape  = Shapes['rectangle'](x, y+h*0.4, w, h)
	local bodySensor

	-- body hitbox
	bodySensor = Sensors['hitbox'](self.host)
	bodySensor:setShape(bodyShape)

	-- add sensors
	table.insert(self.sensors, bodySensor)
end

return Base