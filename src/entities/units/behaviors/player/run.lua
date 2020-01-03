-- Run Behavior
--

local Base = require 'src.entities.units.behaviors.player.base'
local Run  = Base:extend()

function Run:new(host)
	self.sprite = Animator()
	self.sprite:addAnimation('walk', {
		image  = Config.image.spritesheet.player.walk,
		width  = 64,
		height = 64,
		frames = { { 1, 1, 1, 10 } }
	})
	self.sprite:addAnimation('run', {
		image  = Config.image.spritesheet.player.run,
		width  = 64,
		height = 64,
		frames = { { 1, 1, 1, 8 } }
	})
	self.sprite:addAnimation('runAim', {
		image  = Config.image.spritesheet.player.runAim,
		width  = 64,
		height = 64,
		frames = { { 1, 1, 1, 8 } }
	})
	--
	Base.new(self, 'run', host)
end

function Run:update(dt)
	local vx, vy   = self.host:getLinearVelocity()
	local isAiming = self.host.shooting

	if isAiming then
		self.sprite:switchTo('runAim')
	else
		if _.__abs(vx) > 150 then
			self.sprite:switchTo('run')
		else
			self.sprite:switchTo('walk')
		end
	end
	--
	Base.update(self, dt)
end

return Run