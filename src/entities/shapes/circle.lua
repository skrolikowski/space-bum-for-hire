-- Rectangle Physics Shape
--

local Shape  = require 'src.entities.shapes.shape'
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
	local x, y    = self.body:getPosition()
	local angle   = self.body:getAngle()
	local radius  = self:radius()
	local x2, y2  = Vec2:polar(angle, radius):unpack()
	local r, g, b = unpack(Config.color.shape)

	-- shape
	lg.setColor(r, g, b, 0.35)
	lg.circle('fill', x, y, radius)
	
	-- shape outline
	lg.setColor(r, g, b, 0.75)
	lg.circle('line', x, y, radius)

	-- heading
	lg.setColor(Config.color.heading)
	lg.line(x, y, self.body:getWorldPoints(x2, y2))
end

return Circle