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
	self.sprite:addAnimation('aim', {
		image  = Config.image.spritesheet.cyberpunk.aim,
		width  = 64,
		height = 64,
		frames = { { 1, 5, 1, 5 } }
	})
	self.sprite:addAnimation('aimUp', {
		image  = Config.image.spritesheet.cyberpunk.aim,
		width  = 64,
		height = 64,
		frames = { { 1, 6, 1, 7 } }
	})
	self.sprite:addAnimation('aimDown', {
		image  = Config.image.spritesheet.cyberpunk.aim,
		width  = 64,
		height = 64,
		frames = { { 1, 3, 1, 4 } }
	})
	--
	Behavior.new(self, 'slide', host)
end

-- Slow down each step
--
function Slide:update(dt)
	local vx, vy   = self.host:getLinearVelocity()
	local isAiming = self.host.shooting

	-- update animation
	if isAiming then
	-- Aiming
		if self.host.axis.y < 0 then
			self.sprite:switchTo('aimUp')
		elseif self.host.axis.y > 0 then
			self.sprite:switchTo('aimDown')
		else
			self.sprite:switchTo('aim')
		end
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
	Behavior.update(self, dt)
end

return Slide