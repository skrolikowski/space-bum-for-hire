-- Dispatcher sensor
--

local Sensor     = require 'src.world.sensors.sensor'
local Dispatcher = Sensor:extend()

function Dispatcher:new(host, cause)
	Sensor.new(self, 'Dispatcher', host)
	--
	self.cause = Util:toBoolean(cause or {})
end

-- Set beginContact callback
--
function Dispatcher:setOnContact(callback)
	self.onContact = callback
end

-- Set endContact callback
--
function Dispatcher:setOffContact(callback)
	self.offContact = callback
end

-- Check for contacts
--
function Dispatcher:beginContact(other, col)
	if self.cause[other.name] or self.cause[other.category] then
		if self.onContact then
			self.onContact(other, col)
		end
	end
end

-- Check for seperations
--
function Dispatcher:endContact(other, col)
	if self.cause[other.name] or self.cause[other.category] then
		if self.offContact then
			self.offContact(other, col)
		end
	end
end

-- Draw sensor
--
function Dispatcher:draw()
	lg.setColor(Config.color.sensor.dispatcher)
	self.shape:draw()
end

return Dispatcher