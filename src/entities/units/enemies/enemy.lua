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
	self.title  = data.title  or 'Enemy'
	self.health = data.health or 100
	self.speed  = data.speed  or 400
	self.unrest = data.unrest or 3

	-- sensors/events
	self._timing = data.timing
	self._attack = data.attack
	self._sight  = data.sight

	-- AI
	self.timer  = Timer.new()

	-- sprite, for behaviors
	self.sprite = Config.image.cast[_.__lower(self.name)]

	-- bootstrap
	self:resetFlags()
	self:setBehavior('fall')
end

-- -- Destroy
-- --
-- function Enemy:destroy()
-- 	-- delay cleanup
-- 	self.timer:after(3, function()
-- 		self.timer:clear()
-- 		--
-- 		Unit.destroy(self)
-- 	end)
-- end

-- Reset flags
--
function Enemy:resetFlags()
	self.dying     = false
	self.hurting   = false
	self.attacking = false
	self.running   = false
	self.guarding  = false
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
    	elseif self.hurting then
    	-- Hurting
    		self:setBehavior('hurt')
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
   	--
	Unit.update(self, dt)
end

return Enemy