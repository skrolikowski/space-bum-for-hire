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
	self.camera  = Camera(0, 0, Config.scale)
	self.filming = nil

	-- flags
	self.comments = false
	self.isPaused = false
end

-- Enter screen
--
function Base:enter(from, ...)
	self.from  = from -- previous screen
	self.timer = Timer.new()

	-- create world
	_World        = World()
	_World.width  = self.width
	_World.height = self.height

	-- spawn entities
    Spawner(self.map)
end

-- Resume screen
function Base:resume()
	-- register game controls
	-- self:registerControls()
end

-- Leave Base Screen
--
function Base:leave()
	-- clear timer
	self.timer:clear()
	-- nobody to film
	self.filming = nil
	-- destroy world and all entities
	_World:destroy()
	-- unregister game controls
	-- self:unregisterControls()
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
	_World:update(dt)
	--
	self.timer:update(dt)

	-- follow target
	if self.filming then
		self:lookAt(self.filming:getPosition())
	end
end

-- Draw
--
function Base:draw()
    self.camera:draw(function()
        lg.setColor(Config.color.white)
        lg.draw(self.background)

        _World:draw()

        lg.setColor(Config.color.white)
        lg.draw(self.foreground)
    end)
end

return Base