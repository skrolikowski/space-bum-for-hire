-- Translate Event
-- Translates target's position
--

local Event     = require 'src.world.events.event'
local Translate = Event:extend()

function Translate:new(data)
	Event.new(self, 'Translate', data)
	--
	-- properties
	self.target  = Gamestate:current().world:fetchEntityById(data.properties['Target'])
	self.pos     = Vec2(self.target:getPosition())
	self.goalPos = Vec2(data.properties['Goal.x'], data.properties['Goal.y'])

	-- animation settings
	self.affects = Util:toBoolean({ data.properties.affects or 'Unit' })
	self.delay   = data.properties.delay or 0
	self.pause   = data.properties.pause or 1
	self.delay   = data.properties.delay or 3
	self.tween   = data.properties.tween or 'linear'
	self.once    = data.properties.once  or false

	-- animation/tween
	self.timer = Timer.new()

	-- flags
	self.running = false
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
		if self.affects[other.name] or self.affects[other.category] then
			self:trigger()
		end
	end
end

-- Start movement animation
--
function Translate:trigger()
	self.pos = Vec2(self.target:getPosition())

	if self.pos:distance(self.goalPos) < 80 then
		return
	end
	--
	-- animation tween
	-- move target to goal location
	self.running = true
	self.timer:tween(self.delay, self.pos, {
		x = self.goalPos.x,
		y = self.goalPos.y
	}, self.tween,
	function()
		self.running = false

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