-- Mountains Gamestate
-- Shane Krolikowski
--

local Mountains = {}

-- Init
--
function Mountains:init()
	local STI = require 'vendor.sti.sti'

	self.name = 'Mountains'
	self.map  = STI('res/maps/Mountains.lua')

	_World        = World()
    _World.width  = self.map.width  * self.map.tilewidth
    _World.height = self.map.height * self.map.tileheight

	-- canvas
    self.background = lg.newCanvas(_World.width, _World.height)
    lg.setCanvas(self.background)
    self.map:drawTileLayer('Background')
    self.map:drawTileLayer('Sharp Cliffs')
    self.map:drawTileLayer('Decoratives (BG)')
    self.map:drawTileLayer('Cliffs')
    self.map:drawTileLayer('Castle')
    self.map:drawTileLayer('Decoratives (MG)')
    self.map:drawTileLayer('Platforms')
    lg.setCanvas()

    -- spawn entities into map
    Spawner(self.map)
end

-- Enter screen
--
function Mountains:enter(from, ...)
	self.from = from -- previous screen

	-- flags
	self.isPaused = false  -- game is paused?

	-- register game controls
	self:registerControls()
end

-- Resume screen
function Mountains:resume()
	-- register game controls
	self:registerControls()
end

-- Leave Mountains Screen
--
function Mountains:leave()
	_World:destroy()
	--
	-- unregister game controls
	self:unregisterControls()
end

-- Register Mountains Controls
--
function Mountains:registerControls()
	-- keyboard events
    _:on('key_escape', function() self:quitGame() end)
    _:on('key_q',      function() self:quitGame() end)
end

-- Unregister Mountains Controls
--
function Mountains:unregisterControls()
	-- release keyboard events
	_:off('key_escape')
end

-- Quit game
--
function Mountains:quitGame()
	love.event.quit()
end

-- Pause/unpause
--
function Mountains:pause()
	if self.isPaused then
		self.isPaused = false

		if Gamestate.current() ~= Mountains then
			return Mountainsstate.pop()
		end
	else
		self.isPaused = true
		self:unregisterControls()

		if Gamestate.current() ~= Pause then
			return Mountainsstate.push(Pause)
		end
	end
end

-- Update Shapeship
--
function Mountains:update(dt)
	if self.isPaused then
		return
	end

	_World:update(dt)
end

-- Draw Mountains
--
function Mountains:draw()
	_Camera:draw(function()
        lg.setColor(Config.color.white)
        lg.draw(self.background)

        _World:draw()

        lg.setColor(Config.color.white)
        self.map:drawTileLayer('Foreground')
    end)
end

return Mountains