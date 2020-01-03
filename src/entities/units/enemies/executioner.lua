-- Executioner Enemy Unit
-- 

local Enemy       = require 'src.entities.units.enemies.enemy'
local Executioner = Enemy:extend()

function Executioner:new(data)
	Enemy.new(self, data)
    --
	-- properties
	self.health     = 300
	self.speed      = 500
	self.jumpHeight = 3000

	-- flags
	self.attacking  = false
	self.jumping    = false
	self.running    = false

    -- behavior/animation
    self:setBehavior('fall')
end

function Executioner:update(dt)
	local cx, cy = self:getPosition()
    local vx, vy = self:getLinearVelocity()

    -- _Camera:lookAt(cx, cy)

	-- Mini State Machine ------------
    if self.onGround then
    -- on Ground
    	if self.health <= 0 then
    	-- Dying
    		self:setBehavior('die')
        elseif self.attacking then
        -- Attacking
            self:setBehavior('attack')
    	elseif self.jumping then
    	-- Jumping
    		self:setBehavior('jump')
    	elseif self.target then
    	-- Chasing
    		self:setBehavior('chase')
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
	Enemy.update(self, dt)
end

return Executioner