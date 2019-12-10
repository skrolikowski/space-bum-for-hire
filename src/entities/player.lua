-- Player entity
-- Shane Krolikowski
--

local Entity = require 'src.entities.entity'
local Player = Entity:extend()

function Player:new(data)
	self.width   = 64
	self.height  = 64
	self.heading = { false, 'E' }
	-- scaling
	self.sx = 1.25            -- x-sprite scaling
	self.sy = 1.25            -- y-sprite scaling
	self.bx = 0.5 * self.sx   -- x-bound scaling
	self.by = 1   * self.sy   -- y-bound scaling

	-- properties
	data.x        = data.x + self.width / 2
	data.y        = data.y + self.height / 2
	data.density  = 80
	data.bodyType = 'dynamic'

	-- shape
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

	self.fsm = FSM(self, 'idle')

	-- sprite
	self.sprite = Animator()
	self.sprite:addAnimation('idle', {
		image  = Config.image.spritesheet.cyberpunk.idle,
		width  = 64,
		height = 64,
		frames = { { 1, 1, 1, 6 } }
	})
	self.sprite:addAnimation('death', {
		image  = Config.image.spritesheet.cyberpunk.death,
		width  = 64,
		height = 64,
		frames = { { 1, 1, 1, 7 } }
	})
	self.sprite:addAnimation('crouch', {
		image  = Config.image.spritesheet.cyberpunk.crouch,
		width  = 64,
		height = 64,
		total  = 1,
		frames = { { 1, 1, 1, 3 } },
	})
	self.sprite:addAnimation('crouched', {
		image  = Config.image.spritesheet.cyberpunk.crouch,
		width  = 64,
		height = 64,
		frames = { { 1, 3, 1, 3 } },
	})
	self.sprite:addAnimation('crouchAim', {
		image  = Config.image.spritesheet.cyberpunk.crouchAim,
		width  = 64,
		height = 64,
		frames = { { 1, 3, 1, 3 } }
	})
	self.sprite:addAnimation('crouchAimUp', {
		image  = Config.image.spritesheet.cyberpunk.crouchAim,
		width  = 64,
		height = 64,
		total  = 1,
		frames = { { 1, 4, 1, 5 } }
	})
	self.sprite:addAnimation('crouchAimDown', {
		image  = Config.image.spritesheet.cyberpunk.crouchAim,
		width  = 64,
		height = 64,
		total  = 1,
		frames = { { 1, 1, 1, 2 } }
	})
	self.sprite:addAnimation('stand', {
		image  = Config.image.spritesheet.cyberpunk.crouch,
		width  = 64,
		height = 64,
		total  = 1,
		frames = { { 1, 4, 1, 6 } },
		after  = function() self.sprite:switchTo('idle') end
	})
	self.sprite:addAnimation('aim', {
		image  = Config.image.spritesheet.cyberpunk.aim,
		width  = 64,
		height = 64,
		frames = { { 1, 5, 1, 5 } }
	})
	self.sprite:addAnimation('aimUp', {
		image  = Config.image.spritesheet.cyberpunk.aim,
		width  = 64,
		height = 64,
		total  = 1,
		frames = { { 1, 6, 1, 7 } }
	})
	self.sprite:addAnimation('aimDown', {
		image  = Config.image.spritesheet.cyberpunk.aim,
		width  = 64,
		height = 64,
		frames = { { 1, 3, 1, 3 } }
	})
	self.sprite:addAnimation('run', {
		image  = Config.image.spritesheet.cyberpunk.run,
		width  = 64,
		height = 64,
		frames = { { 1, 1, 1, 8 } }
	})
	self.sprite:addAnimation('runAim', {
		image  = Config.image.spritesheet.cyberpunk.runAim,
		width  = 64,
		height = 64,
		frames = { { 1, 1, 1, 5 } }
	})
	self.sprite:addAnimation('walk', {
		image  = Config.image.spritesheet.cyberpunk.walk,
		width  = 64,
		height = 64,
		frames = { { 1, 1, 1, 10 } }
	})
	self.sprite:addAnimation('stop', {
		image  = Config.image.spritesheet.cyberpunk.stop,
		width  = 64,
		height = 64,
		frames = { { 1, 1, 1, 6 } },
		after  = function() self.sprite:switchTo('idle') end
	})
	self.sprite:addAnimation('jump', {
		image  = Config.image.spritesheet.cyberpunk.jump,
		width  = 64,
		height = 64,
		total  = 1,
		frames = { { 1, 3, 1, 8 } }
	})
	self.sprite:addAnimation('jumpAim', {
		image  = Config.image.spritesheet.cyberpunk.jumpAim,
		width  = 64,
		height = 64,
		frames = { { 1, 3, 1, 3 } }
	})
	self.sprite:addAnimation('jumpAimUp', {
		image  = Config.image.spritesheet.cyberpunk.jumpAim,
		width  = 64,
		height = 64,
		total  = 1,
		frames = { { 1, 4, 1, 5 } }
	})
	self.sprite:addAnimation('jumpAimDown', {
		image  = Config.image.spritesheet.cyberpunk.jumpAim,
		width  = 64,
		height = 64,
		total  = 1,
		frames = { { 1, 1, 1, 2 } }
	})
	self.sprite:addAnimation('fall', {
		image  = Config.image.spritesheet.cyberpunk.jumpAim,
		width  = 64,
		height = 64,
		frames = { { 1, 8, 1, 8 } }
	})

	-- keyboard events
	_:on('key_space_on',  function() self:jumpStart() end)
	_:on('key_space_off', function() self:jumpStop()  end)
	_:on('key_w_on',      function() self:adjustHeading(2, 'N') end)
	_:on('key_a_on',      function() self:adjustHeading(1, 'W') end)
	_:on('key_s_on',      function() self:adjustHeading(2, 'S') end)
	_:on('key_d_on',      function() self:adjustHeading(1, 'E') end)
	_:on('key_l_down',    function(dt, et) self:lock()          end)
	_:on('key_k_down',    function(dt, et) self:shoot(dt, et)   end)
	_:on('key_a_down',    function(dt, et) self:moveStart(dt, et, 'left')  end)
	_:on('key_d_down',    function(dt, et) self:moveStart(dt, et, 'right') end)
	_:on('key_s_down',    function(dt, et) self:crouchStart(dt, et) end)
	_:on('key_w_off',     function() self:adjustHeading(2, false)   end)
	_:on('key_a_off',     function() self:adjustHeading(1, false) self:moveStop()   end)
	_:on('key_d_off',     function() self:adjustHeading(1, false) self:moveStop()   end)
	_:on('key_s_off',     function() self:adjustHeading(2, false) self:crouchStop() end)
	_:on('key_l_off',     function() self:unlock()  end)
	_:on('key_k_off',     function() self:holster() end)

	-- camera control
	_Camera.x, _Camera.y = self:getPosition()
end

-- Destroy!
--
function Player:destroy(dt, et)
	Entity.destroy(self)

	-- release keyboard events
	_:off('key_space_on')
	_:off('key_space_off')
	_:off('key_w_on')
	_:off('key_a_on')
	_:off('key_s_on')
	_:off('key_d_on')
	_:off('key_l_on')
	_:off('key_k_down')
	_:off('key_a_down')
	_:off('key_d_down')
	_:off('key_s_down')
	_:off('key_w_off')
	_:off('key_a_off')
	_:off('key_d_off')
	_:off('key_s_off')
	_:off('key_l_off')
	_:off('key_k_off')
end

-- Adjust aiming angle
function Player:adjustHeading(axis, value)
	if axis == 2 then
		self.heading.y = value
	else
		self.heading.x = value
	end
end

-- Set player to idle
--
function Player:idle()
	if self:can('idle') then
		self:setAction('idle')
	end
end

-- Lock on target
--
function Player:lock()
	if self:can('lock') then
		self:setAction('lock')
	end
end

-- Unlock from aiming
--
function Player:unlock()
	if self:can('unlock') then
		self:setAction('unlock')
	end
end

function Player:shoot(dt, et)
	if self:can('shoot') then
		self:setAction('shoot')
		--
		if et % 1 == 0 then
			print('shoot')
			-- self.pistol:shoot()
		end
	end
end

function Player:holster()
	if self:can('holster') then
		self:setAction('holster')
	end
end

-- Move in direction
--
function Player:moveStart(dt, et, dir)
	if self:can('move') then
		self:setAction('move')
		--
		local vx, vy = self:getLinearVelocity()
		local ix, iy = 0, 0
		local speed  = self.speed

		-- apply movement force
		if not self.onGround then
			speed = speed * 0.75
		end

		if     dir == 'left'  then ix = self:mass() * (-speed - vx)
		elseif dir == 'right' then ix = self:mass() * ( speed - vx)
		end

		self:applyForce(ix, iy)
	end

	-- change sprite direction accordingly
	if dir == 'left' then
		self.isMirrored = true
	else
		self.isMirrored = false
	end
end

-- Reduce speed
--
function Player:moveStop()
	if self:can('stop') then
		self:setAction('stop')
		--
		local vx, vy = self:getLinearVelocity()

		if self.onPlatform then
			-- on ground
			vx = vx * self.friction
		else
			-- in air
			vx = vx * self.friction / 2
		end

		self:setLinearVelocity(vx, vy)
	end
end

-- Crouch down
--
function Player:crouchStart()
	if self:can('crouch') then
		self:setAction('crouch')
		--
		--TODO: handle shape resize
	end
end

-- Stand from crouch
--
function Player:crouchStop()
	if self:can('stand') then
		self:setAction('stand')
		--
		--TODO: handle shape resize
	end
end

-- Start jump action
--
function Player:jumpStart()
	if self:can('jump') then
		-- apply impulse for jump
		self:applyLinearImpulse(0, -self.initImpulse)
		--
		self:setAction('jump')
	end
end

-- Terminate jump action
--
function Player:jumpStop()
	if self:can('unjump') then
		-- terminate jump height
		local vx, vy = self:getLinearVelocity()

		if vy < 0 then
			self:setLinearVelocity(vx, 0)
		end
		--
		self:setAnimation('inAir')
	end
end

-- Event - beginContact
--
function Player:beginContact(other, col)
	if col:isTouching() then
		if other.name == 'Platform' then
			if select(2, col:getNormal()) > 0 then
				self:setAction('grounded')
			end
		end
	end
end

-- Event - endContact
--
function Player:endContact(other, col)
	if other.name == 'Platform' then
		--
	end
end

-- Update
--
function Player:update(dt)
	_Camera:update(dt)
    _Camera:follow(self:getPosition())

    self.fsm:update(dt)
	self.sprite:update(dt)

	Entity.update(self, dt)
end

-- Draw
--
function Player:draw()
	if self.visible then
    	local cx, cy = self:getPosition()
    	local w, h   = self.sprite:dimensions()
    	local sx, sy = self.sx, self.sy

        if self.isMirrored then sx = -sx end
        if self.isFlipped  then sy = -sy end

        love.graphics.setColor(Config.color.white)

        self.sprite:draw(cx, cy, 0, sx, sy, w/2, h/2)
    end

    Entity.draw(self)
end

----

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

return Player