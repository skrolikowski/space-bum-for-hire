-- Hurt Behavior
--

local Base = require 'src.entities.units.behaviors.enemy.base'
local Hurt = Base:extend()

function Hurt:new(host)
	self.sprite = Animator()
	self.sprite:addAnimation('hurt', {
		image  = host.sprite,
		width  = Config.world.enemies[host.name].sprite.width,
		height = Config.world.enemies[host.name].sprite.height,
		frames = Config.world.enemies[host.name].sprite.frames.hurt,
	})
	--
	Base.new(self, 'hurt', host)
end

return Hurt