-- HitBox Sensor
--

local Sensor = require 'src.world.sensors.sensor'
local HitBox = Sensor:extend()

-- Create new HitBox
--
function HitBox:new(host)
	Sensor.new(self, 'HitBox', host)
	--
end

-- Event - beginContact
--
function HitBox:beginContact(other, col)
	if other.name == 'Spikes' then
		-- print(self.host.name, other.name)
		self.host:damage(other, other.damage)
	-- Spike damage
	elseif other.name == 'Projectile' then
	-- Projectile damage
		-- print(self.host.name, other.name)
		self.host:damage(other, other.damage)
	elseif other.name == 'Fireball' then
	-- Fireball damage
		self.host:damage(other, other.damage)
	elseif other.name == 'Strike' then
	-- Strike attack damage
		-- print(self.host.name, other.name)
		self.host:damage(other, other.damage)
	end
end

-- Draw HitBox
--
function HitBox:draw()
	-- lg.setColor(Config.color.sensor.hitbox)
	-- self.shape:draw()
end

return HitBox