-- Ensign Unit Entity
--

local NPC    = require 'src.entities.units.npcs.npc'
local Ensign = NPC:extend()

function Ensign:new(data)
	NPC.new(self, _:merge(data, {
		name  = 'Ensign',
		title = data.title or 'Ensign',
		shape = 'rectangle',
	}))
	--
	self:pace()
end

return Ensign