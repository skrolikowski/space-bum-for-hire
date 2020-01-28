-- NPC Unit
-- 

local Unit = require 'src.entities.units.unit'
local NPC  = Unit:extend()

function NPC:new(data)
	Unit.new(self, _:merge(data, {
		title      = data.title or 'NPC',
		name       = data.name  or 'NPC',
		speed      = 350,
		health     = 100,
		canDestroy = false
	}))
	--
	-- sprite, for behaviors
	self.sprite = Config.image.cast[_.__lower(self.name)]
	self.sprite = self.sprite[_.__random(#self.sprite)]

	-- bootstrap
	self:resetFlags()
	self:setBehavior('fall')
end

-- Reset flags
--
function NPC:resetFlags()
	self.dying     = false
	self.attacking = false
	self.running   = false
	self.talking   = false
	self.guarding  = false
	self.walking   = false
end

-- Update
--
function NPC:update(dt)
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
    	elseif self.talking then
        -- Talking
            self:setBehavior('talk')
        elseif self.running then
    	-- Chasing
    		self:setBehavior('run')
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

   	-- update dialogue
   	if self.dialogue then
   		self.dialogue:update(dt)
   	end
   	--
	Unit.update(self, dt)
end

function NPC:draw()
	Unit.draw(self)
	--
	-- draw dialogue
	if self.dialogue then
		self.dialogue:draw()
	end
end


----
----

-- Interrupt current action
--
function NPC:interrupt()
	self:resetFlags()
	self.target   = nil
	self.dialogue = nil
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
function NPC:die()
	self:interrupt()
	self.dying = true
	--
	self.timer:after(2, function()
		self:destroy()
	end)
end

-- Pace
--
function NPC:pace()
	self.walking = true
	self.isMirrored = not self.isMirrored
	--
	-- Detect Entity
	-- InFocus (Player): Interrupt to talk to target
	-- InFocus (Enemy): Interrupt to flee from target
	self.sightSensor = Sensors['sight'](self, { 'Unit' }, _.__pi/2)
	self.sightSensor:setShape(Shapes['circle'](75))
	self.sightSensor:setInFocus(function(other)
		if other.name == 'Player' then
			--
			self.timer:script(function(wait)
				self:interrupt():comment(other)
				wait(5)
				self:interrupt():pace()
			end)
			--
		elseif other.category == 'Enemy' then
			
			self.timer:script(function(wait)
				self:interrupt():flee(other)
				wait(3)
				self:interrupt():pace()
			end)
			
		end
	end)

	-- unrest
	self.handle = self.timer:after(3, function()
		self:interrupt():pace()
	end)
end

-- Move in `direction` for `delay` seconds
--
function NPC:move(direction, speed, delay)
	self.walking    = true
	self.speed      = speed
	self.isMirrored = direction == 'left'
	
	self.handle = self.timer:after(delay, function()
		self.walking = false
	end)
end

-- Fiddle
--
function NPC:fiddle(direction, delay)
	self.attacking  = true
	self.dialogue   = Dialogue['emote'](self, 'thought', { 'emote_dots1', 'emote_dots2', 'emote_dots3' })
	self.isMirrored = direction == 'left'
	
	self.handle = self.timer:after(delay, function()
		self.attacking = false
		self.dialogue  = nil
	end)
end

-- Flee from `other`
--
function NPC:flee(other)
	local hx, hy = self:getPosition()
	local tx, ty = other:getPosition()

	self.target     = other
	self.running    = true
	self.dialogue   = Dialogue['emote'](self, 'free', 'emote_alert')
	self.isMirrored = tx > hx
end

-- Blame
--
function NPC:blame(direction, delay, expression)
	self.attacking  = true
	self.dialogue   = Dialogue['emote'](self, expression or 'speech', 'emote_faceAngry')
	self.isMirrored = direction == 'left'
	
	self.handle = self.timer:after(delay, function()
		self.attacking = false
		self.dialogue  = nil
	end)
end

-- Worry
--
function NPC:worry(direction, delay, expression)
	self.guarding   = true
	self.dialogue   = Dialogue['emote'](self, expression or 'free', 'emote_drop')
	self.isMirrored = direction == 'left'
	
	self.handle = self.timer:after(delay, function()
		self.guarding = false
		self.dialogue = nil
	end)
end

-- Shock
--
function NPC:shock(direction, delay, expression)
	self.guarding   = true
	self.dialogue   = Dialogue['emote'](self, expression or 'free', 'emote_exclamation')
	self.isMirrored = direction == 'left'
	
	self.handle = self.timer:after(delay, function()
		self.guarding = false
		self.dialogue = nil
	end)
end

-- Idea
--
function NPC:idea(direction, delay, expression)
	self.talking    = true
	self.dialogue   = Dialogue['emote'](self, expression or 'free', 'emote_idea')
	self.isMirrored = direction == 'left'
	
	self.handle = self.timer:after(delay, function()
		self.talking = false
		self.dialogue = nil
	end)
end

-- Happy
--
function NPC:happy(direction, delay, expression)
	self.dialogue   = Dialogue['emote'](self, expression or 'thought', 'emote_faceHappy')
	self.isMirrored = direction == 'left'
	
	self.handle = self.timer:after(delay, function()
		self.dialogue = nil
	end)
end

-- Ouch
--
function NPC:ouch(direction, delay, expression)
	self.guarding   = true
	self.dialogue   = Dialogue['emote'](self, expression or 'thought', 'emote_anger')
	self.isMirrored = direction == 'left'
	
	self.handle = self.timer:after(delay, function()
		self.guarding = false
		self.dialogue = nil
	end)
end

-- Anger
--
function NPC:anger(direction, delay, expression)
	self.dialogue   = Dialogue['emote'](self, expression or 'speech', 'emote_bars')
	self.isMirrored = direction == 'left'
	
	self.handle = self.timer:after(delay, function()
		self.dialogue = nil
	end)
end

-- Huh!?
--
function NPC:huh(direction, delay, expression)
	self.dialogue   = Dialogue['emote'](self, expression or 'thought', 'emote_question')
	self.isMirrored = direction == 'left'
	
	self.handle = self.timer:after(delay, function()
		self.dialogue = nil
	end)
end

-- Explain
--
function NPC:explain(direction, delay, expression)
	self.talking    = true
	self.dialogue   = Dialogue['emote'](self, expression or 'speech', {'emote_dots1','emote_dots2','emote_dots3'})
	self.isMirrored = direction == 'left'
	
	self.handle = self.timer:after(delay, function()
		self.talking = false
		self.dialogue = nil
	end)
end

-- Greed
--
function NPC:greed(direction, delay, expression)
	self.talking    = true
	self.dialogue   = Dialogue['emote'](self, expression or 'free', 'emote_cash')
	self.isMirrored = direction == 'left'
	
	self.handle = self.timer:after(delay, function()
		self.talking   = false
		self.dialogue = nil
	end)
end

-- Okay
--
function NPC:okay(direction, delay, expression)
	self.talking    = true
	self.dialogue   = Dialogue['emote'](self, expression or 'free', 'emote_star')
	self.isMirrored = direction == 'left'
	
	self.handle = self.timer:after(delay, function()
		self.talking   = false
		self.dialogue = nil
	end)
end

-- Talk
--
function NPC:say(direction, text, delay)
	self.talking    = true
	self.dialogue   = Dialogue['speech'](self, text)
	self.isMirrored = direction == 'left'
	
	self.handle = self.timer:after(delay, function()
		self.talking  = false
		self.dialogue = nil
	end)
end

-- Comment
--
function NPC:comment(other)
	local index  = _.__random(#Dialogue_.comment[self.name])
	local text   = Dialogue_.comment[self.name][index]
	local hx, hy = self:getPosition()
	local tx, ty = other:getPosition()

	self.target     = other
	self.talking    = true
	self.dialogue   = Dialogue['comment'](self, text)
	self.isMirrored = tx < hx
end

----

return NPC