-- Translate Event
-- Translates target's position
--

local Event     = require 'src.world.events.event'
local Translate = Event:extend()

function Translate:new(data)
	Event.new(self, 'Translate', data)
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
	self.once  = data.properties.once  or false

	-- animation/tween
	self.timer = Timer.new()

	-- flags
	self.running = nil
end

-- Teardown
--
function Translate:destroy()
	self.timer:clear()
	--
	Event.destroy(self)
end

-- Check for contacts
--
function Translate:beginContact(other, col)
	if col:isTouching() and not self.running then
		self.hosting = self.hosting + 1
		self:trigger()
	end
end

-- Check for separations
--
function Translate:endContact(other, col)
	self.hosting = self.hosting - 1
end

-- Start movement animation
--
function Translate:trigger()
	self.running = true
	--
	-- animation tween
	-- move target to goal location
	self.timer:tween(self.delay, self.pos, {
		x = self.goalPos.x,
		y = self.goalPos.y
	}, self.tween,
	function()
		if self.once then
			self:destroy()
		end
	end)
end

-- Update
--
function Translate:update(dt)
	self.timer:update(dt)

	-- move target if running
	if self.running then
		self.target:setPosition(self.pos:unpack())
	end
end

return Translate