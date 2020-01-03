-- Strike Sensor
-- For Entity Detection
--

local Sensor = require 'src.world.sensors.sensor'
local Strike = Sensor:extend()

function Strike:new(host, ox, oy, range, arc)
	Sensor.new(self, 'Strike', host)
	--
	self.affects = Util:toBoolean({ 'HitBox' })
	self.arc     = arc or _.__pi / 8
	self.attack  = 10

	-- shape
	self:setShape(Shapes['circle'](ox, oy, range or 100))
end

-- Is target within strike arc?
--
function Strike:isInStrike(x, y)
	local cx, cy     = self:getPosition()
	local radius     = self.shape:getRadius()
	local heading    = self.host.isMirrored and _.__pi or 0
	local range      = self.shape:getRadius()
	local toTarget   = Vec2(x, y) - Vec2(cx, cy)
	local strikeLine = Vec2(
		_.__cos(heading) * radius,
		_.__sin(heading) * radius
	)
	local angleBetween = toTarget:angleBetween(strikeLine)
	
	return angleBetween < self.arc
end

-- Check for contacts
--
function Strike:beginContact(other, col)
	if col:isTouching() then
		if self.affects[other.name] then
			if self:isInStrike(other:getPosition()) then
				--other:beginContact(self, col)
			end
		end
	end
end

-- Draw strike arc
--
function Strike:draw()
	-- lg.setColor(Config.color.sensor.strike)
	-- self.shape:draw()

	local cx, cy  = self:getPosition()
	local radius  = self.shape:getRadius()
	local heading = self.host.isMirrored and _.__pi or 0
	local r, g, b = unpack(Config.color.sensor.strike)

	lg.setColor(r, g, b, 0.25)
	lg.arc('fill', cx, cy, radius, heading - self.arc, heading + self.arc)
	lg.setColor(r, g, b, 0.75)
	lg.setLineWidth(1)
	lg.arc('line', cx, cy, radius, heading - self.arc, heading + self.arc)
end

return Strike