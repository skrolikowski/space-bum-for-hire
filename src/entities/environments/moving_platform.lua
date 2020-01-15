-- MovingPlatform entity
-- Shane Krolikowski
--

local Environment    = require 'src.entities.environments.environment'
local MovingPlatform = Environment:extend()

function MovingPlatform:new(data)
	Environment.new(self, _:merge(data, {
		--@overrides
		name = 'MovingPlatform',
	}))
	--
	self.color   = Config.color.white
	self.area    = data.properties.area or 'spaceship'
	self.image   = Config.image.sprites.platform[self.area]
	self.hosting = {}
	self.affects = Util:toBoolean({ 'Unit' })
	self.dx = 0
	self.dy = 0
end

-- Check for contacts
--
function MovingPlatform:beginContact(other, col)
	-- local nx, ny = col:getNormal()

	if col:isTouching() then
		if self.affects[other.category] then
			if not self.hosting[other.uuid] then
				self.hosting[other.uuid] = other
			end
		end
	end
end

-- Check for separations
--
function MovingPlatform:endContact(other, col)
	if self.affects[other.category] then
		if self.hosting[other.uuid] then
			self.hosting[other.uuid] = nil
		end
	end
end

-- Get change in position for host
-- [override]
--
function MovingPlatform:setPosition(nx, ny)
	local cx, cy = self:getPosition()
	local dx, dy = nx - cx, ny - cy

	for __, guest in pairs(self.hosting) do
		-- adjust guest's position
		local hx, hy = guest:getPosition()
		local nx, ny = hx + dx, hy + dy

		guest:setPosition(nx, ny)
	end
	--
	Environment.setPosition(self, nx, ny)
end

-- Draw platform
--
function MovingPlatform:draw()
	local cx, cy = self:getPosition()
	local w, h   = self.image:getDimensions()

	lg.setColor(self.color)
	lg.draw(self.image, cx, cy, 0, 1, 1, w/2, h/2)
	--
	Environment.draw(self)
end

return MovingPlatform