-- Spaceship Gamestate
-- Shane Krolikowski
--

local Base      = require 'src.gamestates.base'
local Spaceship = Base:extend()

-- Init
--
function Spaceship:init()
	Base.init(self, 'Spaceship')
	--
	-- canvas
    self.background = lg.newCanvas(_World.width, _World.height)
    lg.setCanvas(self.background)
    self.map:drawTileLayer('Background')
    self.map:drawTileLayer('Decoratives (BG)')
    self.map:drawTileLayer('Walls')
    self.map:drawTileLayer('Platforms')
    self.map:drawTileLayer('Decoratives (FG)')
    lg.setCanvas()
end

-- Register controls
--
function Spaceship:registerControls()
	--
	Base.registerControls(self)
end

-- Unregister controls
--
function Spaceship:unregisterControls()
	--
	Base.unregisterControls(self)
end

-- Quit game
--
function Spaceship:quitGame()
	love.event.quit()
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