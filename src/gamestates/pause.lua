-- Pause Screen
--

local Base  = require 'src.gamestates.base'
local Pause = Base:extend()

-- Init
--
function Pause:init()
    self.id   = 'pause'
	self.name = 'Pause'
end

-- Enter Pause Screen
--
function Pause:enter(from, ...)
	self.from = from -- previous screen
end

-- Unpause game
--
function Pause:pause()
	return Gamestate.pop()
end

-- Update
--
function Pause:update(dt)
	--
end

-- Draw
--
function Pause:draw()
	self.from:draw()

	-- add dark overlay
	lg.setColor(Config.color.overlay)
	lg.rectangle('fill', 0, 0, Config.width, Config.height)

	-- display pause text
	lg.setColor(Config.color.white)
    lg.setFont(Config.ui.font.xl)
	lg.printf('Pause', 0, Config.height/2, Config.width, 'center')
end

return Pause