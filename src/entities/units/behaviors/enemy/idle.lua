-- Executioner
-- Idle Behavior
--

local Base = require 'src.entities.units.behaviors.enemy.base'
local Idle = Base:extend()

function Idle:new(host)
	self.sprite = Animator()
	self.sprite:addAnimation('idle', {
		image  = host.sprite,
		width  = 87,
		height = 59,
		fps    = 4,
		frames = { { 1, 1, 1, 4 } }
	})
	--
	Base.new(self, 'idle', host)

	-- unrest
	-- host.timer:after(host._timing.unrest, function() host:bored() end)
end

return Idle