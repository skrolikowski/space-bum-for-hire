-- Bounds sensor
--

local Modern = require 'modern'
local Bounds = Modern:extend()

function Bounds:new(host, x, y, w, h)
	self.name     = 'Bounds'
	self.uuid     = Util:uuid()
	self.category = 'Sensor'
	self.host     = host

	-- body
	self.body = lp.newBody(host.world, x+w/2, y+h/2, 'static')

	-- shape
	self.shape = Shapes['rectangle'](x, y, w, h)
	self.shape:setBody(self.body)

	-- fixture
	self.fixture = lp.newFixture(self.body, self.shape.shape, 1)
	self.fixture:setGroupIndex(Config.world.filter.group.sensor)
	self.fixture:setCategory(Config.world.filter.category.sensor)
	self.fixture:setMask(unpack(Config.world.filter.mask.sensor))
	self.fixture:setUserData(self)
	self.fixture:setSensor(true)
end

-- Flag for removal
--
function Bounds:destroy()
	self.remove = true
end

-- Set inBounds callback
--
function Bounds:inBounds(callback)
	self.onContact = callback
end

-- Set outOfBounds callback
--
function Bounds:outOfBounds(callback)
	self.offContact = callback
end

-- Check for contacts
--
function Bounds:beginContact(other, col)
	if self.onContact then
		self.onContact(other, col)
	end
end

-- Check for seperations
--
function Bounds:endContact(other, col)
	if self.offContact then
		self.offContact(other, col)
	end
end

-- Update
--
function Bounds:update(dt)
	--
end

-- Draw sensor
--
function Bounds:draw()
	lg.setColor(Config.color.sensor.dispatcher)
	self.shape:draw()
end

return Bounds