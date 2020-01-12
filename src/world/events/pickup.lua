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
	-- properties
	self.name     = data.properties.name     or 'bullets'
	self.category = data.properties.category or 'ammo'
	self.value    = data.properties.value    or 1

	-- image
	self.image  = self.name
	self.sprite = Config.image.spritesheet[data.properties.spritesheet or 'item']

	-- NOTE: some pickups will have sizes
	-- that will need to be translated
	-- into a numerical value.
	if _:isString(self.value) then
		self.image = self.name .. '_' .. self.value
		self.value = Config.world.pickup[self.name][self.value]
	end

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
	Gamestate:current():rewardPlayer(self)

	-- -- audio queue
	-- if Config.audio.pickup[self.name] then
	-- 	Config.audio.pickup[self.name]:play()
	-- elseif Config.audio.pickup[self.category] then
	-- 	Config.audio.pickup[self.category]:play()
	-- end

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
	local w, h   = self.sprite:dimensions(self.image)
	local sx, sy = self.sx * _.__cos(self.osc), self.sx
	local ox, oy = w/2, h/2 + _.__sin(self.osc) * 5

	lg.setColor(Config.color.white)

	self.sprite:draw(self.image, cx, cy, 0, sx, sy, ox, oy)
	--
	Event.draw(self)
end

return Pickup