-- Rectangle Physics Shape
--

local Shape  = require 'src.utils.shapes.shape'
local Circle = Shape:extend()

-- New circle shape
--
function Circle:new(...)
	self.shape = lp.newCircleShape(...)
end

-- Center position of circle shape
--
function Circle:point(value)
	if value then
		self.shape:setPoint(value:unpack())
	else
		return Vec2(self.shape:getPoint())
	end
end

-- Radius of circle shape
-- Get/set
--
function Circle:radius(value)
	if value then
		self.shape:setRadius(value)
	else
		return self.shape:getRadius()
	end
end

-- Draw circle shape
--
function Circle:draw()
	local x, y    = self.body:getWorldPoints(self:point():unpack())
	local radius  = self:radius()
	local r, g, b = lg.getColor()

	-- shape
	lg.setColor(r, g, b, 0.25)
	lg.circle('fill', x, y, radius)
	
	-- shape outline
	lg.setColor(r, g, b, 0.75)
	lg.circle('line', x, y, radius)
end

return Circle