-- Cutscene Event
--

local Event    = require 'src.world.events.event'
local Cutscene = Event:extend()

function Cutscene:new(data)
	Event.new(self, 'Cutscene', data)
	--
	-- properties
	self.scene      = data.properties.scene
	self.require    = data.properties.require or false
	self.quest      = data.properties.quest   or false
	self.checkpoint = Gamestate:current().world:fetchEntityById(data.properties.checkpoint)
end

-- Set Player Cutscene
--
function Cutscene:beginContact(other, col)
	if col:isTouching() then
		if other.name == 'Player' then
			if self:passesRequirements() then
				-- set checkpoint and new quest
				Gamestate:current():setCheckpoint(self.checkpoint)
				Gamestate:current():setQuest(self.quest)

				-- switch to 
				Gamestate.push(Gamestates[self.scene])
			end
		end
	end
end

-- Check for requirements before starting..
--
function Cutscene:passesRequirements()
	-- requires specific quest
	if self.require and self.require ~= Config.world.hud.quest then
		return false
	end

	return true
end

return Cutscene