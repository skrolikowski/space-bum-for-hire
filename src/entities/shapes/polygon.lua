-- Polygon Physics Shape
--

local Shape   = require 'src.entities.shapes.shape'
local Polygon = Shape:extend()

-- New polygon shape
--
function Polygon:new(...)
	self.shape = lp.newPolygonShape(...)
end

-- Get vertices of polygon shape
--
function Polygon:getPoints()
	return self.shape:getPoints()
end

-- Validates whether polygon is convex
--
function Polygon:validate()
	return self.shape:validate()
end

-- Draw polygon shape
--
function Polygon:draw()
	local x, y    = self.body:getPosition()
	local w, h    = self:dimensions()
	local points  = { self.body:getWorldPoints(self:getPoints()) }
	local angle   = self.body:getAngle()
	local x2, y2  = Vec2:polar(angle, w / 2):unpack()
	local r, g, b = unpack(Config.color.shape)

	-- shape
	lg.setColor(r, g, b, 0.25)
	lg.polygon('fill', unpack(points))

	-- shape outline
	lg.setColor(r, g, b, 0.75)
	lg.polygon('line', unpack(points))

	-- -- heading
	-- lg.setColor(Config.color.heading)
	-- lg.line(x, y, self.body:getWorldPoints(x2, y2))
end

return Polygon