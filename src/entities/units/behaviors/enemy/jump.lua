-- Jump Behavior
--

local Base = require 'src.entities.units.behaviors.enemy.base'
local Jump = Base:extend()

function Jump:new(host)
	host:applyLinearImpulse(0, -host.initImpulse)
	--
	self.sprite = Animator()
	self.sprite:addAnimation('jump', {
		image  = host.sprite,
		width  = 87,
		height = 59,
		total  = 1,
		frames = {
			{ 7, 1, 7, 2 },
			{ 6, 4, 6, 5 }
		},
		after = function() self.host.jumping = false end
	})
	--
	Base.new(self, 'jump', host)
end

return Jump