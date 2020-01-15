-- Slide Behavior
--

local Base  = require 'src.entities.units.behaviors.enemy.base'
local Slide = Base:extend()

function Slide:new(host)
	self.sprite = Animator()
	self.sprite:addAnimation('slide', {
		image  = host.sprite,
		width  = 87,
		height = 59,
		frames = { { 4, 2, 4, 5 } }
	})
	--
	Base.new(self, 'slide', host)
end

-- Slow down each step
--
function Slide:update(dt)
	local vx, vy = self.host:getLinearVelocity()

	-- update linear velocity
	if self.host.onGround then
		vx = vx - 8 * vx * dt
	else
		vx = vx - 4 * vx * dt
	end

	self.host:setLinearVelocity(vx, vy)
	--
	Base.update(self, dt)
end

return Slide