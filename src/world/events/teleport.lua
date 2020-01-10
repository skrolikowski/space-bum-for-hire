-- Teleport Event
-- Moves target from scene A to scene B
--

local Event    = require 'src.world.events.event'
local Teleport = Event:extend()

function Teleport:new(data)
	Event.new(self, 'Teleport', data)
	--
	self.hosting = nil
	self.map     = data.properties.map
	self.exit    = data.properties.exit
	self.method  = data.properties.method

	_:on('player_request', function() self:request() end)
end

-- Attempt event trigger!
--
function Teleport:request()
	if self.hosting then
		if self.method == 'door' then
		-- Exit into doorway
			Gamestate:current().timer:script(function(wait)
				-- remove player controls
				Gamestate:current():setControl('none')
				_:off('player_request')
				--
				-- enter cutscene double..
			    Double = Entities['Double']({
			        x      = self.hosting:getX() - Config.spawn.width/2,
			        y      = self.hosting:getY() - Config.spawn.height/2,
			        width  = Config.spawn.width,
			        height = Config.spawn.height,
			    })
				Gamestate:current().player:destroy()
			    Gamestate:current().filming = Double
			    --
			    Double:move(self.exit, 350, 1.5)
				wait(1.5)
				--
				self:teleport()
			end)
		end
	end
end

-- Teleport guest
--
function Teleport:teleport()
	Gamestate.switch(Gamestates[self.map])
end

-- Check for contacts
--
function Teleport:beginContact(other, col)
	if col:isTouching() then
		if other.name == 'Player' then
			self.hosting = other

			if self.method == 'contact' then
			-- Teleport on contact
				self:teleport()
			end
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

return Teleport