-- Jump Behavior
--

local Base = require 'src.entities.units.behaviors.enemy.base'
local Jump = Base:extend()

function Jump:new(host)
	self.sprite = Animator()
	self.sprite:addAnimation('jump', {
		image  = host.sprite,
		width  = Config.world.enemies[host.name].sprite.width,
		height = Config.world.enemies[host.name].sprite.height,
		total  = 1,
		frames = Config.world.enemies[host.name].sprite.frames.jump,
		after  = function() self.host.jumping = false end
	})
	--
	Base.new(self, 'jump', host)
end

return Jump