-- Fall Behavior
--

local Base = require 'src.entities.units.behaviors.enemy.base'
local Fall = Base:extend()

function Fall:new(host)
	self.sprite = Animator()
	self.sprite:addAnimation('fall', {
		image  = host.sprite,
		width  = Config.world.enemy[host.name].sprite.width,
		height = Config.world.enemy[host.name].sprite.height,
		frames = Config.world.enemy[host.name].sprite.frames.fall
	})
	--
	Base.new(self, 'fall', host)
end

return Fall