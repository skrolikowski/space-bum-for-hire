-- World Event
--

local Modern = require 'modern'
local Event  = Modern:extend()

function Event:new(name, data)
	self.name = name or 'Event'
	self.data = data
	--
	self.id       = data.id
	self.category = data.category or 'Event'
	self.cx       = data.x + data.width / 2
	self.cy       = data.y + data.height / 2
	self.visible  = data.visible or false
	self.width    = data.width
	self.height   = data.height

	-- body & shape	
	self.body  = lp.newBody(_World.world, self.cx, self.cy, 'static')
	self.shape = Shapes['rectangle'](self.width, self.height)
	self.shape:setBody(self.body)

	-- fixture
	self.fixture = lp.newFixture(self.body, self.shape.shape, 1)
	self.fixture:setGroupIndex(Config.world.filter.group.event)
	self.fixture:setCategory(Config.world.filter.category.event)
	self.fixture:setMask(unpack(Config.world.filter.mask.event))
	self.fixture:setUserData(self)
	self.fixture:setSensor(true)
end

-- Body position
--
function Event:getPosition()
	return self.body:getPosition()
end

-- Body dimensions
--
function Event:dimensions()
	return self.shape:dimensions()
end

-- Shape bounds
--
function Event:bounds()
	return self.shape:bounds()
end

-- Flag for removal
--
function Event:destroy()
	self.remove = true
	self.body:destroy()
end

-- Event - beginContact
--
function Event:beginContact(other, col)
	--
end

-- Event - endContact
--
function Event:endContact(other, col)
	--
end

-- Update Event
function Event:update(dt)
	--
end

-- Draw Event
function Event:draw()
	lg.setColor(Config.color.sensor.event)
	self.shape:draw()
end

return Event