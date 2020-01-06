-- Base Gamestate
-- Shane Krolikowski
--

local Modern = require 'modern'
local Base   = Modern:extend() 

-- Init
--
function Base:init(name)
	local STI = require 'vendor.sti.sti'

	self.name    = name
	self.map     = STI('res/maps/' .. name .. '.lua')
	self.control = 'none'

	-- world init
	_World        = {}
	_World.width  = self.map.width  * self.map.tilewidth
	_World.height = self.map.height * self.map.tileheight
end

-- Enter screen
--
function Base:enter(from, ...)
	self.from = from -- previous screen

	-- controls
	self:setControl('none')

	_World = World()   -- create world
    Spawner(self.map)  -- spawn entities

    -- UI
    self.hud = UI['player_hud']()
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

-- Set camera
--
function Base:setCamera(name, ...)
	_Camera = Cameras[name](...)
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

-- Update Shapeship
--
function Base:update(dt)
	_World:update(dt)
	_Camera:update(dt)
	--
	self.hud:update(dt)
end

-- Draw Base
--
function Base:draw()
	self.hud:draw()
end

return Base