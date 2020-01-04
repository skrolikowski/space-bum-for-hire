-- Spaceship Gamestate
-- Shane Krolikowski
--

local Spaceship = {}

-- Init
--
function Spaceship:init()
	local STI = require 'vendor.sti.sti'

	self.name = 'Spaceship'
	self.map  = STI('res/maps/Spaceship.lua')

	_World        = World()
    _World.width  = self.map.width  * self.map.tilewidth
    _World.height = self.map.height * self.map.tileheight

	-- canvas
    self.background = lg.newCanvas(_World.width, _World.height)
    lg.setCanvas(self.background)
    self.map:drawTileLayer('Background')
    self.map:drawTileLayer('Decoratives (BG)')
    self.map:drawTileLayer('Walls')
    self.map:drawTileLayer('Platforms')
    self.map:drawTileLayer('Decoratives (FG)')
    lg.setCanvas()

    -- spawn entities into map
    Spawner(self.map)
end

-- Enter screen
--
function Spaceship:enter(from, ...)
	self.from = from -- previous screen

	-- flags
	self.isPaused = false  -- game is paused?

	-- register game controls
	self:registerControls()
end

-- Resume screen
function Spaceship:resume()
	-- register game controls
	self:registerControls()
end

-- Leave Spaceship Screen
--
function Spaceship:leave()
	_World:destroy()
	--
	-- unregister game controls
	self:unregisterControls()
end

-- Register Spaceship Controls
--
function Spaceship:registerControls()
	-- keyboard events
    _:on('key_escape', function() self:quitGame() end)
    _:on('key_q',      function() self:quitGame() end)
end

-- Unregister Spaceship Controls
--
function Spaceship:unregisterControls()
	-- release keyboard events
	_:off('key_escape')
end

-- Quit game
--
function Spaceship:quitGame()
	love.event.quit()
end

-- Pause/unpause
--
function Spaceship:pause()
	if self.isPaused then
		self.isPaused = false

		if Gamestate.current() ~= Spaceship then
			return Spaceshipstate.pop()
		end
	else
		self.isPaused = true
		self:unregisterControls()

		if Gamestate.current() ~= Pause then
			return Spaceshipstate.push(Pause)
		end
	end
end

-- Update Shapeship
--
function Spaceship:update(dt)
	if self.isPaused then
		return
	end

	_World:update(dt)
end

-- Draw Spaceship
--
function Spaceship:draw()
	_Camera:draw(function()
        lg.setColor(Config.color.white)
        lg.draw(self.background)

        _World:draw()

        lg.setColor(Config.color.white)
        self.map:drawTileLayer('Foreground')
    end)
end

return Spaceship