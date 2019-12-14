-- Run Behavior
--

local Behavior = require 'src.entities.behaviors.behavior'
local Run      = Behavior:extend()

function Run:new(host)
	self.sprite = Animator()
	self.sprite:addAnimation('walk', {
		image  = Config.image.spritesheet.cyberpunk.walk,
		width  = 64,
		height = 64,
		frames = { { 1, 1, 1, 10 } }
	})
	self.sprite:addAnimation('run', {
		image  = Config.image.spritesheet.cyberpunk.run,
		width  = 64,
		height = 64,
		frames = { { 1, 1, 1, 8 } }
	})
	self.sprite:addAnimation('runAim', {
		image  = Config.image.spritesheet.cyberpunk.runAim,
		width  = 64,
		height = 64,
		frames = { { 1, 1, 1, 5 } }
	})
	self.sprite:addAnimation('runAimUp', {
		image  = Config.image.spritesheet.cyberpunk.runAimUp,
		width  = 64,
		height = 64,
		frames = { { 1, 1, 1, 8 } }
	})
	self.sprite:addAnimation('runAimDown', {
		image  = Config.image.spritesheet.cyberpunk.runAimDown,
		width  = 64,
		height = 64,
		frames = { { 1, 1, 1, 8 } }
	})
	--
	Behavior.new(self, 'run', host)
end

function Run:update(dt)
	local vx, vy   = self.host:getLinearVelocity()
	local isAiming = self.host.shooting

	if isAiming then
		if self.host.axis.y < 0 then
			self.sprite:switchTo('runAimUp')
		elseif self.host.axis.y > 0 then
			self.sprite:switchTo('runAimDown')
		else
			self.sprite:switchTo('runAim')
		end
	else
		if _.__abs(vx) > 150 then
			self.sprite:switchTo('run')
		else
			self.sprite:switchTo('walk')
		end
	end
	--
	Behavior.update(self, dt)
end

return Run