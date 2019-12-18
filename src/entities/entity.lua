-- Game Entity
-- Shane Krolikowski
--

local Modern = require 'modern'
local Entity = Modern:extend()

function Entity:new(data)
	self.id          = data.id
	self.name        = data.name        or 'Entity'
	self.shapeType   = data.shape       or 'rectangle'
	self.visible     = data.visible     or true
	self.bodyType    = data.bodyType    or 'static'
	self.density     = data.density     or 1
	self.friction    = data.friction    or 0.25
	self.restitution = data.restitution or 0.0
	self.isSensor    = data.isSensor    or false

	-- body & shape	
	self.body  = lp.newBody(_World.world, data.x, data.y, self.bodyType)
	self.shape = Shapes[self.shapeType](unpack(data.shapeData))
	self.shape:setBody(self.body)

	-- fixture
	self:setFixture()
end

-- Create fixture around
function Entity:setFixture()
	if self.fixture ~= nil then
		self.fixture:destroy()
	end

	self.fixture = lp.newFixture(self.body, self.shape.shape, self.density)
	self.fixture:setUserData(self)
	self.fixture:setFriction(self.friction)
	self.fixture:setRestitution(self.restitution)
	self.fixture:setSensor(self.isSensor)
	-- self.fixture:setFilterData(
	-- 	self.group      or 0,
	-- 	self.categories or 1,
	-- 	self.mask       or 65535
	-- )
end

function Entity:destroy()
	self.fixture:destroy()
	self.body:destroy()
end

-- Set x,y-position of body
--
function Entity:setPosition(x, y)
	self.body:setPosition(x, y)
end

-- Get x,y-position of body
--
function Entity:getPosition()
	return self.body:getPosition()
end

-- Angle of body
--
function Entity:angle(value)
	if value then
		self.body:setAngle(value)
	else
		return self.body:getAngle()
	end
end

-- Body type (i.e. dynamic, static)
--
function Entity:type(value)
	if value then
		self.body:setType(value)
	else
		return self.body:getType()
	end
end

-- Whether body's rotation is locked..
--
function Entity:fixedRotation(value)
	if value then
		self.body:setFixedRotation(value)
	else
		return self.body:isFixedRotation()
	end
end

-- Body mass
-- Greater mass = greater force required
--
function Entity:mass(value)
	if value then
		self.body:setMass(value)
	else
		return self.body:getMass()
	end
end

-- Body inertia
-- Greater inertia = greater torque required
--
function Entity:inertia(value)
	if value then
		self.body:setInertia(value)
	else
		return self.body:setInertia()
	end
end

-- Rate of decrease of angular velocity over time
--
function Entity:angularDamping(value)
	if value then
		self.body:setAngularDamping(value)
	else
		return self.body:getAngularDamping()
	end
end

-- Rate of decrease of linear velocity over time
--
function Entity:linearDamping(value)
	if value then
		self.body:setLinearDamping(value)
	else
		return self.body:getLinearDamping()
	end
end

-- Rate of change of angle over time
--
function Entity:angularVelocity(value)
	if value then
		self.body:setAngularVelocity(value)
	else
		return self.body:getAngularVelocity()
	end
end

-- Rate of change of position over time
--
function Entity:setLinearVelocity(...)  -- x, y
	self.body:setLinearVelocity(...)
end

-- Rate of change of position over time
--
function Entity:getLinearVelocity()
	return self.body:getLinearVelocity()
end

-- Continuous force
--
function Entity:applyForce(...)  -- fx, fx, [x, y]
	self.body:applyForce(...)
end

-- Instantaneous motion
--
function Entity:applyLinearImpulse(...)  -- ix, ix, [x, y]
	self.body:applyLinearImpulse(...)
end

-- Instantaneous addition to body momentum
--
function Entity:applyAngularImpulse(impulse)
	self.body:applyAngularImpulse(impulse)
end

-- Apply angular velocity (spin) force
--
function Entity:applyTorque(torque)
	self.body:applyTorque(torque)
end

-- Is fixture a sensor?
-- Sensors only call beginContact & endContact
--
function Entity:sensor(value)
	if value then
		self.fixture:setSensor(value)
	else
		return self.fixture:isSensor()
	end
end

-- Friction - slide reaction
-- Greater friction = Rougher texture
--
function Entity:friction(value)
	if value then
		self.fixture:setFriction(value)
	else
		return self.fixture:getFriction()
	end
end

-- Restitution - bounce reaction
-- Greater restitution = Higher bounce
--
function Entity:restitution(value)
	if value then
		self.fixture:setRestitution(value)
	else
		return self.fixture:getRestitution()
	end
end

-- Density
--
function Entity:density(value)
	if value then
		self.fixture:setDensity(value)
	else
		return self.fixture:getDensity()
	end
end

-- Category (i.e. 1, 2, 3, ..., 16)
--
function Entity:setCategory(...)
	return self.fixture:setCategory(...)
end

-- Mask (i.e. 1, 2, 3, ..., 16)
-- Intersecting masks = IGNORE
--
function Entity:setMask(...)
	return self.fixture:setMask(...)
end

-- Group Index
--
function Entity:setGroupIndex(group)
	return self.fixture:setGroupIndex(group)
end

-- Test if line segment intersects with entity's shape
--
function Entity:rayCast(...)
	return self.shape.shape:rayCast(...)
end

-- Test if point is within the entity's shape
--
function Entity:testPoint(...)
	return self.shape.shape:testPoint(...)
end

-- -- Resize shape - WIP
-- --
-- function Entity:resize(...)
-- 	self.shape = Shapes[self.shapeType](...)
-- 	self.shape:setBody(self.body)

-- 	-- reset fixture
-- 	self:setFixture()
-- end

-- Event - beginContact
--
function Entity:beginContact(other, col)
	--
end

-- Event - endContact
--
function Entity:endContact(other, col)
	--
end

-- Event - preSolve
--
function Entity:preSolve(other, col)
	--
end

-- Event - postSolve
--
function Entity:postSolve(other, col, norm, tang)
	--
end

-- Update entity
--
function Entity:update(dt)
	--
end

-- Draw entity
--
function Entity:draw()
	if self.visible then
		self.shape:draw()
	end
end

return Entity