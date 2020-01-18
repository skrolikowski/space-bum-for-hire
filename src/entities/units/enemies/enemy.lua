-- Enemy Unit
-- 

local Unit  = require 'src.entities.units.unit'
local Enemy = Unit:extend()

function Enemy:new(data)
	Unit.new(self, _:merge(data, {
		name   = data.name   or 'Enemy',
		title  = data.title  or 'Enemy',
		health = data.health or 100,
		speed  = data.speed  or 400,
	}))
	--
	-- sensors/events
	self._timing = data.timing
	self._attack = data.attack
	self._sight  = data.sight

	-- sprite, for behaviors
	self.sprite = Config.image.cast[_.__lower(self.name)]

	-- bootstrap
	self:resetFlags()
	self:setBehavior('fall')
end

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
    	elseif self.attacking then
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

-- Draw some stats
--
function Enemy:draw()
	Unit.draw(self)
	--
	if self.health > 0 then
		local cx, cy    = self:getPosition()
		local w, h      = self:dimensions()
		local barHeight = 4
		local health    = self.health
		local healthMax = self.initHealth
		local value     = _.__max(0, w * (health/healthMax))

		lg.push()
		lg.translate(cx, cy-h/3)
		-- lg.rotate(-_.__pi/2)
		lg.scale(0.35)

		lg.setColor(Config.color.white)
		lg.setFont(Config.ui.font.sm)
		lg.printf(health..'/'..healthMax, 0, 0, w, 'center')

		-- health meter
		lg.setColor(Config.color.health)
		lg.rectangle('line', 0, 0, w, barHeight)
		lg.rectangle('fill', 0, 0, value, barHeight)

		lg.pop()
	end
end

----
----

-- Interrupt current action
--
function Enemy:interrupt()
	self:resetFlags()
	--
	if self.handle then
		self.timer:cancel(self.handle)
	end
	--
	if self.sightSensor then
		self.sightSensor:destroy()
	end

	return self
end

-- Die Action
-- -----------
-- Sensor:  None
-- Audio:   Die
--
function Enemy:die()
	self:interrupt()
	self.hitbox:destroy()
	self.dying = true
	--
	self.timer:after(2, function()
		self:destroy()
	end)
	--
	Config.audio.enemy[_.__lower(self.name)].die:play()
end

return Enemy