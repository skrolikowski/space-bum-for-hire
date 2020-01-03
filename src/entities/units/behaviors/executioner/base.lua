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

-- Set up Hit Boxes for base
-- Executioner sprite
--
function Base:setHitBoxes()
	local x, y, w, h = self.bounds:container()
	local bodyShape = Shapes['rectangle'](self.bounds:translate(0, h/4):scale(0.35, 0.35):container())
	local headShape = Shapes['circle'](0, 0, 10)

	self:addHitBox('Body', bodyShape)
	self:addHitBox('Head', headShape, 3)
end

return Base