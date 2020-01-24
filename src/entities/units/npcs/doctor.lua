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
	self:pace()
end

-- Pace
--
function Doctor:pace()
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
				wait(3)
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
	self.handle = self.timer:after(5, function()
		self:interrupt():pace()
	end)
end

return Doctor