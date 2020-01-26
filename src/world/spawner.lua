-- Entity Spawner
-- Shane Krolikowski
--

local Modern  = require 'modern'
local Spawner = Modern:extend()

function Spawner:new(world, map)
	self.world       = world
	self.layers      = {}
	self.environment = {}

	for __, layer in ipairs(map.layers) do
		if layer.type == 'objectgroup' then
			--

			if layer.name == 'Events' then
			-- World Events
				self.layers[layer.name] = layer.objects
			elseif layer.name == 'Text' then
			-- UI Text
				self.layers[layer.name] = layer.objects
			elseif layer.name == 'Units' then
			-- Units
				self.layers[layer.name] = layer.objects
			else
			-- Environment
				self.environment[layer.name] = layer.objects
			end

			--
		end
	end
end

--
--
function Spawner:reset()
	self:spawnEnvironment()
	self:spawnText()
	self:spawnUnits()
	self:spawnEvents()
end

-- Respawn Request
--
function Spawner:respawn()
	self:spawnUnits()
	self:spawnEvents()
end

-- Spawn Events
-- Events are sensors, which cause things to happen.
--
function Spawner:spawnEvents()
	if self.layers['Events'] then
		for __, event in pairs(self.layers['Events']) do
			if event.name then
				if not self.world:fetchEntityById(event.id) then
					Events[event.name](event)
				end
			else
			-- Error!
				error('Missing event name!')
			end
		end
	end
end

-- Spawn UI Text
-- Static text for visual UI
--
function Spawner:spawnText()
	if self.layers['Text'] then
		for __, text in pairs(self.layers['Text']) do
			UI['text'](text)
		end
	end
end

-- Spawn Units
-- Dynamic bodies that interact with each other
--
function Spawner:spawnUnits()
	if self.layers['Units'] then
		for __, unit in pairs(self.layers['Units']) do
			if unit.name then
				local existing = self.world:fetchEntityById(unit.id)
				
				if not existing then
				-- Spawn Unit
				-- *Copy as to not overwrite
					Entities[unit.name](_:copy(unit))
				else
				-- refill unit health
					existing.health = existing.initHealth
				end
			else
			-- Error!
				error('Missing unit name!')
			end
		end
	end
end

function Spawner:spawnEnvironment()
	for name, objects in pairs(self.environment) do
		for __, object in pairs(objects) do
			if name then
				-- Copy as to not overwrite
				Entities[name](_:copy(object))
			else
			-- Error!
				error('Missing enviornment name!')
			end
		end
	end
end

return Spawner