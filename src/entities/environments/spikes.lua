-- Spikes entity
-- Shane Krolikowski
--

local Entity = require 'src.entities.entity'
local Environment    = require 'src.entities.environments.environment'
local Spikes = Environment:extend()

function Spikes:new(data)
	Environment.new(self, _:merge(data, {
		--@overrides
		name     = 'Spikes',
		isSensor = true
	}))
	--
	self.damage = data.damage or 5
	self.facing = data.properties.facing or 'N'
	self.color  = Config.color.white

	-- image
	self.image = Config.image.sprites.spikes
	self.image:setWrap('repeat', 'repeat')

	if self.facing == 'N' then
		self.angle = 0
		self.quad  = lg.newQuad(0, 0, data.width, self.image:getHeight(), self.image:getDimensions())
	elseif self.facing == 'E' then
		self.angle = _.__rad(90)
		self.quad  = lg.newQuad(0, 0, data.height, self.image:getHeight(), self.image:getDimensions())
	elseif self.facing == 'S' then
		self.angle = _.__rad(180)
		self.quad  = lg.newQuad(0, 0, data.width, self.image:getHeight(), self.image:getDimensions())
	else
		self.angle = _.__rad(270)
		self.quad  = lg.newQuad(0, 0, data.height, self.image:getHeight(), self.image:getDimensions())
	end
end

-- Draw platform
--
function Spikes:draw()
	local cx, cy     = self:getPosition()
	local x, y, w, h = self.quad:getViewport()
	local angle      = self.angle
	local sx, sy     = 1, 1

	lg.setColor(self.color)
	lg.draw(self.image, self.quad, cx, cy, angle, sx, sy, w/2, h/2)
	--
	Environment.draw(self)
end

return Spikes