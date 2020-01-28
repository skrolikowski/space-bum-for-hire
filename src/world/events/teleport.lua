-- Teleport Event
-- Moves target from scene A to scene B
--

local Event    = require 'src.world.events.event'
local Teleport = Event:extend()

--
--
function Teleport:new(data)
	Event.new(self, 'Teleport', data)
	--
	self.hosting = nil

	-- properties
	self.map     = data.properties.map
	self.exit    = data.properties.exit
	self.method  = data.properties.method
	self.section = data.properties.section

	-- flags
	self.onTouch = data.properties.onTouch or false

	_:on('player_request', function() self:request() end)
end

-- Teardown
--
function Teleport:destroy()
	_:off('player_request')
end

-- Some events require a request
--
function Teleport:request()
	if self.hosting then
		local cx, cy = self.hosting:getPosition()

		if self.method == 'door' then
		-- Exit into doorway
			Gamestate:current():playerExitDoor(cx, cy, self.exit, function()
				self:teleport({
					from    = Gamestate:current().id,
					section = self.section
				})
			end)
		elseif self.method == 'beam' then
		-- Beam me up!
			Gamestate:current():playerExitBeam(cx, cy, function()
				self:teleport({
					from    = Gamestate:current().id,
					section = self.section
				})
			end)
		end
	end
end

-- Teleport guest
--
function Teleport:teleport(...)
	Gamestate.switch(Gamestates[self.map], ...)
end

-- Check for contacts
--
function Teleport:beginContact(other, col)
	if col:isTouching() then
		if other.name == 'Player' then
			self.hosting = other
		end
	end
end

-- Check for separations
--
function Teleport:endContact(other, col)
	if other.name == 'Player' then
		self.hosting = nil
	end
end

-- Update
--
function Teleport:update(dt)
	if self.onTouch then self:request() end
end

return Teleport