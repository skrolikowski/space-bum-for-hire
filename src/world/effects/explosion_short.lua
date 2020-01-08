-- Explosion (Short) Effect
--

local Base      = require 'src.world.effects.effect'
local Explosion = Base:extend()

-- New ExplosionShort effect
--
function Explosion:new(data)
	local total = data.total or 1
	local fps   = data.fps   or 25

	self.sprite = Animator()
	self.sprite:addAnimation('default', {
		image  = Config.image.spritesheet.particles.explosion2,
		width  = 57,
		height = 56,
		total  = total,
		fps    = fps,
		frames = { { 1, 1, 5, 5 } },
		after  = function()
			total = total - 1

			if total == 0 then
				self:destroy()
			end
		end
	})
	--
	Base.new(self, 'explosion_short', data)
end

return Explosion