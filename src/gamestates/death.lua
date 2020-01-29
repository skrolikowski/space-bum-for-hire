-- Death Screen
--

local Base  = require 'src.gamestates.base'
local Death = Base:extend()

-- Init
--
function Death:init()
    self.id    = 'death'
	self.name  = 'Death'

	-- colors
	self.color1 = { 1, 1, 1, 0 }
	self.color2 = { 1, 1, 1, 0 }

end

-- Enter Death Screen
--
function Death:enter(from, ...)
	self.from    = from -- previous screen
	self.world   = from.world
	self.hud     = from.hud
	self.control = from.control
	--
	self.timer = Timer.new()
	self.timer:script(function(wait)
		self.timer:tween(1, self.color1, {1,1,1,1}, 'linear')
		wait(0.5)
		self.timer:tween(0.5, self.color2, {1,1,1,1}, 'linear')
		wait(1)
		self:setControl('death')
	end)
end

function Death:leave()
	self:unregisterControls()
	--
	Base.leave(self)
end

-- Load last checkpoint
--
function Death:continue()
	local checkpoint = Config.world.checkpoint.player

	-- respawn w/ fresh health
	Gamestate.switch(Gamestates[checkpoint.map], {
		from    = 'beam',
		col     = checkpoint.col,
		row     = checkpoint.row,
		respawn = true
	})
end

-- Update
--
function Death:update(dt)
	self.timer:update(dt)
	self.from:update(dt)
end

-- Draw
--
function Death:draw()
	self.from:draw()

	-- add dark overlay
	lg.setColor(Config.color.overlay)
	lg.rectangle('fill', 0, 0, Config.width, Config.height)

	-- display pause text
	lg.setColor(self.color1)
    lg.setFont(Config.ui.font.xl)
	lg.printf('You Are Dead.', 0, Config.height/3, Config.width, 'center')

	-- display keyboard shortcuts
	lg.setColor(self.color2)
    lg.setFont(Config.ui.font.md)
	lg.printf('[C]ontinue', Config.width/4, Config.height/2, Config.width/2, 'left')
	lg.printf('[Q]uit', Config.width/4, Config.height/2, Config.width/2, 'right')
end

return Death