-- Base Gamestate
-- Shane Krolikowski
--

local Modern = require 'modern'
local Base   = Modern:extend() 

-- Init
--
function Base:init(name)
	local STI = require 'vendor.sti.sti'

	self.name = name
	self.map  = STI('res/maps/' .. name .. '.lua')

	_World        = World()
    _World.width  = self.map.width  * self.map.tilewidth
    _World.height = self.map.height * self.map.tileheight

    -- spawn entities into map
    Spawner(self.map)
end

-- Enter screen
--
function Base:enter(from, ...)
	self.from = from -- previous screen

	-- register game controls
	self:registerControls()
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

-- Register Base Controls
--
function Base:registerControls()
	-- keyboard events
    _:on('key_escape', function() self:quitGame() end)
    _:on('key_q',      function() self:quitGame() end)
end

-- Unregister Base Controls
--
function Base:unregisterControls()
	-- release keyboard events
	_:off('key_escape')
	_:off('key_q')
end

-- Update Shapeship
--
function Base:update(dt)
	_World:update(dt)
end

-- Draw Base
--
function Base:draw()
	--
end

return Base