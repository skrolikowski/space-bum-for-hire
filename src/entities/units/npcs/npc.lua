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
	self.title  = data.title 
	self.health = 100

	-- flags
	self.canDestroy = false

	-- AI
	self.timer = Timer.new()

	-- behaviors
	self.dying    = false
	self.punching = false
	self.fleeing  = false
	self.talking  = false
	self.guarding = false
	self.walking  = false

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
    	if self.dying then
    	-- Dying
    		self:setBehavior('die')
    	elseif self.attacking then
        -- Attacking
            self:setBehavior('attack')
    	elseif self.talking then
        -- Talking
            self:setBehavior('talk')
        elseif self.fleeing then
    	-- Chasing
    		self:setBehavior('flee')
    	elseif self.walking then
    	-- Walking
    		self:setBehavior('walk')
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

   	if self.dialogue then
   		self.dialogue:update(dt)
   	end
   	--
	Unit.update(self, dt)
end

function NPC:draw()
	Unit.draw(self)
	--
	if self.visible and self.dialogue then
		self.dialogue:draw()
	end
end

return NPC