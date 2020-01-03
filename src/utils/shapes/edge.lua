-- Rectangle Physics Shape
--

local Shape = require 'src.utils.shapes.shape'
local Edge  = Shape:extend()

-- New edge shape
--
function Edge:new(...)
	self.shape = lp.newEdgeShape(...)
end

-- Get points of line segment
--
function Edge:getPoints()
	return self.shape:getPoints()
end

-- Next vertex in line segment
-- Get/set
--
function Edge:nextVertex(value)
	if value then
		return self.shape:setNextVertex(value:unpack())
	else
		return Vec2(self.shape:getNextVertex())
	end
end

-- Previous vertex in line segment
-- Get/set
--
function Edge:previousVertex()
	if value then
		return self.shape:setPreviousVertex(value:unpack())
	else
		return Vec2(self.shape:setPreviousVertex())
	end
end

-- Draw edge shape
--
function Edge:draw()
	lg.line(self.body:getWorldPoints(self:getPoints()))
end

return Edge