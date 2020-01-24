-- Executioner
-- Idle Behavior
--

local Base = require 'src.entities.units.behaviors.enemy.base'
local Idle = Base:extend()

function Idle:new(host)
	self.sprite = Animator()
	self.sprite:addAnimation('idle', {
		image  = host.sprite,
		width  = Config.world.enemy[host.name].sprite.width,
		height = Config.world.enemy[host.name].sprite.height,
		fps    = 4,
		frames = Config.world.enemy[host.name].sprite.frames.idle
	})
	--
	Base.new(self, 'idle', host)
end

return Idle