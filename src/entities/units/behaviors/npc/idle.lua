-- Idle Behavior
--

local Base = require 'src.entities.units.behaviors.npc.base'
local Idle = Base:extend()

function Idle:new(host)
	self.sprite = Animator()
	self.sprite:addAnimation('idle', {
		image  = Config.image.spritesheet.doctor.idle,
		width  = 64,
		height = 64,
		frames = { { 1, 1, 1, 6 } }
	})
	--
	Base.new(self, 'idle', host)

	self.host.timer:after(2, function()
		self.host.isMirrored = not self.host.isMirrored
		self.host.walking = true
	end)
end

return Idle