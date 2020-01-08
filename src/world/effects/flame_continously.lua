-- Flame (Continuous) Effect
--

local Base  = require 'src.world.effects.effect'
local Flame = Base:extend()

-- New Flame effect
--
function Flame:new(data)
	local total = data.total or 1
	local fps   = data.fps   or 30

	self.sprite = Animator()
	self.sprite:addAnimation('default', {
		image  = Config.image.spritesheet.particles.flame1,
		width  = 66,
		height = 47,
		total  = total,
		fps    = fps,
		frames = { { 1, 1, 7, 5 } },
		after  = function()
			total = total - 1

			if total == 0 then
				self:destroy()
			end
		end
	})
	--
	Base.new(self, 'flames', data)
end

return Flame