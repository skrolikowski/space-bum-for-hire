-- Boomarang Event
-- Moves target from point a -> b -> a
--

local Event     = require 'src.world.events.event'
local Boomarang = Event:extend()

function Boomarang:new(data)
	Event.new(self, 'Boomarang', data)
	--
	-- animation settings
	self.auto   = data.properties.auto   or false
	self.delay  = data.properties.delay  or 0
	self.pause  = data.properties.pause  or 3
	self.moveOut = {
		delay = data.properties.delayOut or 5,
		tween = data.properties.tweenOut or 'linear'
	}
	self.moveIn = {
		delay = data.properties.delayIn or 5,
		tween = data.properties.tweenIn or 'linear'
	}

	-- properties
	self.target   = Gamestate:current().world:fetchEntityById(data.properties['Target'])
	self.pos      = Vec2(self.target:getPosition())
	self.firstPos = Vec2(self.target:getPosition())
	self.lastPos  = Vec2(data.properties['Goal.x'], data.properties['Goal.y'])

	-- animation/tween
	self.running = false
	self.timer   = Timer.new()

	if self.auto then
		self:trigger()
	end
end

-- Check for contacts
--
function Boomarang:beginContact(other, col)
	if col:isTouching() and not self.running then
		self:trigger()
	end
end

-- Check for separations
--
function Boomarang:endContact(other, col)
	--
end

-- Start movement animation
--
function Boomarang:trigger()
	self.running = true
	--
	local delay    = self.delay
	local delayOut = self.moveOut.delay
	local pause    = self.moveOut.delay + self.pause
	local tweenOut = self.moveOut.tweenOut
	local delayIn  = self.moveIn.delay
	local tweenIn  = self.moveIn.tween

	-- sequence of movements:
	-- 1) move into first position
	-- 2) take a rest
	-- 3) move back to starting position
	self.timer:script(function(wait)
		wait(delay)
		self.timer:tween(delayOut, self.pos, {x = self.lastPos.x, y = self.lastPos.y}, tweenOut)
		wait(pause)
		self.timer:tween(delayIn, self.pos, {x = self.firstPos.x, y = self.firstPos.y}, tweenIn,
			function()
				self.running = false
				
				if self.auto then
					self:trigger()
				end
			end)
	end)
end

-- Update
--
function Boomarang:update(dt)
	self.timer:update(dt)

	-- move target if running
	if self.running then
		self.target:setPosition(self.pos:unpack())
	end
end

return Boomarang