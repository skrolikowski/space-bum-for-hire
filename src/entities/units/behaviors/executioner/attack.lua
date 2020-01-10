-- Run Behavior
--

local Base   = require 'src.entities.units.behaviors.executioner.base'
local Attack = Base:extend()

function Attack:new(host)
	self.sprite = Animator()
	self.sprite:addAnimation('attack', {
		image  = Config.image.spritesheet.enemies.executioner,
		width  = 87,
		height = 59,
		total  = 1,
		frames = {
			{ 3, 1, 3, 5 },
			{ 4, 1, 4, 1 }
		},
		after = function()
			self.host.attacking = false
		end
	})
	--
	Base.new(self, 'attack', host)

	-- Attack!
	self.strike = Sensors['strike'](host, 0, 0)
end

function Attack:destroy()
	self.strike:destroy()
	--
	Base.destroy(self)
end

return Attack