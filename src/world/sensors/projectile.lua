-- Weapon Projectile
-- Ignores gravity, given initial impulse, invokes damage
--

local Modern     = require 'modern'
local Projectile = Modern:extend()

-- New Projectile
-- Host is firing weapon
--
function Projectile:new(host, data)
	self.name     = 'Projectile'
	self.uuid     = Util:uuid()
	self.category = 'Projectile'
	self.host     = host
	self.damage   = host.weapon.damage or 0

	-- -- lifetime
	self.timer = Timer.new()
	self.timer:every(0.25, function() self:decay() end)

	-- calculate impulse
	local angle = data.angle or host.host.aimAngle
	local mag   = host.weapon.speed
	local impulse = Vec2(0, 0):polar(angle, mag)

	-- body
	self.body  = lp.newBody(_World.world, data.x, data.y, 'dynamic')
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

-- Decay damage for specified amount
--
function Projectile:decreaseDamage()
	self.damage = self.damage - (host.weapon.decay or 1)

	-- destroy
	if self.damage <= 0 then
		self:destroy()
	end
end

-- Update
--
function Projectile:update(dt)
	--
end

-- Flag for removal
--
function Projectile:destroy()
	self.timer:clear()
	--
	self.remove = true
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

-- Check for separations
--
function Projectile:endContact(other, col)
	--
end

-- Draw Projectile
--
function Projectile:draw()
	lg.setColor(Config.color.sensor.projectile)
	self.shape:draw()
end

return Projectile