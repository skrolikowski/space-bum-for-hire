-- Player entity
-- Shane Krolikowski
--

local Entity = require 'src.entities.entity'
local Player = Entity:extend()

function Player:new(data)
	data.width    = 64
	data.height   = 64
	data.x        = data.x + data.width / 2
	data.y        = data.y + data.height / 2
	data.bodyType = 'dynamic'
	
	-- scaling
	self.sx = 1   -- x-sprite scaling
	self.sy = 1   -- y-sprite scaling
	data.bx = 0.5 * self.sx -- x-bound scaling
	data.by = 1   * self.sy   -- y-bound scaling

	-- shape
	data.shape     = 'rectangle'
	data.shapeData = {
		data.width  * data.bx,  -- shape width (scaled)
		data.height * data.by   -- shape height (scaled)
	}

	Entity.new(self, data)
	
	-- attributes
	self.speed       = 40 * Config.world.meter
	self.speedMax    = 1.5 * self.speed
	self.jumpHeight  = 4 * data.height * Config.world.meter
	self.initJumpVel = _.__sqrt(2 * Config.world.gravity.y * self.jumpHeight)
	self.initImpulse = self:mass() * self.initJumpVel

	-- physics
	self:fixedRotation(true)  -- lockrotation
	self.contactNormal = Vec2()
	-- filters
	-- data.categories = {}  -- belongs to...
	-- data.mask       = {}  -- ingores these...

	-- flags
	self.onPlatform = false
	self.onWall     = false
	self.isMoving   = false
	self.isMirrored = false

	-- keyboard events
	_:on('key_space_on',  function() self:jump() end)
	_:on('key_space_off', function() self:terminateJump() end)
	_:on('key_a_down',    function(dt, et) self:move(dt, et, 'left')  end)
	_:on('key_d_down',    function(dt, et) self:move(dt, et, 'right') end)
	_:on('key_a_off',     function() self:terminateMove() end)
	_:on('key_d_off',     function() self:terminateMove() end)

	-- sprite
	self.sprite = Animator()
	self.sprite:addAnimation('idle', {
		image  = Config.image.spritesheet.cyberpunk.idle,
		width  = 64,
		height = 64,
		frames = { { 1, 1, 1, 6 } }
	})

	-- camera control
	_Camera.x, _Camera.y = self:getPosition()
	--_Camera:setFollowStyle('SCREEN_BY_SCREEN')
	_Camera:follow(self:getPosition())
end

function Player:destroy(dt, et)
	Entity.destroy(self)

	-- release keyboard events
	_:off('key_space_on')
	_:off('key_space_off')
	_:off('key_a_down')
	_:off('key_d_down')
end

-- Move in direction
--
function Player:move(dt, et, dir)
	local vx, vy = self:getLinearVelocity()
	local dx, dy = 0, 0
	local ix, iy = 0, 0
	local speed  = self.speed

	if not self.onPlatform then
		speed = speed * 0.75
	end

	if dir == 'left' then
		dx = speed * -1
		self.isMirrored = true
	elseif dir == 'right' then
		dx = speed *  1
		self.isMirrored = false
	end

	ix = self:mass() * (dx - vx)
	self.isMoving = true

	self:applyForce(ix, iy)
end

-- Reduce speed
--
function Player:terminateMove()
	vx, vy = self:getLinearVelocity()
	self.isMoving = false

	if self.onPlatform then
		-- on ground
		vx = vx * 0.25
	else
		-- in air
		vx = vx * 0.5
	end

	self:setLinearVelocity(vx, vy)
end

function Player:jump()
	if self.onPlatform then
		self:applyLinearImpulse(0, -self.initImpulse)
	end
end

function Player:terminateJump()
	if not self.onPlatform then
		vx, vy = self:getLinearVelocity()

		if vy < 0 then
			self:setLinearVelocity(vx, 0)
		end
	end
end

-- Event - beginContact
--
function Player:beginContact(other, col)
	if col:isEnabled() and col:isTouching() then
		if other.name == 'Platform' then
			self.onPlatform    = true
			self.contactNormal = Vec2(col:getNormal())
		end
	end
end

-- Event - endContact
--
function Player:endContact(other, col)
	if col:isEnabled() and not col:isTouching() then
		if other.name == 'Platform' then
			self.onPlatform = false
			print('off')
		end
	end
end

function Player:update(dt)
	_Camera:update(dt)
    _Camera:follow(self:getPosition())

	self.sprite:update(dt)

	Entity.update(self, dt)
end

function Player:draw()
	if self.visible then
    	local cx, cy = self:getPosition()
    	local w, h   = self.sprite:dimensions()
    	local sx, sy = self.sx, self.sy

        if self.isMirrored then
            sx = -sx
        end

        love.graphics.setColor(Config.color.white)

        self.sprite:draw(cx, cy, 0, sx, sy, w/2, h/2)
    end

    Entity.draw(self)
end

return Player