-- Base Enemy Behavior
--

local Behavior = require 'src.entities.units.behaviors.behavior'
local Base     = Behavior:extend()

-- Set environmental bounds
--
function Base:setBounds()
	local x, y, w, h = unpack(self.host.shapeData)
	local name       = self.host.name

	self.sx = self.sx * -1  -- default facing ==>

	if name == 'DarkMage' then
		self.ox     = w/6
		self.bounds = AABB:fromContainer(x, y+h*0.15, w/2, h*0.7)
	elseif name == 'Boss' then
		self.ox     = w/6
		self.bounds = AABB:fromContainer(x, y+h*0.15, w/2, h*0.7)
	elseif name == 'Ghoul' then
		self.ox     = w/10
		self.bounds = AABB:fromContainer(x, y, w/2, h)
	elseif name == 'Executioner' then
		self.ox     = w/12
		self.bounds = AABB:fromContainer(x, y, w/2, h)
	end
end


return Base