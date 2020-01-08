-- Base Gamestate
-- Shane Krolikowski
--

local Modern = require 'modern'
local Base   = Modern:extend() 

-- Init
--
function Base:init(data)
	local STI = require 'vendor.sti.sti'

	self.name    = data.name
	self.map     = STI(data.map)
	self.width   = self.map.width  * self.map.tilewidth
	self.height  = self.map.height * self.map.tileheight
	self.control = 'none'
	self.camera  = Camera(0, 0, Config.scale)

	-- special effects
	self.effects = {}

	-- flags
	self.comments = false
	self.isPaused = false
end

-- Enter screen
--
function Base:enter(from, ...)
	self.from = from -- previous screen

	_World = World()   -- create world
    Spawner(self.map)  -- spawn entities

    --
    Config.world.player.location = self.name
end

-- Resume screen
function Base:resume()
	-- register game controls
	self:registerControls()
end

-- Leave Base Screen
--
function Base:leave()
	_World:destroy()
	--
	-- unregister game controls
	self:unregisterControls()
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
	for code, func in pairs(Control_[self.control]) do
		_:on(code, func)
	end
end

-- Unregister Base Controls
--
function Base:unregisterControls()
	for code, __ in pairs(Control_[self.control]) do
		_:off(code)
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

	-- update effects
    for i = #self.effects, 1, -1 do
    	if self.effects[i].remove then
    	-- remove
    		table.remove(self.effects, i)
    	else
    	-- update
    		self.effects[i]:update(dt)
    	end
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

    -- draw effects
    for __, effect in pairs(self.effects) do
    	effect:draw()
    end
end

return Base