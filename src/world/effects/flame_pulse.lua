-- Flame (Pulse) Effect
--

local Base  = require 'src.world.effects.effect'
local Flame = Base:extend()

-- New Flames effect
--
function Flame:new(data)
	local total = data.total or 1
	local fps   = data.fps   or 30

	self.sprite = Animator()
	self.sprite:addAnimation('default', {
		image  = Config.image.spritesheet.effect.flame2,
		width  = 65,
		height = 43,
		total  = total,
		fps    = fps,
		frames = { { 1, 1, 3, 15 } },
		after  = function()
			total = total - 1

			if total == 0 then
				self:destroy()
			end
		end
	})
	--
	Base.new(self, 'flame_pulse', data)
end

return Flame