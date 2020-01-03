-- HitBox Sensor
--

local Sensor = require 'src.world.sensors.sensor'
local HitBox = Sensor:extend()

-- Create new HitBox
--
function HitBox:new(host)
	Sensor.new(self, 'HitBox', host)
	--
	self.multipler = 1
end

-- Set damage multipler
--
function HitBox:setMultiplier(multiplier)
	self.multiplier = multiplier
end

-- Event - beginContact
--
function HitBox:beginContact(other, col)
	if other.name == 'Spikes' then
		self.host:damage(other, other.attack * self.multiplier)
	elseif other.name == 'Strike' then
		self.host:damage(other, other.attack * self.multiplier)
	end
end

-- Draw HitBox
--
function HitBox:draw()
	-- lg.setColor(Config.color.sensor.hitbox)
	-- self.shape:draw()
end

return HitBox