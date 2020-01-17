-- Executioner
-- Idle Behavior
--

local Base = require 'src.entities.units.behaviors.enemy.base'
local Idle = Base:extend()

function Idle:new(host)
	self.sprite = Animator()
	self.sprite:addAnimation('idle', {
		image  = host.sprite,
		width  = Config.world.enemies[host.name].sprite.width,
		height = Config.world.enemies[host.name].sprite.height,
		fps    = 4,
		frames = Config.world.enemies[host.name].sprite.frames.idle
	})
	--
	Base.new(self, 'idle', host)
end

return Idle