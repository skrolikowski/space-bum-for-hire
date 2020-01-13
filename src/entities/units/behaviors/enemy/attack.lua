-- Run Behavior
--

local Base   = require 'src.entities.units.behaviors.enemy.base'
local Attack = Base:extend()

function Attack:new(host)
	self.sprite = Animator()
	self.sprite:addAnimation('attack', {
		image  = host.sprite,
		width  = 87,
		height = 59,
		total  = 1,
		frames = {
			{ 3, 1, 3, 5 },
			{ 4, 1, 4, 1 }
		}
	})
	--
	Base.new(self, 'attack', host)
end

return Attack