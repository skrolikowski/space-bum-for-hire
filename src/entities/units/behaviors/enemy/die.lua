-- Die Behavior
--

local Base = require 'src.entities.units.behaviors.enemy.base'
local Die  = Base:extend()

function Die:new(host)
	self.sprite = Animator()
	self.sprite:addAnimation('die', {
		image  = host.sprite,
		width  = 87,
		height = 59,
		total  = 1,
		frames = {
			{ 5, 1, 5, 5 },
			{ 6, 1, 6, 3 }
		}
	})
	--
	Base.new(self, 'die', host)
end

return Die