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

-- Set up Hit Boxes for base
-- Player sprite
--
function Base:setHitBoxes()
	local x, y, w, h = self.bounds:container()
	local sx, sy     = self.sx, self.sy
	local bodyShape  = Shapes['rectangle'](self.bounds:translate(0, h/8):scale(0.5, 0.5):container())
	local headShape  = Shapes['circle'](0, -h/4, 5)

	self:addHitBox('Body', bodyShape)
	self:addHitBox('Head', headShape, 3)
end

return Base