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
	self.speed  = 350

	-- flags
	self.canDestroy = false

	-- sprite, for behaviors
	self.sprite = Config.image.cast[_.__lower(self.name)]
	self.sprite = self.sprite[_.__random(#self.sprite)]

	-- behaviors
	self.dying     = false
	self.attacking = false
	self.running   = false
	self.talking   = false
	self.guarding  = false
	self.walking   = false

	-- behavior/animation
	self:setBehavior('idle')
	-- self:pace()
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
	if self.visible and self.dialogue then
		self.dialogue:draw()
	end
end

----

-- Move in `direction` for `delay` seconds
--
function NPC:move(direction, speed, delay)
	self.walking    = true
	self.speed      = speed
	self.isMirrored = direction == 'left' or self.isMirrored
	
	self.timer:after(delay, function()
		self.walking = false
	end)
end

-- Fiddle
--
function NPC:fiddle(direction, delay)
	self.attacking  = true
	self.dialogue   = Dialogue['emote'](self, 'thought', { 'emote_dots1', 'emote_dots2', 'emote_dots3' })
	self.isMirrored = direction == 'left' or self.isMirrored
	
	self.timer:after(delay, function()
		self.attacking = false
		self.dialogue  = nil
	end)
end

-- Flee from `other`
--
function NPC:flee(other, speed, delay, after)
	local hx, hy = self.getPosition()
	local tx, ty = other:getPosition()
	--

	self.target     = other
	self.running    = true
	self.speed      = speed
	self.dialogue   = Dialogue['emote'](host, 'free', 'alert')
	self.isMirrored = tx > hx
	
	self.timer:after(delay, function()
		self.running  = false
		self.dialogue = nil

		if after then
			after()
		end
	end)
end

-- Blame
--
function NPC:blame(direction, delay)
	self.attacking  = true
	self.dialogue   = Dialogue['emote'](self, 'thought', 'emote_faceAngry')
	self.isMirrored = direction == 'left' or self.isMirrored
	
	self.timer:after(delay, function()
		self.attacking = false
		self.dialogue  = nil
	end)
end

-- Worry
--
function NPC:worry(direction, delay)
	self.dialogue   = Dialogue['emote'](self, 'free', 'emote_drop')
	self.isMirrored = direction == 'left' or self.isMirrored
	
	self.timer:after(delay, function()
		self.dialogue = nil
	end)
end

-- Shock
--
function NPC:shock(direction, delay)
	self.guarding   = true
	self.dialogue   = Dialogue['emote'](self, 'free', 'emote_exclamation')
	self.isMirrored = direction == 'left' or self.isMirrored
	
	self.timer:after(delay, function()
		self.guarding = false
		self.dialogue = nil
	end)
end

-- Talk
--
function NPC:say(direction, text, delay)
	self.talking    = true
	self.dialogue   = Dialogue['speech'](self, text)
	self.isMirrored = direction == 'left' or self.isMirrored
	
	self.timer:after(delay, function()
		self.talking  = false
		self.dialogue = nil
	end)
end

-- Comment
--
function NPC:comment(other, delay, after)
	local index  = _.__random(#Dialogue_.comment[self.name])
	local text   = Dialogue_.comment[self.name][index]
	local hx, hy = self:getPosition()
	local tx, ty = other:getPosition()
	--

	self.target     = other
	self.talking    = true
	self.dialogue   = Dialogue['comment'](self, text)
	self.isMirrored = tx < hx
	
	self.timer:after(delay, function()
		self.target   = nil
		self.talking  = false
		self.dialogue = nil

		-- callback
		if after then
			after()
		end
	end)
end

----

return NPC