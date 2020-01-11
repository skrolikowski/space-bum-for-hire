-- Pickup Event
-- Awards Player an item or power-up
--

local Event  = require 'src.world.events.event'
local Pickup = Event:extend()

-- New pickup
--
function Pickup:new(data)
	Event.new(self, 'Pickup', data)
	--
	self.type   = data.properties.type  or 'item'
	self.item   = data.properties.item  or 'bullets'
	self.value  = data.properties.value or 'sm'
	self.sprite = Config.image.spritesheet[self.type]

	-- scaling
	self.sx = 1
	self.sy = 1

	-- oscillation
	self.osc = 0
end

-- Check for contacts
--
function Pickup:beginContact(other, col)
	if col:isTouching() then
		if other.name == 'Player' then
			self:trigger()
		end
	end
end

-- Award host with reward
--
function Pickup:trigger()
	-- reward host
	Gamestate:current():rewardPlayer(self.item, self.value)

	-- clean up
	self:destroy()
end

-- Animation
--
function Pickup:update(dt)
	self.osc = self.osc + dt * 3
end

-- Draw pickup
--
function Pickup:draw()
	local cx, cy = self:getPosition()
	local w, h   = self.sprite:dimensions(self.item)
	local sx, sy = self.sx * _.__cos(self.osc), self.sx
	local ox, oy = w/2, h/2 + _.__sin(self.osc) * 5

	lg.setColor(Config.color.white)

	self.sprite:draw(self.item, cx, cy, 0, sx, sy, ox, oy)
	--
	Event.draw(self)
end

return Pickup