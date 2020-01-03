-- Fall Behavior
--

local Base = require 'src.entities.units.behaviors.npc.base'
local Fall = Base:extend()

function Fall:new(host)
	self.sprite = Animator()
	self.sprite:addAnimation('fall', {
		image  = Config.image.spritesheet.doctor.jump,
		width  = 64,
		height = 64,
		frames = { { 1, 8, 1, 8 } }
	})
	--
	Base.new(self, 'fall', host)
end

return Fall