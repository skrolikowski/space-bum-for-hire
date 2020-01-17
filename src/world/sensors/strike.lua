-- Strike Sensor
-- For Entity Detection
--

local Sensor = require 'src.world.sensors.sensor'
local Strike = Sensor:extend()

function Strike:new(host)
	Sensor.new(self, 'Strike', host)
	--
	self.affects = Util:toBoolean({ 'HitBox' })
	self.damage  = host._attack.damage

	-- animation
	self.sprite = Animator()
	self.sprite:addAnimation('strike', {
		image  = Config.image.spritesheet.effect.slash2,
		width  = 83,
		height = 81,
		total  = 1,
		fps    = 40,
		frames = { { 1, 1, 11, 2 } },
		after  = function() self:destroy() end
	})

	-- sprite scaling
	self.sx = host._attack.sx or 0.5
	self.sy = host._attack.sy or 0.8

	--
	local hw, hh = host:dimensions()
	local sw, sh = self.sprite:dimensions()

	-- shape
	if host.isMirrored then
		self:setShape(Shapes['rectangle'](-hw*0.75, hh*0.1, sw * self.sx, sw * self.sy))
	else
		self:setShape(Shapes['rectangle']( hw*0.75, hh*0.1, sw * self.sx, sw * self.sy))
	end

end

-- Update
--
function Strike:update(dt)
	self.sprite:update(dt)
end

-- Draw strike
--
function Strike:draw()
	lg.setColor(Config.color.sensor.strike)
	self.shape:draw()
	--
	local cx, cy = self:getPosition()
	local w, h   = self.sprite:dimensions()
	local sx, sy = self.sx, self.sy
	local ox, oy = w/2, h/2

	if not self.host.isMirrored then
		sx = -sx
	end

	lg.setColor(Config.color.white)
	self.sprite:draw(cx, cy, 0, sx, sy, ox, oy)
end

return Strike