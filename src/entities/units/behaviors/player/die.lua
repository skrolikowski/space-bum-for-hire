-- Die Behavior
--

local Base = require 'src.entities.units.behaviors.player.base'
local Die  = Base:extend()

function Die:new(host)
	self.sprite = Animator()
	self.sprite:addAnimation('die', {
		image  = host.sprite.death,
		width  = 64,
		height = 64,
		total  = 1,
		frames = { { 1, 1, 1, 7 } },
	})
	--
	Base.new(self, 'die', host)
end

-- Override `reshape`
--
function Die:setBounds()
	local x, y, w, h = unpack(self.host.shapeData)
	--
	self.bounds = AABB:fromContainer(x, y+h/3, w, h/4)
end

-- No sensors
--
function Die:setSensors()
	--
end

return Die