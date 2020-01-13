-- Run Behavior
--

local Base = require 'src.entities.units.behaviors.enemy.base'
local Run  = Base:extend()

function Run:new(host)
	self.sprite = Animator()
	self.sprite:addAnimation('run', {
		image  = host.sprite,
		width  = 87,
		height = 59,
		fps    = 8,
		frames = {
			{ 1, 5, 1, 5 },
			{ 2, 1, 2, 5 }
		}
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
		ix = self.host:mass() * (-self.host.speed - vx)
	else
		ix = self.host:mass() * ( self.host.speed - vx)
	end

	self.host:applyForce(ix, iy)
	--
	Base.update(self, dt)
end

return Run