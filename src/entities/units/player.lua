-- Player entity
-- Shane Krolikowski
--

local Unit   = require 'src.entities.units.unit'
local Player = Unit:extend()

function Player:new(data)
	-- properties
	self.axis     = Vec2()  -- controller axis
	self.angle    = 0
	self.cooldown = { now = 0, max = 1 }
	self.speed    = 1000

	-- flags
	self.lockedIn = false

	-- weapon animation
	self.weapon = Weapons[Config.world.player.weapon.name](self)
	--
	Unit.new(self, _:merge(data, {
		name = 'Player'
	}))

	-- behavior/animation
	self:setBehavior('idle')

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
		self.axis.y    = 0
	elseif key == 'a' or key == 'd' then
	-- East/West
		self.running = false
		self.axis.x  = 0
	elseif key == 'w' then
	-- North
		self.axis.y = 0
	elseif key == 'space_off' then
	-- Terminate Jump
		self:terminateJump()
	end
end

-- Destroy!
--
function Player:destroy(dt, et)
	-- release keyboard events
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

	-- clean up
	self.weapon:destroy()
	--
	Unit.destroy(self)
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

	self.jumping = false
	
	if vy < 0 then
		self:setLinearVelocity(vx, 0)
	end
end

-- Update
--
function Player:update(dt)
    local cx, cy = self:getPosition()
    local vx, vy = self:getLinearVelocity()

    _Camera:lookAt(cx, cy)

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

	self.weapon:update(dt)
	--
	Unit.update(self, dt)
end

-- Draw weapon
--
function Player:draw()
    Unit.draw(self)
    --
	if self.visible then
		self.weapon:draw()
    end
end

return Player