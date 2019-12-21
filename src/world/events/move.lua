-- Event - Move Host
-- Shane Krolikowski
--

local Event = require 'src.world.events.event'
local Move  = Event:extend()

function Move:new(data)
	data.name  = 'MoveEvent'
	
	-- animation settings
	self.replay = data.properties.replay or false
	self.delay  = data.properties.delay  or 0
	self.pause  = data.properties.pause  or 3
	self.moveOut = {
		delay = data.properties.delayOut or 10,
		tween = data.properties.tweenOut or 'linear'
	}
	self.moveIn = {
		delay = data.properties.delayIn or 10,
		tween = data.properties.tweenIn or 'linear'
	}

	Event.new(self, data)
	--

	-- properties
	self.target   = _World:fetchEntityById(data.properties['Target'])
	self.pos      = Vec2(self.target:getPosition())
	self.firstPos = Vec2(self.target:getPosition())
	self.lastPos  = Vec2(data.properties['Goal.x'], data.properties['Goal.y'])

	-- animation/tween
	self.running = nil
	self.bodies  = 0
	self.timer   = Timer.new()

	-- body & shape	
	self.body  = lp.newBody(_World.world, data.x + data.width / 2, data.y + data.height / 2, 'static')
	self.shape = Shapes['rectangle'](data.width, data.height)
	self.shape:setBody(self.body)

	-- fixture
	self.fixture = lp.newFixture(self.body, self.shape.shape, 1)
	self.fixture:setUserData(self)
	self.fixture:setSensor(true)
end

-- Check for contacts
--
function Move:beginContact(other, col)
	if col:isTouching() and not self.running then
		self.bodies = self.bodies + 1
		self:trigger()
	end
end

-- Check for separations
--
function Move:endContact(other, col)
	self.bodies = self.bodies - 1
end

-- Start movement animation
--
function Move:trigger()
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

				-- replay?
				if self.replay and self.bodies > 0 then
					self.timer:after(self.delay, function()
						self:trigger()
					end)
				end
			end)
	end)
end

-- Update
--
function Move:update(dt)
	self.timer:update(dt)

	-- move target if running
	if self.running then
		self.target:setPosition(self.pos:unpack())
	end
end

return Move