-- Run Behavior
--

local Base = require 'src.entities.units.behaviors.npc.base'
local Run  = Base:extend()

function Run:new(host)
	self.sprite = Animator()
	self.sprite:addAnimation('run', {
		image  = host.sprite.run,
		width  = 64,
		height = 64,
		frames = { { 1, 1, 1, 8 } },
	})
	--
	Base.new(self, 'run', host)
end

-- Update
--
function Run:update(dt)
	local hx, hy = self.host:getPosition()
	local tx, ty = self.host.target:getPosition()
	local vx, vy = self.host:getLinearVelocity()
	local ix, iy = 0, 0

	if self.host.isMirrored  then
		ix = self.host:mass() * (-self.host.speed * 1.25 - vx)
	else
		ix = self.host:mass() * ( self.host.speed * 1.25 - vx)
	end

	self.host:applyForce(ix, iy)
	--
	Base.update(self, dt)
end

return Run