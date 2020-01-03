-- Doctor Unit Entity
-- Non-agressive, super smart techy dudes.
-- They wander the galaxy looking for "losers" to outsmart.
--

local NPC    = require 'src.entities.units.npcs.npc'
local Doctor = NPC:extend()

function Doctor:new(data)
	NPC.new(self, data)
	--
end

-- In Focus Event
-- Handle when entity comes into focus
--
function Doctor:inFocus(other)
	if other.category == 'Enemy' then
	-- Run from enemies
		self.fleeing = true
		self.target  = other
	elseif other.name == 'Player' then
	-- Comment to player
		if self.talking == false then
			self.talking = true
			self.target  = other
		end
	end
end

return Doctor