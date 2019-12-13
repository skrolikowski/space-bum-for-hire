-- Player entity
-- Shane Krolikowski
--

local Entity = require 'src.entities.entity'
local Player = Entity:extend()

function Player:new(data)
	self.width    = 64
	self.height   = 64
	self.heading  = { false, 'E' }
	self.cooldown = { now = 0, max = 1 }
	-- scaling
	self.sx = 1.25            -- x-sprite scaling
	self.sy = 1.25            -- y-sprite scaling
	self.bx = 0.5 * self.sx   -- x-bound scaling
	self.by = 1   * self.sy   -- y-bound scaling

	-- @overrides
	data.x         = data.x + self.width / 2
	data.y         = data.y + self.height / 2
	data.density   = 50
	data.bodyType  = 'dynamic'
	data.shape     = 'rectangle'
	data.shapeData = {
		self.width  * self.bx,  -- shape width (scaled)
		self.height * self.by   -- shape height (scaled)
	}

	Entity.new(self, data)
	
	-- attributes
	self.speed       = 40 * Config.world.meter
	self.speedMax    = 2 * self.speed
	self.jumpHeight  = 4 * data.height * Config.world.meter
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
	_:on('key_space_on',  function() self.jumping = true  end)
	_:on('key_space_off', function() self.jumping = false self:terminateJump() end)
	_:on('key_w_on',      function() self.heading.y = 'N' end)
	_:on('key_a_on',      function() self.heading.x = 'W' self.running = true self.isMirrored = true  end)
	_:on('key_s_on',      function() self.heading.y = 'S' self.crouching = true end)
	_:on('key_d_on',      function() self.heading.x = 'E' self.running = true self.isMirrored = false end)
	_:on('key_l_on',      function() self:setLock()           end)
	_:on('key_a_down',    function(dt, et) self:move(dt, et)  end)
	_:on('key_d_down',    function(dt, et) self:move(dt, et)  end)
	_:on('key_k_down',    function(dt, et) self.weapon:trigger(dt, et) end)
	_:on('key_w_off',     function() self:keyOff('w')         end)
	_:on('key_a_off',     function() self:keyOff('a')         end)
	_:on('key_d_off',     function() self:keyOff('d')         end)
	_:on('key_s_off',     function() self:keyOff('s')         end)
	_:on('key_l_off',     function() self:setLock()           end)
	_:on('key_k_off',     function() self.weapon:holster()    end)

	-- camera control
	_Camera.x, _Camera.y = self:getPosition()
end

function Player:keyOff(key)
	if key == 's' then
	-- South
		self.heading.y = false
		self.standing  = (self.behavior.name == 'crouch')
		self.crouching = false
	elseif key == 'a' or key == 'd' then
	-- East/West
		self.heading.x = false
		self.running = false
	elseif key == 'w' then
	-- North
		self.heading.y = false
	end

end

-- Destroy!
--
function Player:destroy(dt, et)
	Entity.destroy(self)

	-- -- release keyboard events
	_:off('key_space_on')
	_:off('key_space_off')
	_:off('key_w_on')
	_:off('key_a_on')
	_:off('key_s_on')
	_:off('key_d_on')
	_:off('key_l_on')
	_:off('key_a_down')
	_:off('key_d_down')
	_:off('key_k_down')
	_:off('key_w_off')
	_:off('key_a_off')
	_:off('key_d_off')
	_:off('key_s_off')
	_:off('key_l_off')
	_:off('key_k_off')
end

function Player:shoot(dt, et)
	self.weapon:fire()
	self.shooting = true
end

function Player:setLock()
	if self.locking then
		-- print('unlock!')
		self.locking  = false
		self.lockedIn = false
	else
		-- print('lock!')
		self.locking = true
		--
		if self.crouching then
			self.lockedIn = 'crouch'
		else
			self.lockedIn = 'idle'
		end
	end
end

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

	if self.heading.x == 'W'  then
		ix = self:mass() * (-speed - vx)
	elseif self.heading.x == 'E' then
		ix = self:mass() * ( speed - vx)
	end

	self:applyForce(ix, iy)
end

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
			if select(2, col:getNormal()) > 0 then
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
		print('Set: ' .. name)
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

----
--[[
-- Can do action?
-- ---------------------
-- isGrounded isJumping
-- isMoving   isCrouching
-- isLocked   isShooting
-- ---------------------
--
function Player:can(action)
	-- can crouch? ------------------------------------------------
	if     action == 'crouch' then  return not self.isCrouching and
		                                       self.isGrounded  and
		                                   not self.isLocked
    -- can jump? --------------------------------------------------
	elseif action == 'jump'   then  return not self.isJumping   and
		                                       self.isGrounded
	-- can idle? --------------------------------------------------
	elseif action == 'idle'   then  return not self.isMoving    and
                                           not self.isJumping   and
                                           not self.isCrouching and
                                           not self.isLocked    and
                                           not self.isShooting
    -- can holster ------------------------------------------------
    elseif action == 'holster' then return     self.isShooting
    -- can lock? --------------------------------------------------
	elseif action == 'lock'   then  return     self.isGrounded
    -- can move? --------------------------------------------------
	elseif action == 'move'   then  return not self.isCrouching and
                                           not self.isLocked
    -- can shoot? -------------------------------------------------
    elseif action == 'shoot'  then  return     true
    -- can stand? -------------------------------------------------
	elseif action == 'stand'  then  return     self.isCrouching and
                                               self.isGrounded  and
                                           not self.isLocked
	-- can stop? --------------------------------------------------
	elseif action == 'stop'   then  return     self.isMoving    and
		                                   not self.isLocked
	-- can unlock? ------------------------------------------------
	elseif action == 'unlock' then  return     self.isLocked    and
		                                   not self.isJumping
	-- can unjump? ------------------------------------------------
	elseif action == 'unjump' then  return     self.isJumping
	end

	return false
end

-- Set new action:
-- ---------------------
-- isGrounded isJumping
-- isMoving   isCrouching
-- isLocked   isShooting
-- ---------------------
--
function Player:setAction(action)
	-- crouching -------------------------------------------
	if     action == 'crouch'     then  self.isCrouching = true
		                                self.isGrounded  = true
		                                self.isMoving    = false
		                                self:setAnimation('crouch')
                                        print('crouch')
	-- grounded --------------------------------------------
	elseif action == 'grounded'   then  self.isGrounded = true
		                                self.isJumping  = false
                                        self:setAnimation('stop')
                                        print('grounded')
	-- jumping  --------------------------------------------
	elseif action == 'jump'       then  self.isJumping   = true
		                                self.isGrounded  = false
                                        self.isCrouching = false
                                        self.isLocked    = false
                                        self:setAnimation('inAir')
                                        print('jump')
    -- idle  --------------------------------------------
	elseif action == 'idle'       then  self.isMoving    = false
                                        self.isCrouching = false
                                        self.isJumping   = false
                                        self.isAiming    = false
                                        self:setAnimation('idle')
                                        print('idle')
    -- holster ---------------------------------------------
	elseif action == 'holster'    then  self.isShooting = false
		                                self:setAnimation('holster')
		                                print('holster')
    -- lock ------------------------------------------------
    elseif action == 'lock'       then  self.isLocked    = true
    	                                self:setAnimation('lock')
    	                                -- print('lock')
	-- moving ----------------------------------------------
	elseif action == 'move'       then  self.isMoving    = true
                                        self.isCrouching = false
                                        self:setAnimation('move')
                                        -- print('move')
    -- shooting --------------------------------------------
	elseif action == 'shoot'      then  self.isShooting = true
		                                self:setAnimation('shoot')
		                                -- print('shoot')
    -- standing --------------------------------------------
	elseif action == 'stand'      then  self.isCrouching = false
		                                self:setAnimation('stand')
		                                print('stand')
	-- stopping --------------------------------------------
	elseif action == 'stop'       then  self.isMoving = false
		                                self:setAnimation('stop')
		                                print('stop')
	-- ungrounded -------------------------------------------
	elseif action == 'ungrounded' then  self.isGrounded = false
		                                self:setAnimation('inAir')
		                                print('ungrounded')
	-- unlock -----------------------------------------------
	elseif action == 'unlock'     then  self.isLocked = false
		                                self:setAnimation('unlock')
		                                print('unlock')
	end
end

function Player:setAnimation(action)
	if action == 'shoot' then
		if self.isJumping then
			if self.heading.y == 'N' then
				self.sprite:switchTo('jumpAimUp')
			elseif self.heading.y == 'S' then
				self.sprite:switchTo('jumpAimDown')
			else
				self.sprite:switchTo('jumpAim')
			end
		elseif self.isMoving then
			self.sprite:switchTo('runAim')
		end
	elseif action == 'holster' then
		if self.isJumping then
			self.sprite:switchTo('fall')
		elseif self.isMoving then
			self.sprite:switchTo('run')
		end
	elseif action == 'crouch' and self.isGrounded then
		self.sprite:switchTo('crouch')
	elseif action == 'inAir' then
		if select(2, self:getLinearVelocity()) < 0 then
			self.sprite:switchTo('jump')
		else
			self.sprite:switchTo('fall')
		end
	elseif action == 'idle' then
		self.sprite:switchTo('idle')
	elseif action == 'lock' then
		if self.isCrouching then
			if self.heading.y == 'N' then
				self.sprite:switchTo('crouchAimUp')
			elseif self.heading.y == 'S' then
				self.sprite:switchTo('crouchAimDown')
			else
				self.sprite:switchTo('crouchAim')
			end
		else
			if self.heading.y == 'N' then
				self.sprite:switchTo('aimUp')
			elseif self.heading.y == 'S' then
				self.sprite:switchTo('aimDown')
			else
				self.sprite:switchTo('aim')
			end
		end
	elseif action == 'move' and self.isGrounded then
		if _.__abs(select(1, self:getLinearVelocity())) > 150 then
			self.sprite:switchTo('run')
		else
			self.sprite:switchTo('walk')
		end
	elseif action == 'stand' then
		self.sprite:switchTo('stand')
	elseif action == 'stop' then
		if _.__abs(select(1, self:getLinearVelocity())) > 150 then
			self.sprite:switchTo('stop')
		else
			self.sprite:switchTo('idle')
		end
	elseif action == 'unlock' then
		if self.isCrouching then
			self.sprite:switchTo('crouched')
		else
			self.sprite:switchTo('idle')
		end
	end
end
--]]
return Player