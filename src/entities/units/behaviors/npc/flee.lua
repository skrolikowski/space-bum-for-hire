-- Flee Behavior
--

local Base = require 'src.entities.units.behaviors.npc.base'
local Flee = Base:extend()

function Flee:new(host)
	local count = _.__random(2, 4)

	self.sprite = Animator()
	self.sprite:addAnimation('flee', {
		image  = host.sprite.run,
		width  = 64,
		height = 64,
		total  = count,
		frames = { { 1, 1, 1, 8 } },
		after  = function()
			count = count - 1

			if count == 0 then
				self.host.fleeing = false
			end
		end
	})
	--
	Base.new(self, 'flee', host)

	self.emote = Dialogue['emote'](host, 'free', 'alert')
end

-- Update facing/emote
--
function Flee:update(dt)
	local hx, hy = self.host:getPosition()
	local tx, ty = self.host.target:getPosition()
	local vx, vy = self.host:getLinearVelocity()
	local ix, iy = 0, 0

	-- Facing
	self.host.isMirrored = tx > hx
	
	if self.host.isMirrored  then
		ix = self.host:mass() * (-self.host.speed * 1.25 - vx)
	else
		ix = self.host:mass() * ( self.host.speed * 1.25 - vx)
	end

	self.host:applyForce(ix, iy)

	self.emote:update(dt)
	--
	Base.update(self, dt)
end

function Flee:draw()
	self.emote:draw()
	--
	Base.draw(self)
end

return Flee