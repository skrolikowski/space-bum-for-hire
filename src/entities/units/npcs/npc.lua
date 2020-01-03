-- NPC Unit
-- 

local Unit = require 'src.entities.units.unit'
local NPC  = Unit:extend()

function NPC:new(data)
	Unit.new(self, _:merge(data, {
		name = data.name or 'NPC'
	}))
	--
	-- properties
	self.health = 100
	self.speed  = 350

	-- flags
	self.fleeing = false
	self.talking = false
	self.walking = false

	-- AI
	self.sight  = Sensors['sight'](self, { 'Unit' }, 100)
	self.timer  = Timer.new()
	self.target = nil

	-- behavior/animation
	self:setBehavior('fall')
end

-- Clear timer
--
function NPC:destroy()
	self.timer:clear()
	--
	Unit.destroy(self)
end

-- In Focus Event
-- Handle when entity comes into focus
--
function NPC:inFocus(other)
	-- print('inFocus', other.name)
end

-- Out of Focus Event
-- Handle when entity goes out of focus
--
function NPC:outOfFocus(other)
	-- print('outOfFocus', other.name)
end

-- Handle entity entering sight range
--
function NPC:inRange(other, col)
	-- print('inRange', other.name)
end

-- Handle entity exiting sight range
--
function NPC:outOfRange(other, col)
	-- print('outOfRange', other.name)
end

-- Update
--
function NPC:update(dt)
	self.timer:update(dt)
	self.sight:update(dt)
	--
	local vx, vy = self:getLinearVelocity()

	-- Mini State Machine ------------
    if self.onGround then
    -- on Ground
    	if self.health <= 0 then
    	-- Dying
    		self:setBehavior('die')
    	elseif self.talking then
        -- Talking
            self:setBehavior('talk')
        elseif self.fleeing then
    	-- Chasing
    		self:setBehavior('flee')
    	elseif self.walking then
    	-- Walking
    		self:setBehavior('walk')
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

return NPC