-- Entity Weapon
-- Shane Krolikowski
--

local Modern = require 'modern'
local Weapon = Modern:extend()

-- New weapon
--
function Weapon:new(name, host)
	self.host = host
	-- properties
	self.name = name
	-- flags
	self.firing = false
	-- ancestry
	self.children = {}
end

-- Destroy weapon (...not really)
--
function Weapon:destroy()
	for i = #self.children, 1, -1 do
		table.remove(self.children, i)
	end
end

-- Trigger weapon
--
function Weapon:trigger(dt, et)
	self.host.shooting = true
end

-- Holster weapon
--
function Weapon:holster()
	self.host.shooting = false
end

-- Weapon cooldown
--
function Weapon:cooldown()
	if self.fireRate then
		self.fireRate.now = self.fireRate.now - love.timer.getDelta()
		self.fireRate.now = _.__max(0, self.fireRate.now)
	end
end

-- Update weapon
--
function Weapon:update(dt)
	self:cooldown()

	-- remove children (if applicable)
	for i = #self.children, 1, -1 do
		if self.children[i].remove then
			table.remove(self.children, i)
		end
	end

	-- update children
	for __, child in pairs(self.children) do
		child:update(dt)
	end
end

-- Draw weapon
--
function Weapon:draw()
	-- draw children
	for __, child in pairs(self.children) do
		child:draw()
	end

	if self.nx then
	love.graphics.setColor(Config.color.white)
	love.graphics.circle('fill', self.nx, self.ny, '3')
	end
end

return Weapon