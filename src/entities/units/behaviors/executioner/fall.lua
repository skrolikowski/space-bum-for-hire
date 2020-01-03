-- Fall Behavior
--

local Base = require 'src.entities.units.behaviors.executioner.base'
local Fall = Base:extend()

function Fall:new(host)
	self.sprite = Animator()
	self.sprite:addAnimation('fall', {
		image  = Config.image.spritesheet.enemies.executioner,
		width  = 87,
		height = 59,
		frames = { { 7, 3, 7, 4 } }
	})
	--
	Base.new(self, 'fall', host)
end

return Fall