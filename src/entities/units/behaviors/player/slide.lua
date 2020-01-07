-- Slide Behavior
--

local Base  = require 'src.entities.units.behaviors.player.base'
local Slide = Base:extend()

function Slide:new(host)
	self.sprite = Animator()
	self.sprite:addAnimation('slide', {
		image  = host.sprite.slide,
		width  = 64,
		height = 64,
		frames = { { 1, 1, 1, 6 } }
	})
	self.sprite:addAnimation('aim', {
		image  = host.sprite.aim,
		width  = 64,
		height = 64,
		frames = { { 1, 1, 1, 1 } }
	})
	--
	Base.new(self, 'slide', host)
end

-- Slow down each step
--
function Slide:update(dt)
	local vx, vy   = self.host:getLinearVelocity()
	local isAiming = self.host.shooting

	-- update animation
	if isAiming then
	-- Aiming
		self.sprite:switchTo('aim')
	else
	-- Slide
		self.sprite:switchTo('slide')
	end

	-- update linear velocity
	if self.host.onGround then
		vx = vx - 4 * vx * dt
	else
		vx = vx - 2 * vx * dt
	end

	self.host:setLinearVelocity(vx, vy)
	--
	Base.update(self, dt)
end

return Slide