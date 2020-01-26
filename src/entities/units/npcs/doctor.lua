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

return Doctor