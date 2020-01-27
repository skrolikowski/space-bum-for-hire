-- Engineer Unit Entity
--

local NPC      = require 'src.entities.units.npcs.npc'
local Engineer = NPC:extend()

function Engineer:new(data)
	NPC.new(self, _:merge(data, {
		name  = 'Engineer',
		title = data.title or 'Engineer',
		shape = 'rectangle',
	}))
	--
	self:pace()
end

return Engineer