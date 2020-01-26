-- Captain Unit Entity
--

local NPC    = require 'src.entities.units.npcs.npc'
local Captain = NPC:extend()

function Captain:new(data)
	NPC.new(self, _:merge(data, {
		name  = 'Captain',
		title = data.title or 'Captain',
		shape = 'rectangle',
	}))
	--
end

return Captain