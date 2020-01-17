-- Jump Behavior
--

local Base = require 'src.entities.units.behaviors.player.base'
local Jump = Base:extend()

function Jump:new(host)
	self.sprite = Animator()
	self.sprite:addAnimation('jump', {
		image  = host.sprite.jump,
		width  = 64,
		height = 64,
		total  = 1,
		frames = { { 1, 3, 1, 8 } }
	})
	self.sprite:addAnimation('jumpAim', {
		image  = host.sprite.jumpAim,
		width  = 64,
		height = 64,
		frames = { { 1, 1, 1, 1 } }
	})
	--
	Base.new(self, 'jump', host)

	-- jump!
	local initJumpVel = _.__sqrt(2 * Config.world.gravity.y * self.host.jumpHeight)
	local initImpulse = self.host:mass() * initJumpVel
	
	host:applyLinearImpulse(0, -initImpulse)
end

-- Switch out animation
--
function Jump:update(dt)
	local isAiming = self.host.locking or
	                 self.host.shooting

	-- update animation
	if isAiming then
	-- Aiming
		self.sprite:switchTo('jumpAim')
	else
	-- Jump
		self.sprite:switchTo('jump')
	end
	--
	Base.update(self, dt)
end

return Jump