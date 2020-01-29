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
	self.from    = from -- previous screen
	self.world   = from.world
	self.control = from.control
	--
	self:setControl('pause')
	self.color = {1,1,1,0}
	--
	self.timer = Timer.new()
	self.timer:script(function(wait)
		self.timer:tween(1, self.color, {1,1,1,1}, 'linear')
	end)
end

-- Unpause
--
function Pause:unpause()
	self:unregisterControls()
	Gamestate.pop()
end

-- Update
--
function Pause:update(dt)
	self.timer:update(dt)
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
	lg.printf('Pause', 0, Config.height/3, Config.width, 'center')

	--
	-- display keyboard shortcuts
	lg.setColor(self.color)
    lg.setFont(Config.ui.font.md)
	lg.printf('[C]ontinue', Config.width/4, Config.height/2, Config.width/2, 'left')
	lg.printf('[Q]uit', Config.width/4, Config.height/2, Config.width/2, 'right')
end

return Pause