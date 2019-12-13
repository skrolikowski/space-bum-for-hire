-- Pistol Rounds
--

local Modern = require 'modern'
local Round  = Modern:extend()

function Round:new(host, x, y, angle, sx, sy)
	self.host  = host
	-- properties
	self.x     = x
	self.y     = y
	self.angle = angle or 0
	-- scaling
	self.sx = sx or 1
	self.sy = sy or 1
	-- flags
	self.remove = false
end

function Round:update(dt)
	self.sprite:update(dt)
end

-- Draw pistol animation
--
function Round:draw()
	local sx, sy = self.sx, self.sy
	local ox, oy = 0, 0
	local transform

	if self.host.isMirrored then sx = -sx end
	if self.host.isFlipped  then sy = -sy end

	transform = lx.newTransform(self.x, self.y, self.angle, sx, sy)

	love.graphics.setColor(Config.color.white)
	self.sprite:draw(transform)
end

return Round