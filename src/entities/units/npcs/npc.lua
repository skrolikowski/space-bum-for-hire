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
	self.timer = Timer.new()

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

-- Update
--
function NPC:update(dt)
	self.timer:update(dt)
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