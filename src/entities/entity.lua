-- Game Entity
-- Shane Krolikowski
--

local Modern = require 'modern'
local Entity = Modern:extend()

function Entity:new(data)
	self.uuid        = Util:uuid()
	self.visible     = data.visible     or true
	self.id          = data.id          or 0
	self.category    = data.category    or nil
	self.name        = data.name        or 'Entity'
	self.bodyType    = data.bodyType    or 'static'
	self.shapeType   = data.shape       or 'rectangle'
	self.shapeData   = data.shapeData   or { 0, 0, data.width, data.height }
	self.density     = data.density     or 1
	self.friction    = data.friction    or 0.25
	self.restitution = data.restitution or 0.0
	self.isSensor    = data.isSensor    or false
	self.body        = lp.newBody(_World.world, data.x, data.y, self.bodyType)
	-- flags
	self.canDestroy = false
end

-- Flag for removal
--
function Entity:destroy()
	self.remove = true
	self.body:destroy()
end

-- Set whether sleeing is allowed or not
--
function Entity:setSleepingAllowed(...)
	self.body:setSleepingAllowed(...)
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

-- Entity aabb based on shape
--
function Entity:bounds()
	return self.shape:bounds()
end

-- Entity dimensions based on shape
--
function Entity:dimensions()
	return self.shape:dimensions()
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

-- Setup new fixture
--
function Entity:setFixture(shape, ...)
	if self.fixture then
	-- Remove current fixture
		self.fixture:destroy()
	end

	-- Create new shape with requested arguments
	self.shape = Shapes[shape](...)
	self.shape:setBody(self.body)

	-- Create new fixture connecting body to shape
	self.fixture = lp.newFixture(self.shape.body, self.shape.shape, self.density)
	self.fixture:setUserData(self)
	self.fixture:setFriction(self.friction)
	self.fixture:setRestitution(self.restitution)
	self.fixture:setSensor(self.isSensor)
end

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

-- Take damage
--
function Entity:damage(other, attack)
	if self.canDestroy then
		self.health = self.health - attack
		print('hit!', self.health)

		if self.health <= 0 then
			self:destroy()
		end
	end
end

-- Update entity
--
function Entity:update(dt)
	--
end

-- Draw entity
--
function Entity:draw()
	-- if self.visible then
	-- 	lg.setColor(Config.color.shape)
	-- 	self.shape:draw()
	-- end
end

return Entity