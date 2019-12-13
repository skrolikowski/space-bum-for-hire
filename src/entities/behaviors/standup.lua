-- StandUp Behavior
--

local Behavior = require 'src.entities.behaviors.behavior'
local StandUp  = Behavior:extend()

function StandUp:new(host)
	self.sprite = Animator()
	self.sprite:addAnimation('standup', {
		image  = Config.image.spritesheet.cyberpunk.crouch,
		width  = 64,
		height = 64,
		total  = 1,
		frames = { { 1, 4, 1, 6 } },
		after  = function()
			self.host.standing = false
		end
	})
	--
	Behavior.new(self, 'standup', host)
end

return StandUp