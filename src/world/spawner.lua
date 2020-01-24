-- Entity Spawner
-- Shane Krolikowski
--

local Modern  = require 'modern'
local Spawner = Modern:extend()

function Spawner:new(map)
	for __, layer in ipairs(map.layers) do
		if layer.type == 'objectgroup' then

			if layer.name == 'Events' then
			-- Spawn Events
			-- Events are sensors, which cause things to happen.
			-- MUST ALWAYS BE CALLED LAST
				for __, event in ipairs(layer.objects) do
					Events[event.name](event)
				end

			elseif layer.name == 'Text' then
			-- Spawn UI Text
				for __, object in ipairs(layer.objects) do
					UI['text'](object)
				end

			elseif layer.name == 'Units' then
			-- Spawn Unit
				for __, object in ipairs(layer.objects) do
					if object.name then
						-- Copy as to not overwrite
						Entities[object.name](_:copy(object))
					end
				end

			else
			-- Spawn Entities
				for __, object in ipairs(layer.objects) do
					if layer.name then
						-- Copy as to not overwrite
						Entities[layer.name](_:copy(object))
					end
				end
			end
		end
	end
end

return Spawner