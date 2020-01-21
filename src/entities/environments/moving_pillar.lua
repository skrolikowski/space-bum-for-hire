-- MovingPillar entity
-- Shane Krolikowski
--

local Environment  = require 'src.entities.environments.environment'
local MovingPillar = Environment:extend()

function MovingPillar:new(data)
	Environment.new(self, _:merge(data, {
		--@overrides
		name = 'MovingPillar',
	}))
	--
	self.color = Config.color.white
	self.area  = data.properties.area or 'castle'
	self.image = Config.image.sprites.pillar[self.area]
end

-- Get change in position for host
-- [override]
--
function MovingPillar:setPosition(nx, ny)
	--
	Environment.setPosition(self, nx, ny)
end

-- Draw platform
--
function MovingPillar:draw()
	local cx, cy = self:getPosition()
	local w, h   = self.image:getDimensions()

	lg.setColor(self.color)
	lg.draw(self.image, cx, cy, 0, 1, 1, w/2, h/2)
	--
	Environment.draw(self)
end

return MovingPillar