-- Explosion Effect
--

local Base      = require 'src.world.effects.effect'
local Explosion = Base:extend()

-- New Explosion effect
--
function Explosion:new(data)
	local total = data.total or 1
	local fps   = data.fps   or 30

	self.sprite = Animator()
	self.sprite:addAnimation('default', {
		image  = Config.image.spritesheet.particles.explosion1,
		width  = 47,
		height = 57,
		total  = total,
		fps    = fps,
		frames = { { 1, 1, 13, 5 } },
		after  = function()
			total = total - 1

			if total == 0 then
				self:destroy()
			end
		end
	})
	--
	Base.new(self, 'warp', data)
end

return Explosion