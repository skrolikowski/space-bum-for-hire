-- Event - Call Host
-- Shane Krolikowski
--

local Event = require 'src.world.events.event'
local Call  = Event:extend()

function Call:new(data)
	--@overrides
	data.name = 'CallEvent'
	data.cx   = data.x + data.width  / 2
	data.cy   = data.y + data.height / 2
	
	Event.new(self, data)
	--
	-- properties
	self.target  = _World:fetchEntityById(data.properties['Target'])
	self.pos     = Vec2(self.target:getPosition())
	self.goalPos = Vec2(data.properties['Goal.x'], data.properties['Goal.y'])
	self.hosting = 0
	
	-- animation settings
	self.delay = data.properties.delay or 0
	self.pause = data.properties.pause or 3
	self.delay = data.properties.delay or 10
	self.tween = data.properties.tween or 'linear'

	-- animation/tween
	self.timer = Timer.new()

	-- flags
	self.running = nil
end

-- Check for contacts
--
function Call:beginContact(other, col)
	if col:isTouching() and not self.running then
		self.hosting = self.hosting + 1
		self:trigger()
	end
end

-- Check for separations
--
function Call:endContact(other, col)
	self.hosting = self.hosting - 1
end

-- Start movement animation
--
function Call:trigger()
	self.running = true
	--
	-- animation tween
	-- move target to goal location
	self.timer:tween(self.delay, self.pos, {
		x = self.goalPos.x,
		y = self.goalPos.y
	}, self.tween)
end

-- Update
--
function Call:update(dt)
	self.timer:update(dt)

	-- move target if running
	if self.running then
		self.target:setPosition(self.pos:unpack())
	end
end

return Call