-- Weapon Projectile
-- Ignores gravity, given initial impulse, invokes damage
--

local Modern     = require 'modern'
local Projectile = Modern:extend()

-- New Projectile
-- Host is firing weapon
--
function Projectile:new(host, x, y, impulse, damage)
	self.name     = 'Projectile'
	self.uuid     = Util:uuid()
	self.category = 'Projectile'
	self.host     = host
	self.damage   = damage or 0

	-- body	
	self.body  = lp.newBody(_World.world, x, y, 'dynamic')
	self.body:setGravityScale(0)
	self.body:applyLinearImpulse(impulse:unpack())

	-- shape
	self.shape = Shapes['circle'](host.radius or 1)
	self.shape:setBody(self.body)

	-- fixture
	self.fixture = lp.newFixture(self.body, self.shape.shape, 1)
	self.fixture:setGroupIndex(Config.world.filter.group.sensor)
	self.fixture:setCategory(Config.world.filter.category.sensor)
	self.fixture:setMask(unpack(Config.world.filter.mask.sensor))
	self.fixture:setUserData(self)
	self.fixture:setSensor(true)
end

-- Destroy fixture
--
function Projectile:destroy()
	self.fixture:destroy()
	self.body:destroy()
end

-- Check for collisions
--
function Projectile:beginContact(other, col)
	if other.name == 'Environment' then
		--TODO: audio?
		--TODO: animation?
		self:destroy()
	end
end

-- Draw Projectile
--
function Projectile:draw()
	lg.setColor(Config.color.sensor.projectile)
	self.shape:draw()
end

return Projectile