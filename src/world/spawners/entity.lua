-- Entity Spawner
-- Shane Krolikowski
--

local Modern  = require 'modern'
local Spawner = Modern:extend()

function Spawner:new(map)
	for __, layer in ipairs(map.layers) do
		if layer.properties.Enabled == true then
			if layer.type == 'objectgroup' then
				for __, object in ipairs(layer.objects) do
					if object.name then
						Entities[_:lowerCase(object.name)](object)
					end
				end
			end
		end
	end
end

return Spawner