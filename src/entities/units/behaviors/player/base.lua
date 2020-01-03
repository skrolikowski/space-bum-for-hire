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
	local x, y, w, h = self.bounds:container()
	local sx, sy     = self.sx, self.sy
	local bodyShape  = Shapes['rectangle'](self.bounds:translate(0, h/8):scale(0.5, 0.5):container())
	local headShape  = Shapes['circle'](0, -h/4, 5)
	local bodySensor, headSensor

	-- body hitbox
	bodySensor = Sensors['hitbox'](self.host)
	bodySensor:setShape(bodyShape)

	-- head hitbox
	headSensor = Sensors['hitbox'](self.host)
	headSensor:setShape(headShape)
	headSensor:setMultiplier(2)

	-- add sensors
	table.insert(self.sensors, bodySensor)
	table.insert(self.sensors, headSensor)
end

return Base