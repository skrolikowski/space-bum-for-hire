-- Game Entity
-- Shane Krolikowski
--

local Modern = require 'modern'
local Entity = Modern:extend()

function Entity:new(...)
	local params   = ...
	local x, y     = params.x, params.y
	local bodyType = params.bodyType or 'static'
	local density  = params.density or 1
	local shape    = params.shape

	self.body    = lp.newBody(_World.world, x, y, bodyType)
	self.shape   = Shapes[shape.type](unpack(shape.props))
	self.fixture = lp.newFixture(self.body, self.shape.shape, density)

	self.shape:setBody(self.body)
	self.fixture:setUserData(self)
end

function Entity:destroy()
	self.body:destroy()
	self.fixture:destroy()
end

-- [???] x,y-position of body
--
function Entity:position(value)
	if value then
		self.body:setPosition(value:unpack())
	else
		return Vec2(self.body:getPosition())
	end
end

-- [World] x-position of body
--
function Entity:x(value)
	if value then
		self.body:setX(value)
	else
		return self.body:getX()
	end
end

-- [World] y-position of body
--
function Entity:y(value)
	if value then
		self.body:setY(value)
	else
		return self.body:getY()
	end
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
function Entity:linearVelocity(value)
	if value then
		self.body:setLinearVelocity(value:unpack())
	else
		return Vec2(self.body:getLinearVelocity())
	end
end

-- Continuous force
--
function Entity:applyForce(fx, fy, x, y)
	self.body:applyForce(fx, fy, x, y)
end

-- Instantaneous motion
--
function Entity:applyLinearImpulse(ix, iy, x, y)
	self.body:applyLinearImpulse(ix, iy, x, y)
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

-- Update entity
--
function Entity:update(dt)
	--
end

-- Draw entity
--
function Entity:draw()
	self.shape:draw()
end

return Entity