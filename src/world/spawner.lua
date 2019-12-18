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
			else
			-- Spawn Entities
				for __, object in ipairs(layer.objects) do
					if layer.name then
						Entities[layer.name](object)
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

-- Update events and remove expired events.
--
function Spawner:update(dt)
	for i = #self.events, 1, -1 do
		if self.events[i].remove then
			table.remove(self.events, i)
		else
			self.events[i]:update(dt)
		end
	end
end

-- Draw events
--
function Spawner:draw()
	for __, event in pairs(self.events) do
		event:draw()
	end
end

return Spawner