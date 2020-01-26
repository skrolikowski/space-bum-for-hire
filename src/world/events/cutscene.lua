-- Cutscene Event
--

local Event    = require 'src.world.events.event'
local Cutscene = Event:extend()

function Cutscene:new(data)
	Event.new(self, 'Cutscene', data)
	--
	-- properties
	self.scene      = data.properties.scene
	self.checkpoint = Gamestate:current().world:fetchEntityById(data.properties.checkpoint)
end

-- Set Player Cutscene
--
function Cutscene:beginContact(other, col)
	if col:isTouching() then
		if other.name == 'Player' then
			Gamestate:current():setCheckpoint(self.checkpoint)
			Gamestate.push(Gamestates[self.scene])
			self:destroy()
		end
	end
end

return Cutscene