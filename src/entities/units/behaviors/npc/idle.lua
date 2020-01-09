-- Idle Behavior
--

local Base = require 'src.entities.units.behaviors.npc.base'
local Idle = Base:extend()

function Idle:new(host)
	self.sprite = Animator()
	self.sprite:addAnimation('idle', {
		image  = host.sprite.idle,
		width  = 64,
		height = 64,
		frames = { { 1, 1, 1, 6 } }
	})
	--
	Base.new(self, 'idle', host)
end

return Idle