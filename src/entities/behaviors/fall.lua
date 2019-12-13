-- Fall Behavior
--

local Behavior = require 'src.entities.behaviors.behavior'
local Fall     = Behavior:extend()

function Fall:new(host)
	self.sprite = Animator()
	self.sprite:addAnimation('fall', {
		image  = Config.image.spritesheet.cyberpunk.jump,
		width  = 64,
		height = 64,
		frames = { { 1, 8, 1, 8 } }
	})
	--
	Behavior.new(self, 'fall', host)
end

return Fall