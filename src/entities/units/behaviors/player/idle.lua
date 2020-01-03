-- Idle Behavior
--

local Base = require 'src.entities.units.behaviors.player.base'
local Idle = Base:extend()

function Idle:new(host)
	self.sprite = Animator()
	self.sprite:addAnimation('idle', {
		image  = Config.image.spritesheet.player.idle,
		width  = 64,
		height = 64,
		frames = { { 1, 1, 1, 6 } }
	})
	self.sprite:addAnimation('aim', {
		image  = Config.image.spritesheet.player.aim,
		width  = 64,
		height = 64,
		frames = { { 1, 1, 1, 1 } }
	})
	--
	Base.new(self, 'idle', host)
end

-- Update animation
--
function Idle:update(dt)
	local isAiming = self.host.lockedIn == self.name or
	                 self.host.shooting

	if isAiming then
	-- Aiming
		self.sprite:switchTo('aim')
	else
	-- Idle
		self.sprite:switchTo('idle')
	end
	--
	Base.update(self, dt)
end

return Idle