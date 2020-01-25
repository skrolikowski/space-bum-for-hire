-- Die Behavior
--

local Base = require 'src.entities.units.behaviors.enemy.base'
local Die  = Base:extend()

function Die:new(host)
	self.sprite = Animator()
	self.sprite:addAnimation('die', {
		image  = host.sprite,
		width  = Config.world.enemy[host.name].sprite.width,
		height = Config.world.enemy[host.name].sprite.height,
		total  = 1,
		fps    = 8,
		frames = Config.world.enemy[host.name].sprite.frames.die
	})
	--
	Base.new(self, 'die', host)
end

-- No sensors
--
function Die:setSensors()
	--
end

return Die