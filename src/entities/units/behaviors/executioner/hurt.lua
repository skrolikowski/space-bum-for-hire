-- Hurt Behavior
--

local Base = require 'src.entities.units.behaviors.executioner.base'
local Hurt = Base:extend()

function Hurt:new(host)
	self.sprite = Animator()
	self.sprite:addAnimation('hurt', {
		image  = Config.image.spritesheet.enemies.executioner,
		width  = 87,
		height = 59,
		frames = { { 4, 2, 4, 5 } }
	})
	--
	Base.new(self, 'hurt', host)
end

return Hurt