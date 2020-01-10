-- Entity Spawner
-- Shane Krolikowski
--

local Modern  = require 'modern'
local Spawner = Modern:extend()

function Spawner:new(map)
	self.events = {}
	--
	for __, layer in ipairs(map.layers) do
		if layer.type == 'objectgroup' then
			if layer.name == 'Events' then
			-- Spawn Events
			-- Events are sensors, which cause things to happen. 
				self:spawnEvents(layer.objects)
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

-- Spawn Events
-- MUST ALWAYS BE CALLED LAST
--
function Spawner:spawnEvents(events)
	for __, event in ipairs(events) do
		if event.name then
			table.insert(self.events, Events[event.name](event))
		end
	end
end

return Spawner