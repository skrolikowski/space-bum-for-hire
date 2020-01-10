-- Warp Effect
--

local Base = require 'src.world.effects.effect'
local Warp = Base:extend()

-- New Warp effect
--
function Warp:new(data)
	local total = data.total or 1
	local fps   = data.fps   or 30

	self.sprite = Animator()
	self.sprite:addAnimation('default', {
		image  = Config.image.spritesheet.effect.warp,
		width  = 102,
		height = 135,
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
	Base.new(self, 'warp', data)
end

return Warp