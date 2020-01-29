-- Cutscene Event
--

local Event    = require 'src.world.events.event'
local Cutscene = Event:extend()

function Cutscene:new(data)
	Event.new(self, 'Cutscene', data)
	--
	-- properties
	self.scene      = data.properties.scene
	self.image      = data.properties.image   or false
	self.transition = data.properties.transition or 'push'
	self.require    = data.properties.require or false
	self.quest      = data.properties.quest   or false
	self.checkpoint = Gamestate:current().world:fetchEntityById(data.properties.checkpoint)

	-- for a slight delay
	self.timer = Timer.new()
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

				self:trigger()
			end
		end
	end
end

-- Trigger cutscene
--
function Cutscene:trigger()
	self.timer:after(0.5, function()
		Gamestate[self.transition](Gamestates[self.scene])
	end)
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

-- Update
--
function Cutscene:update(dt)
	self.timer:update(dt)
	--
	Event.update(self, dt)
end

-- Draw
--
function Cutscene:draw()
	if self.image then
		local sheet  = Config.image.spritesheet.item
		local cx, cy = self:getPosition()
		local w, h   = sheet:dimensions(self.image)
		local sx, sy = 1, 1
		local ox, oy = w/2, h/2

		lg.setColor(Config.color.white)
		sheet:draw(self.image, cx, cy, 0, sx, sy, ox, oy)
	end
	--
	Event.draw(self)
end

return Cutscene