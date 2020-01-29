-- Credits Screen
--

local Base    = require 'src.gamestates.base'
local Credits = Base:extend()

-- Init
--
function Credits:init()
    self.id    = 'credits'
	self.name  = 'credits'

	self.color1 = {1,1,1,0}
	self.color2 = {1,1,1,0}
	self.color3 = {1,1,1,0}
	self.page   = 0
end

-- Enter Credits Screen
--
function Credits:enter(from, ...)
	self.from = from -- previous screen
	--
	self:setControl('complete')
	--
	self.timer = Timer.new()
	self.timer:script(function(wait)
		-- Page 1
		self.page = 1
		self.timer:tween(2, self.color1, {1,1,1,1}, 'linear')
		wait(2)
		self.timer:tween(2, self.color2, {1,1,1,1}, 'linear')
		wait(3)
		self.timer:tween(2, self.color3, {1,1,1,1}, 'linear')
		wait(3)
		-- Page 2
		self.page = 2
		self.color1 = {1,1,1,0}
		self.color2 = {1,1,1,0}
		self.color3 = {1,1,1,0}
		self.timer:tween(2, self.color1, {1,1,1,1}, 'linear')
		wait(2)
		self.timer:tween(2, self.color2, {1,1,1,1}, 'linear')
		wait(3.5)
		self.timer:tween(2, self.color3, {1,1,1,1}, 'linear')
		wait(8)
		-- Page 3
		self.page = 3
		self.color1 = {1,1,1,0}
		self.color2 = {1,1,1,0}
		self.color3 = {1,1,1,0}
		self.timer:tween(2, self.color1, {1,1,1,1}, 'linear')
		wait(2)
		self.timer:tween(2, self.color2, {1,1,1,1}, 'linear')
		wait(3.5)
		self.timer:tween(2, self.color3, {1,1,1,1}, 'linear')
		wait(10)
		-- Page 4
		self.page = 4
		self.color1 = {1,1,1,0}
		self.color2 = {1,1,1,0}
		self.color3 = {1,1,1,0}
		self.timer:tween(2, self.color1, {1,1,1,1}, 'linear')
		wait(2)
		self.timer:tween(2, self.color2, {1,1,1,1}, 'linear')
		wait(3.5)
		self.timer:tween(2, self.color3, {1,1,1,1}, 'linear')
		wait(8)
		--
		Gamestate.switch(Gamestates['gameover'])
	end)
end

function Credits:leave()
	self:unregisterControls()
	--
	Base.leave(self)
end

-- Update
--
function Credits:update(dt)
	self.timer:update(dt)
end

-- Draw
--
function Credits:draw()
	-- title
	lg.setColor(self.color1)
    lg.setFont(Config.ui.font.xl)
	lg.printf(Credits_[self.page].title, 0, 100, Config.width, 'center')
	
	-- subtitle
	lg.setColor(self.color2)
    lg.setFont(Config.ui.font.md)
	lg.printf(Credits_[self.page].subtitle, 0, 150, Config.width, 'center')
	lg.printf('[Q]uit', 25, 25, 100, 'right')

	-- text
	lg.setColor(self.color3)
    lg.setFont(Config.ui.font.md)

    local y = Config.height*0.4
	for __, line in pairs(Credits_[self.page].text) do
		lg.printf(line, 150, y, Config.width, 'left')
		y = y + 36
	end
end

return Credits