-- Polygon Physics Shape
--

local Shape   = require 'src.utils.shapes.shape'
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
	local points  = { self.body:getWorldPoints(self:getPoints()) }
	local r, g, b = lg.getColor()

	-- shape
	lg.setColor(r, g, b, 0.25)
	lg.polygon('fill', points)

	-- shape outline
	lg.setColor(r, g, b, 0.75)
	lg.polygon('line', points)

	-- -- heading
	-- local x, y    = self.body:getPosition()
	-- local angle   = self.body:getAngle()
	-- local w, h    = self:dimensions()
	-- local x2, y2  = Vec2:polar(angle, w / 2):unpack()
	-- lg.setColor(Config.color.heading)
	-- lg.line(x, y, self.body:getWorldPoints(x2, y2))
end

return Polygon