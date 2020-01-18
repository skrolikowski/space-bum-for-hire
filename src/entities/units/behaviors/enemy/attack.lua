-- Run Behavior
--

local Base   = require 'src.entities.units.behaviors.enemy.base'
local Attack = Base:extend()

function Attack:new(host)
	self.sprite = Animator()
	self.sprite:addAnimation('attack', {
		image  = host.sprite,
		width  = Config.world.enemies[host.name].sprite.width,
		height = Config.world.enemies[host.name].sprite.height,
		total  = 1,
		frames = Config.world.enemies[host.name].sprite.frames.attack,
		after  = function() host.attacking = false end
	})
	--
	Base.new(self, 'attack', host)
end

return Attack