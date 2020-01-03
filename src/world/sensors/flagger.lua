-- Flagger sensor
--

local Sensor = require 'src.world.sensors.sensor'
local Flagger = Sensor:extend()

function Flagger:new(host, flag)
	Sensor.new(self, 'Flagger', host)
	--

end

return Flagger