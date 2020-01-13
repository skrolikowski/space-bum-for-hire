-- Hurt Behavior
--

local Base = require 'src.entities.units.behaviors.enemy.base'
local Hurt = Base:extend()

function Hurt:new(host)
	self.sprite = Animator()
	self.sprite:addAnimation('hurt', {
		image  = host.sprite,
		width  = 87,
		height = 59,
		frames = { { 4, 2, 4, 5 } }
	})
	--
	Base.new(self, 'hurt', host)
end

return Hurt