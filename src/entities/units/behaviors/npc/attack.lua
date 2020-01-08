-- Attack Behavior
--

local Base   = require 'src.entities.units.behaviors.npc.base'
local Attack = Base:extend()

function Attack:new(host)
	self.sprite = Animator()
	self.sprite:addAnimation('attack', {
		image  = host.sprite.melee,
		width  = 64,
		height = 64,
		frames = { { 1, 1, 1, 8 } }
	})
	--
	Base.new(self, 'attack', host)
end

return Attack