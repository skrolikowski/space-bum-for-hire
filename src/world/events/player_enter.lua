-- Event - Player Enter
-- --------------------
-- 1) Warp animation
-- 2) Spawn Player
-- 3) Destroy self
--

local Event       = require 'src.world.events.event'
local PlayerEnter = Event:extend()

function PlayerEnter:new(data)
	data.name = 'PlayerEnterEvent'
	Event.new(self, data)
	--
	-- properties
	self.x     = data.x + data.width / 2
	self.y     = data.y + data.height / 4
	self.sx    = 0.75
	self.sy    = 1.00
	self.color = { 1, 1, 1, 1 }

	-- animation
	self.sprite = Animator()
	self.sprite:addAnimation('warp', {
		image  = Config.image.spritesheet.particles.warp,
		width  = 102,
		height = 135,
		total  = 1,
		fps    = 30,
		frames = { { 1, 1, 7, 5 } },
		after  = function() self:destroy() end
	})
	-- focus!
	_Camera:follow(
		data.x + data.width / 2,
		data.y + data.height / 2
	)
	-- timing is everything
	self.timer = Timer.new()
	self.timer:after(0.85, function() self:spawnPlayer() end)
end

-- Teardown
--
function PlayerEnter:destroy()
	self.sprite:removeAnimation('warp')
	self.timer:clear()
	--
	Event.destroy(self)
end

-- Spawn Player to the World
--
function PlayerEnter:spawnPlayer()
	Entities['Player'](self.data)
end

-- Update animation
--
function PlayerEnter:update(dt)
	self.color[4] = _.__max(0, self.color[4] - dt / 2)
	--
	self.sprite:update(dt)
	self.timer:update(dt)
end

-- Draw animation
function PlayerEnter:draw()
	local w, h = self.sprite:dimensions()

	love.graphics.setColor(self.color)

	self.sprite:draw(self.x, self.y, 0, self.sx, self.sy, w/2, h/2)
end

return PlayerEnter