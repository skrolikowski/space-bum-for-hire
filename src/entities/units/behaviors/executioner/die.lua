-- Die Behavior
--

local Behavior = require 'src.entities.units.behaviors.behavior'
local Base     = require 'src.entities.units.behaviors.executioner.base'
local Die      = Base:extend()

function Die:new(host)
	self.sprite = Animator()
	self.sprite:addAnimation('die', {
		image  = Config.image.spritesheet.enemies.executioner,
		width  = 87,
		height = 59,
		total  = 1,
		fps    = 5,
		frames = {
			{ 5, 1, 5, 5 },
			{ 6, 1, 6, 3 }
		},
		after = function() self.host:destroy() end
	})
	--
	Base.new(self, 'die', host)
end

return Die