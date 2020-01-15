-- Slide Behavior
--

local Base  = require 'src.entities.units.behaviors.enemy.base'
local Slide = Base:extend()

function Slide:new(host)
	self.sprite = Animator()
	self.sprite:addAnimation('slide', {
		image  = host.sprite,
		width  = Config.world.enemies[host.name].sprite.width,
		height = Config.world.enemies[host.name].sprite.height,
		frames = Config.world.enemies[host.name].sprite.frames.slide
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