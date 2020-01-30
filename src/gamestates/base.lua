-- Base Gamestate
-- Shane Krolikowski
--

local Modern = require 'modern'
local Base   = Modern:extend() 

-- Init
--
function Base:init(data)
	local STI = require 'vendor.sti.sti'

	self.id      = data.id
	self.name    = data.name
	self.map     = STI(data.map)
	self.width   = self.map.width  * self.map.tilewidth
	self.height  = self.map.height * self.map.tileheight
	self.control = nil
	
	-- camera
	self.camera  = Camera(0, 0, Config.scale)
	self.filming = nil
	self.timer   = Timer.new()

	-- world
	self.world   = nil
	self.spawner = nil

	-- flags
	self.comments = false
end

-- Enter screen
--
function Base:enter(from, ...)
	self.from     = from -- previous screen
	self.settings = ...
	--
	--
	if not self.world then
	-- fresh world
    	self:setWorld()
	elseif self.settings.respawn then
	-- respawn request
		self.spawner:spawnUnits()
		self.spawner:spawnEvents()
	end
end

-- Resume screen
function Base:resume()
	--
	self:registerControls()
end

-- Leave Base Screen
--
function Base:leave()
	-- nobody to film
	self.filming = nil
end

-- Set World
-- Spawn Entities
--
function Base:setWorld()
	if self.world ~= nil then
		self.world:destroy()
	end

	-- world
	self.world        = World(self.camera)
	self.world.width  = self.width
	self.world.height = self.height

	-- spawn entities
	self.spawner = Spawner(self.world, self.map)
	self.spawner:reset()
	--
	-- register world sensor
	-- remove bodies outside of bounds
	self.sensor = Sensors['bounds'](self.world, 0, self.height/2, self.width, Config.padding)
	self.sensor:outOfBounds(function(other, col)
	-- Handle `out of bounds`
		if other.name == 'Player' then
			self.player:die()
		elseif other.remove == nil then
			other:destroy()
		end
	end)
end

-- Gamestate World
--
function Base:getWorld()
	return self.world.world
end

-- Set controls
--
function Base:setControl(name)
	if self.control ~= name then
	-- Change in controls
		self:unregisterControls()
		self.control = name
		self:registerControls()
	end
end

-- Focus camera
--
function Base:lookAt(x, y)
	self.camera:lookAt(x, y)
end

-- Get camera
--
function Base:getCamera()
	return self.camera
end

-- Register Base Controls
--
function Base:registerControls()
	if self.control then
		for code, func in pairs(Control_[self.control]) do
			_:on(code, func)
		end
	end
end

-- Unregister Base Controls
--
function Base:unregisterControls()
	if self.control then
		for code, __ in pairs(Control_[self.control]) do
			_:off(code)
		end
	end
end

-- Quit game
--
function Base:quit()
	love.event.quit()
end

-- Update
--
function Base:update(dt)
	self.timer:update(dt)
	self.world:update(dt)
	--
	-- follow target
	if self.filming and not self.filming.remove then
		self:lookAt(self.filming:getPosition())
	end
end

-- Draw
--
function Base:draw()
    self.camera:draw(function()
        lg.setColor(Config.color.white)
        lg.draw(self.background)

        self.world:draw()

        lg.setColor(Config.color.white)
        lg.draw(self.foreground)
    end)
end

return Base