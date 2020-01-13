-- Enemy Unit
-- 

local Unit  = require 'src.entities.units.unit'
local Enemy = Unit:extend()

function Enemy:new(data)
	Unit.new(self, _:merge(data, {
		name = data.name or 'Enemy'
	}))
	--
	-- properties
	self.title  = data.title 
	self.health = 100
	self.speed  = 400

	-- AI
	self.timer  = Timer.new()

	-- sprite, for behaviors
	self.sprite = Config.image.cast[_.__lower(self.name)]

	-- behaviors
	self.dying     = false
	self.attacking = false
	self.running   = false
	self.guarding  = false

	-- behavior/animation
	self:setBehavior('idle')
end

-- Destroy
--
function Enemy:destroy()
	-- delay cleanup
	self.timer:after(3, function()
		self.timer:clear()
		--
		Unit.destroy(self)
	end)
end

-- Update
--
function Enemy:update(dt)
	self.timer:update(dt)
	--
	local vx, vy = self:getLinearVelocity()

	-- Mini State Machine ------------
	if self.dying then
	-- Dying
		self:setBehavior('die')
    elseif self.onGround then
    -- on Ground
    	if self.attacking then
        -- Attacking
            self:setBehavior('attack')
    	elseif self.running then
    	-- Walking/Running
    		self:setBehavior('run')
    	elseif self.guarding then
    	-- Guarding
    		self:setBehavior('guard')
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
   	--
	Unit.update(self, dt)
end

----

function Enemy:default()
	self:patrol()
end

-- Patrol
--
function Enemy:patrol(direction)
	self.walking    = true
	self.isMirrored = direction == 'left' or false
	--
	self.pacing = self.timer:every(3, function()
		self.isMirrored = not self.isMirrored
	end)
	
	-- sight detection
	-- interact with entities
	--
	self.sight = Sensors['sight'](self, { 'Player' })
	self.sight:setShape(Shapes['circle'](100))
	self.sight:setInFocus(function(other)
		self.walking = false
		self.sight:destroy()
		self.timer:cancel(self.pacing)
		--
		if other.name == 'Player' then
		-- Hunt Player
			self:hunt(other, 5, function()
				self:patrol()
			end)
		end
	end)
end

-- Hunt
--
function Enemy:hunt(other, delay)
	local hx, hy = self:getPosition()
	local tx, ty = other:getPosition()

	self.target     = other
	self.running    = true
	self.isMirrored = tx < hx

	-- attack if player in range
	self.sight = Sensors['sight'](self, { 'Player' })
	self.sight:setShape(Shapes['circle'](50))
	self.sight:setInFocus(function(other)
		self.target  = nil
		self.running = false
		self.sight:destroy()
		--
		if other.name == 'Player' then
		-- Hunt Player
			self:attack(1, function()
				self:patrol()
			end)
		end
	end)

	-- give up after `delay`
	self.timer:after(delay, function()
		self.target  = nil
		self.running = false
	end)
end

-- Attack
--
function Enemy:attack(delay, after)
	self.attacking = true

	self.timer:after(delay, function()
		self.attacking = false

		-- callback
		if after then
			after()
		end
	end)
end

return Enemy