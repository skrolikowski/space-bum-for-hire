-- Player entity
-- Shane Krolikowski
--

local Entity = require 'src.entities.entity'
local Player = Entity:extend()

function Player:new(data)
	self.width    = data.width
	self.height   = data.height
	self.axis     = Vec2()
	self.heading  = { name = 'E', angle = 0 }
	self.cooldown = { now = 0, max = 1 }
	-- scaling
	self.sx = 1.25            -- x-sprite scaling
	self.sy = 1.25            -- y-sprite scaling
	self.bx = 0.5 * self.sx   -- x-bound scaling
	self.by = 1   * self.sy   -- y-bound scaling

	-- @overrides
	data.x         = data.x + data.width / 2
	data.y         = data.y + data.height / 2
	data.density   = 50
	data.bodyType  = 'dynamic'
	data.shapeData = {
		self.width  * self.bx,  -- shape width (scaled)
		self.height * self.by   -- shape height (scaled)
	}

	Entity.new(self, data)
	
	-- attributes
	self.speed       = 1000
	self.speedMax    = 2 * self.speed
	self.jumpHeight  = 3000
	self.initJumpVel = _.__sqrt(2 * Config.world.gravity.y * self.jumpHeight)
	self.initImpulse = self:mass() * self.initJumpVel

	-- physics
	self:fixedRotation(true)
	self.contactNormal = Vec2()
	-- filters
	-- data.categories = {}  -- belongs to...
	-- data.mask       = {}  -- ingores these...

	-- flags
	self.isMirrored = false
	self.isFlipped  = false
	self.onGround   = false
	self.onWall     = false
	self.lockedIn   = false

	-- behavior/animation
	self.behavior = Behaviors['idle'](self)
	self.weapon   = Weapons['pistol'](self)

	-- -- keyboard events
	_:on('key_w_on',      function() self:keyOn('w')         end)
	_:on('key_a_on',      function() self:keyOn('a')         end)
	_:on('key_s_on',      function() self:keyOn('s')         end)
	_:on('key_d_on',      function() self:keyOn('d')         end)
	_:on('key_l_on',      function() self:setLock()          end)
	_:on('key_space_on',  function() self:keyOn('space_on')  end)
	_:on('key_a_down',    function(dt, et) self:move(dt, et) end)
	_:on('key_d_down',    function(dt, et) self:move(dt, et) end)
	_:on('key_k_down',    function(dt, et) self.weapon:trigger(dt, et) end)
	_:on('key_w_off',     function() self:keyOff('w')         end)
	_:on('key_a_off',     function() self:keyOff('a')         end)
	_:on('key_d_off',     function() self:keyOff('d')         end)
	_:on('key_s_off',     function() self:keyOff('s')         end)
	_:on('key_l_off',     function() self:setLock()           end)
	_:on('key_k_off',     function() self.weapon:holster()    end)
	_:on('key_space_off', function() self:keyOff('space_off') end)

	-- camera control
	_Camera.x, _Camera.y = self:getPosition()
end

-- Convienence keyOn method
--
function Player:keyOn(key)
	if key == 'w' then
		self.axis.y = -1
	elseif key == 'a' then
		self.running    = true
		self.isMirrored = true
		self.axis.x = -1
	elseif key == 's' then
		self.crouching = true
		self.axis.y = 1
	elseif key == 'd' then
		self.axis.x = 1
		self.running    = true
		self.isMirrored = false
	elseif key == 'space_on' then
	-- Jump
		self.jumping = true
	end
end

-- Convienence keyOff method
--
function Player:keyOff(key)
	if key == 's' then
	-- South
		self.standing  = (self.behavior.name == 'crouch')
		self.crouching = false
		self.axis.y = 0
	elseif key == 'a' or key == 'd' then
	-- East/West
		self.running = false
		self.axis.x  = 0
	elseif key == 'w' then
	-- North
		self.axis.y = 0
	elseif key == 'space_off' then
	-- Terminate Jump
		self.jumping = false
		self:terminateJump()
	end
end

-- Destroy!
--
function Player:destroy(dt, et)
	Entity.destroy(self)

	-- -- release keyboard events
	_:off('key_w_on')
	_:off('key_a_on')
	_:off('key_s_on')
	_:off('key_d_on')
	_:off('key_l_on')
	_:off('key_space_on')
	_:off('key_a_down')
	_:off('key_d_down')
	_:off('key_k_down')
	_:off('key_w_off')
	_:off('key_a_off')
	_:off('key_d_off')
	_:off('key_s_off')
	_:off('key_l_off')
	_:off('key_k_off')
	_:off('key_space_off')
end

-- Shoot weapon
--
function Player:shoot(dt, et)
	self.weapon:fire()
	self.shooting = true
end

-- Toggle lock position
--
function Player:setLock()
	if self.locking then
		self.locking  = false
		self.lockedIn = false
	else
		self.locking = true
		--
		if self.crouching then
			self.lockedIn = 'crouch'
		else
			self.lockedIn = 'idle'
		end
	end
end

-- Move right/left
--
function Player:move(dt, et)
	local vx, vy = self:getLinearVelocity()
	local ix, iy = 0, 0
	local speed  = self.speed

	if self.crouching or self.lockedIn ~= false then
		return
	end

	-- apply movement force
	if not self.onGround then
		speed = speed * 0.75
	end

	if self.axis.x < 0  then
		ix = self:mass() * (-speed - vx)
	elseif self.axis.x > 0 then
		ix = self:mass() * ( speed - vx)
	end

	self:applyForce(ix, iy)
end

-- Terminate jump
--
function Player:terminateJump()
	local vx, vy = self:getLinearVelocity()

	if vy < 0 then
		self:setLinearVelocity(vx, 0)
	end
end

-- Event - beginContact
--
function Player:beginContact(other, col)
	if col:isTouching() then
		if other.name == 'Platform' then
			if select(2, col:getNormal()) < 0 then
				self.onGround = true
			end

			if select(1, col:getNormal()) > 0 then
				self.onWall = true
			end
		end
	end
end

-- Event - endContact
--
function Player:endContact(other, col)
	-- if other.name == 'Platform' then
		
	-- end
end

-- Update
--
function Player:update(dt)
    local cx, cy = self:getPosition()
    local vx, vy = self:getLinearVelocity()

	_Camera:update(dt)
    _Camera:follow(cx, cy)

    -- Mini State Machine ------------

    if self.onGround then
    -- on Ground
    	if self.jumping then
    	-- Jumping
    		self:setBehavior('jump')
    	elseif self.lockedIn then
    	-- Locked in..
    		self:setBehavior(self.lockedIn)
		elseif self.crouching then
		-- Crouching
			self:setBehavior('crouch')
		elseif self.running then
		-- Running
			self:setBehavior('run')
		elseif self.standing then
		-- Standing
			self:setBehavior('standup')
		elseif _.__abs(vx) > 100 then
		-- Sliding
			self:setBehavior('slide')
		else
		-- Idle
			self:setBehavior('idle')
		end
    else
    -- In Air
    	if vy > 0 then
    		self:setBehavior('fall')
		end
    end
	----------------------------------

	self.behavior:update(dt)
	self.weapon:update(dt)

	Entity.update(self, dt)
end

function Player:setBehavior(name)
	if self.behavior.name ~= name then
		self.behavior:destroy()
		self.behavior = Behaviors[name](self)
	end
end

-- Draw
--
function Player:draw()
	if self.visible then
		self.behavior:draw()
		self.weapon:draw()
    end

    Entity.draw(self)
end

return Player