-- Doctor Unit Entity
-- Non-agressive, super smart techy dudes.
-- They wander the galaxy looking for "losers" to outsmart.
--

local NPC    = require 'src.entities.units.npcs.npc'
local Doctor = NPC:extend()

function Doctor:new(data)
	NPC.new(self, _:merge(data, {
		name  = 'Doctor',
		title = data.title or 'Doctor',
		shape = 'rectangle',
	}))
	--
end

-- Move in `direction` for `delay` seconds
--
function Doctor:move(direction, speed, delay)
	self.walking    = true
	self.speed      = speed
	self.isMirrored = direction == 'left' or false
	
	self.timer:after(delay, function()
		self.walking = false
	end)
end

-- Anger!
--
function Doctor:blame(direction, delay)
	self.attacking  = true
	self.dialogue   = Dialogue['emote'](self, 'thought', 'emote_faceAngry')
	self.isMirrored = direction == 'left' or false
	
	self.timer:after(delay, function()
		self.attacking = false
		self.dialogue  = nil
	end)
end

-- Talk
--
function Doctor:say(direction, text, delay)
	self.talking    = true
	self.dialogue   = Dialogue['speech'](self, text)
	self.isMirrored = direction == 'left' or false
	
	self.timer:after(delay, function()
		self.talking  = false
		self.dialogue = nil
	end)
end

-- Shock
--
function Doctor:shock(direction, delay)
	self.guarding   = true
	self.dialogue   = Dialogue['emote'](self, 'free', 'emote_exclamation')
	self.isMirrored = direction == 'left' or false
	
	self.timer:after(delay, function()
		self.guarding = false
		self.dialogue = nil
	end)
end

-- Worry
--
function Doctor:worry(direction, delay)
	self.dialogue   = Dialogue['emote'](self, 'free', 'emote_drop')
	self.isMirrored = direction == 'left' or false
	
	self.timer:after(delay, function()
		self.dialogue = nil
	end)
end

-- Fiddle
--
function Doctor:fiddle(direction, delay)
	self.attacking  = true
	self.dialogue   = Dialogue['emote'](self, 'thought', { 'emote_dots1', 'emote_dots2', 'emote_dots3' })
	self.isMirrored = direction == 'left' or false
	
	self.timer:after(delay, function()
		self.attacking = false
		self.dialogue  = nil
	end)
end

-- Stop current behavior
--
function Doctor:stop()
	self.dying     = false
	self.attacking = false
	self.fleeing   = false
	self.talking   = false
	self.guarding  = false
	self.walking   = false
end

return Doctor