-- Player entity
-- Shane Krolikowski
--

local Unit   = require 'src.entities.units.unit'
local Player = Unit:extend()

function Player:new(data)
	Unit.new(self, _:merge(data, {
		title      = 'Punk',
		name       = 'Player',
		shape      = 'rectangle',
		speed      = 1000,
		jumpHeight = 4500,
		visible    = true,
		
	}))
	--
	-- properties
	self.axis       = Vec2()  -- controller axis
	self.angle      = 0
	self.cooldown   = { now = 0, max = 1 }
	self.health     = Config.world.hud.stat.health.now
	self.initHealth = Config.world.hud.stat.health.max

	-- flags
	self.lockedIn = false

	-- sprite, for behaviors
	self.sprite = Config.image.cast['player']

	-- bootstrap
	self:setBehavior('idle')
	self:setWeapon(Config.world.hud.weapon)
end

-- Convienence keyOn method
--
function Player:keyOn(key)
	if key == 'w' then
		self.axis.y = -1
		_:dispatch('player_request')
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

-- Clean up
--
function Player:destroy(dt, et)
	self.weapon:destroy()
	--
	Unit.destroy(self)
end

-- Toggle lock position
--
function Player:setLock(value)
	self.locking = value

	if not self.locking then
		self.lockedIn = false
	else
		if self.crouching then
			self.lockedIn = 'crouch'
		else
			self.lockedIn = 'idle'
		end
	end
end

-- Update HUD
--
function Player:damage(other, damage)
	Unit.damage(self, other, damage)
	--
	-- update stats
	Gamestate:current().hud:set({
		name     = 'health',
		category = 'stat',
		value    = _.__max(0, self.health)
	})
end

-- Player has died :(
function Player:die()
	Gamestate:current():playerDeath()
	self.dying = true
	--
	self.timer:after(2, function()
		self:destroy()
	end)
	--
	-- Config.audio.player.die:play()
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

-- Aiming angle for weapon sprite completion
--
function Player:getAimAngle()
	-- if self.shooting then
	-- only update if necessary
	-- costly math below
		local ax, ay = self.axis:unpack()
		local angle

		-- can only aim downward if locked in position
		--
		if not self.locking then
			ay = _.__min(0, ay)
		end

		angle = Vec2(ax, ay):normalize():heading()

		-- adjust aiming angle
		--
		if angle == 0 and self.isMirrored then
			angle = _.__pi
		end

		return angle
	-- end
end

-- Switch weapon
--
function Player:setWeapon(name)
	if self.weapon then
		if self.weapon.name ~= name then
		-- Reassignment
			self.weapon:destroy()
			self.weapon = Weapons[name](self)

			Gamestate:current().hud:set({
				name  = 'weapon',
				value = name
			})
		end
	else
	-- Init
		self.weapon = Weapons[name](self)
	end
end

-- Update
--
function Player:update(dt)
    local vx, vy = self:getLinearVelocity()

    -- Mini State Machine ------------
    if self.dying then
	-- Dying
		self:setBehavior('die')
    elseif self.onGround then
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

	-- update aiming & weapon
	self.aimAngle = self:getAimAngle()
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