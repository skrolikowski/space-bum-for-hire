-- StandUp Behavior
--

local Base    = require 'src.entities.units.behaviors.player.base'
local StandUp = Base:extend()

function StandUp:new(host)
	self.sprite = Animator()
	self.sprite:addAnimation('standup', {
		image  = host.sprite.crouch,
		width  = 64,
		height = 64,
		total  = 1,
		frames = { { 1, 4, 1, 6 } },
		after  = function()
			self.host.standing = false
		end
	})
	--
	Base.new(self, 'standup', host)
end

return StandUp