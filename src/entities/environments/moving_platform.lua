-- MovingPlatform entity
-- Shane Krolikowski
--

local Environment    = require 'src.entities.environments.environment'
local MovingPlatform = Environment:extend()

function MovingPlatform:new(data)
	Environment.new(self, data)
	--
	self.color   = Config.color.white
	self.image   = Config.image.sprites.platform
	self.hosting = nil
	self.dx = 0
	self.dy = 0
end

-- Check for contacts
--
function MovingPlatform:beginContact(other, col)
	-- local nx, ny = col:getNormal()

	if col:isTouching() then
		if other.name == 'Player' then
			self.hosting = other
			-- print('hosting player')
		end
	end
end

-- Check for separations
--
function MovingPlatform:endContact(other, col)
	if other.name == 'Player' then
		self.hosting = nil
		-- print('unhosting player')
	end
end

-- Get change in position for host
-- [override]
--
function MovingPlatform:setPosition(nx, ny)
	local cx, cy = self:getPosition()
	local dx, dy = nx - cx, ny - cy

	if self.hosting ~= nil then
	-- adjust host's position
		local hx, hy = self.hosting:getPosition()
		local nx, ny = hx + dx, hy + dy
		self.hosting:setPosition(nx, ny)
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