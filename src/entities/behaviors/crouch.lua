-- Crouch Behavior
--

local Behavior = require 'src.entities.behaviors.behavior'
local Crouch   = Behavior:extend()

function Crouch:new(host)
	self.isCrouched = false
	--
	self.sprite = Animator()
	self.sprite:addAnimation('crouch', {
		image  = Config.image.spritesheet.cyberpunk.crouch,
		width  = 64,
		height = 64,
		total  = 1,
		frames = { { 1, 1, 1, 3 } },
		after  = function()
			self.isCrouched = true
		end
	})
	self.sprite:addAnimation('crouched', {
		image  = Config.image.spritesheet.cyberpunk.crouch,
		width  = 64,
		height = 64,
		frames = { { 1, 3, 1, 3 } }
	})
	self.sprite:addAnimation('crouchAim', {
		image  = Config.image.spritesheet.cyberpunk.crouchAim,
		width  = 64,
		height = 64,
		frames = { { 1, 3, 1, 3 } }
	})
	self.sprite:addAnimation('crouchAimUp', {
		image  = Config.image.spritesheet.cyberpunk.crouchAim,
		width  = 64,
		height = 64,
		total  = 1,
		frames = { { 1, 4, 1, 5 } }
	})
	self.sprite:addAnimation('crouchAimDown', {
		image  = Config.image.spritesheet.cyberpunk.crouchAim,
		width  = 64,
		height = 64,
		total  = 1,
		frames = { { 1, 1, 1, 2 } }
	})
	--
	Behavior.new(self, 'crouch', host)

	self:slide()
end

-- Update animation
--
function Crouch:update(dt)
	local isAiming = self.host.lockedIn == self.name or
	                 self.host.shooting

	if isAiming then
	-- Aiming
		if self.host.axis.y < 0 then
			self.sprite:switchTo('crouchAimUp')
		elseif self.host.axis.y > 0 then
			self.sprite:switchTo('crouchAimDown')
		else
			self.sprite:switchTo('crouchAim')
		end
	else
	-- Crouching
		if self.isCrouched then
			self.sprite:switchTo('crouched')
		else
			self.sprite:switchTo('crouch')
		end
	end
	--

	Behavior.update(self, dt)
end

-- Slide into crouch if running..
--
function Crouch:slide()
	local vx, vy = self.host:getLinearVelocity()

	vx = vx - vx * 0.45

	self.host:setLinearVelocity(vx, vy)
end

return Crouch