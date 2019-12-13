-- Slide Behavior
--

local Behavior = require 'src.entities.behaviors.behavior'
local Slide    = Behavior:extend()

function Slide:new(host)
	self.sprite = Animator()
	self.sprite:addAnimation('slide', {
		image  = Config.image.spritesheet.cyberpunk.slide,
		width  = 64,
		height = 64,
		frames = { { 1, 1, 1, 6 } }
	})
	--
	Behavior.new(self, 'slide', host)
end

-- Slow down each step
--
function Slide:update(dt)
	local vx, vy = self.host:getLinearVelocity()

	if self.host.onGround then
		vx = vx - 2 * vx * dt
	else
		vx = vx - vx * dt
	end

	self.host:setLinearVelocity(vx, vy)
	--
	Behavior.update(self, dt)
end

return Slide