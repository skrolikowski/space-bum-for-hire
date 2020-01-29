-- Complete Screen
--

local Base     = require 'src.gamestates.base'
local Complete = Base:extend()

-- Init
--
function Complete:init()
    self.id    = 'complete'
	self.name  = 'Complete'

	self.color1 = {1,1,1,0}
	self.color2 = {1,1,1,0}
	self.color3 = {1,1,1,0}
end

-- Enter Complete Screen
--
function Complete:enter(from, ...)
	self.from    = from -- previous screen
	self.world   = from.world
	self.control = from.control
	--
	self:setControl('complete')
	--
	self.timer = Timer.new()
	self.timer:script(function(wait)
		self.timer:tween(2, self.color1, {1,1,1,1}, 'linear')
		wait(2)
		self.timer:tween(2, self.color2, {1,1,1,1}, 'linear')
		wait(3)
		self.timer:tween(2, self.color3, {1,1,1,1}, 'linear')
		wait(5)
		--
		Gamestate.switch(Gamestates['credits'])
	end)
end

function Complete:leave()
	self:unregisterControls()
	--
	Base.leave(self)
end

-- Update
--
function Complete:update(dt)
	self.timer:update(dt)
end

-- Draw
--
function Complete:draw()
	self.from:draw()

	-- add dark overlay
	lg.setColor(Config.color.overlay)
	lg.rectangle('fill', 0, 0, Config.width, Config.height)

	--
	lg.setColor(self.color1)
    lg.setFont(Config.ui.font.xl)
	lg.printf('Congratulations!', 0, Config.height*0.3, Config.width, 'center')
	
	--
	lg.setColor(self.color2)
    lg.setFont(Config.ui.font.md)
	lg.printf('Another entry in Space Bum\'s Journal. Onward!', 0, Config.height*0.4, Config.width, 'center')
	lg.printf('[Q]uit', 25, 25, 100, 'right')

	--
	lg.setColor(self.color3)
    lg.setFont(Config.ui.font.md)
	lg.printf('Maybe you and him will cross paths in the future...', 0, Config.height*0.45, Config.width, 'center')
end

return Complete