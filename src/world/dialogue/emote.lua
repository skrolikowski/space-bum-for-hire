-- Emote Dialogue
--

local Modern = require 'modern'
local Emote  = Modern:extend()

function Emote:new(host, style, name)
	self.name  = 'emote_' .. name
	self.host  = host
	self.style = style

	-- scaling
	if style == 'free' then
		self.sx  = 0.6
		self.sy  = 0.6
	else
		self.sx  = 0.5
		self.sy  = 0.5
	end

	-- oscillation
	self.osc = 0

	-- image
	self.spritesheet = Config.image.spritesheet.emote[style]
end

-- Center position
--
function Emote:center()
	local cx, cy = self.host:getPosition()
	local hw, hh = self.host:dimensions()
	local w, h   = self:dimensions()

	if self.style == 'free' then
		return cx - w / 2, cy - hh / 2 - h / 2
	else
		return cx - w, cy - hh / 2 - h / 2
	end
end

-- Emote width/height
--
function Emote:dimensions()
	local w, h = self.spritesheet:dimensions(self.name)

	w = w * self.sx
	h = h * self.sy

	return w, h
end

-- Apply movement
function Emote:update(dt)
	self.osc = self.osc + dt * 10
end

-- Draw emote
--
function Emote:draw()
	local cx, cy  = self:center()
	local sx, sy  = self.sx, self.sy
	local ox, oy  = 0, _.__sin(self.osc) * 5
	local r, g, b = unpack(Config.color.white)

	lg.setColor(r, g, b, 1)
	self.spritesheet:draw(self.name, cx, cy, 0, sx, sy, ox, oy)
end

return Emote