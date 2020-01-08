-- Guard Behavior
--

local Base  = require 'src.entities.units.behaviors.npc.base'
local Guard = Base:extend()

function Guard:new(host)
	self.sprite = Animator()
	self.sprite:addAnimation('guard', {
		image  = host.sprite.guard,
		width  = 64,
		height = 64,
		total  = 1,
		frames = { { 1, 1, 1, 6 } }
	})
	--
	Base.new(self, 'guard', host)
end

return Guard