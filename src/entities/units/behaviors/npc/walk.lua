-- Walk Behavior
--

local Base = require 'src.entities.units.behaviors.npc.base'
local Walk = Base:extend()

function Walk:new(host)
	local cycles = _.__random(2, 4)

	self.sprite = Animator()
	self.sprite:addAnimation('walk', {
		image  = Config.image.spritesheet.doctor.walk,
		width  = 64,
		height = 64,
		total  = cycles,
		frames = { { 1, 1, 1, 10 } },
		after  = function()
			cycles = cycles - 1

			if cycles == 0 then
				self.host.walking = false
			end
		end
	})
	--
	Base.new(self, 'walk', host)

	self.emote = Dialogue['emote'](host, 'free', 'idea')
end

function Walk:update(dt)
	local vx, vy = self.host:getLinearVelocity()
	local ix, iy = 0, 0
	
	if self.host.isMirrored then
		ix = self.host:mass() * (-self.host.speed - vx)
	else
		ix = self.host:mass() * ( self.host.speed - vx)
	end

	self.host:applyForce(ix, iy)
	--
	Base.update(self, dt)
end

function Walk:draw()
	self.emote:draw()
	--
	Base.draw(self)
end

return Walk