-- Spikes entity
-- Shane Krolikowski
--

local Environment    = require 'src.entities.environments.environment'
local Spikes = Environment:extend()

function Spikes:new(data)
	data.isSensor = true
	
	Environment.new(self, data)
	--
	self.color = Config.color.white
	self.image = Config.image.sprites.spikes
end

-- Check for contacts
--
function Spikes:beginContact(other, col)
	if col:isTouching() then
		if other.name == 'Player' then
			print('spikes!')
		end
	end
end

-- Check for separations
--
function Spikes:endContact(other, col)
	if other.name == 'Player' then
		--
	end
end

-- Draw platform
--
function Spikes:draw()
	local cx, cy = self:getPosition()
	local w, h   = self.image:getDimensions()

	lg.setColor(self.color)
	lg.draw(self.image, cx, cy, 0, 1, 1, w/2, h/2)
	--
	Environment.draw(self)
end

return Spikes