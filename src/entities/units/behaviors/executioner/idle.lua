-- Executioner
-- Idle Behavior
--

local Base = require 'src.entities.units.behaviors.executioner.base'
local Idle = Base:extend()

function Idle:new(host)
	self.sprite = Animator()
	self.sprite:addAnimation('idle', {
		image  = Config.image.spritesheet.enemies.executioner,
		width  = 87,
		height = 59,
		fps    = 4,
		frames = { { 1, 1, 1, 4 } }
	})
	--
	Base.new(self, 'idle', host)

	-- patrolling
	self.toggle = host.timer:every(3, function()
		self.host.isMirrored = not self.host.isMirrored
	end)
end

-- Clean up
--
function Idle:destroy()
	self.host.timer:cancel(self.toggle)
	--
	Base.destroy(self)
end

return Idle