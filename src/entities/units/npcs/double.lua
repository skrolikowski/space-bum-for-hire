-- Double Unit Entity
-- Cutscene double of Player
--

local NPC    = require 'src.entities.units.npcs.npc'
local Double = NPC:extend()

function Double:new(data)
	NPC.new(self, _:merge(data, {
		name  = 'Double',
		title = data.title or 'Player',
		shape = 'rectangle',
	}))
	--
end

return Double