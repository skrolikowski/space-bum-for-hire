-- GameOver Screen
--

local Base    = require 'src.gamestates.base'
local GameOver = Base:extend()

-- Init
--
function GameOver:init()
    self.id    = 'gameover'
	self.name  = 'gameover'

	self.color = {1,1,1,1}
end

-- Enter GameOver Screen
--
function GameOver:enter(from, ...)
	self.from = from -- previous screen
	--
	self:setControl('complete')
	--
	self.timer = Timer.new()
	self.timer:tween(2, self.color, {1,1,1,1}, 'linear')
end

function GameOver:leave()
	self:unregisterControls()
	--
	Base.leave(self)
end

-- Update
--
function GameOver:update(dt)
	self.timer:update(dt)
end

-- Draw
--
function GameOver:draw()
	-- thanks!
	lg.setColor(self.color)
    lg.setFont(Config.ui.font.xl)
	lg.printf('Thank You For Playing!!!', 0, Config.height*0.3, Config.width, 'center')

    lg.setFont(Config.ui.font.md)
	lg.printf('[Q]uit', 25, 25, 100, 'right')
end

return GameOver