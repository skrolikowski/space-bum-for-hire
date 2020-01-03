-- Event - Damage
-- --------------------
-- Damages visiting entity with
--   possible forgiveness between attacks.
--

local Event  = require 'src.world.sensors.sensor'
local Damage = Event:extend()

function Damage:new(data)
	data.name = 'DamageEvent'
	Event.new(self, data)
	--
	self.attack = data.attack or 5
	self.delay  = data.delay or 1
end

-- Check for contacts
--
function Damage:beginContact(other, col)
	if col:isTouching() then
		self:causeDamage()
	end
end

function Damage:causeDamage(other)
	-- damage is dealt..
	other:damage(self, self.attack)

	-- schedule another pounding..
	Timer.after(self.delay, function()
		self:causeDamage(other)
	end)
end

return Damage