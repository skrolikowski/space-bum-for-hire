-- Emote Dialogue
--

local Modern = require 'modern'
local Emote  = Modern:extend()

-- New Emote
--
function Emote:new(host, style, emote)
	self.host        = host
	self.style       = style
	self.spritesheet = Config.image.spritesheet.emote[style]

	if _:isTable(emote) then
		self.emote = Animator()
		self.emote:addAnimation(style, {
			image  = self.spritesheet:getImage(),
			width  = 32,
			height = 38,
			fps    = 3,
			frames = {}
		})
		-- Hack in some frames
		for __, name in pairs(emote) do
			table.insert(self.emote.current.frames, self.spritesheet:quad(name))
		end
		table.insert(self.emote.current.frames, self.spritesheet:quad('emote__'))
	else
		self.emote = emote
	end

	-- scaling
	if style == 'free' then
		self.sx  = 0.65
		self.sy  = 0.65
	else
		self.sx  = 0.55
		self.sy  = 0.55
	end

	-- oscillation
	self.osc = 0
end

-- Center position
--
function Emote:center()
	local cx, cy = self.host:getPosition()
	local hw, hh = self.host:dimensions()
	local w, h   = self:dimensions()

	return cx - w / 2, cy - hh / 2 - h / 2
end

-- Emote width/height
--
function Emote:dimensions()	
	local w, h

	if self.emote.dimensions then
		w, h = self.emote:dimensions()
	else
		w, h = self.spritesheet:dimensions(self.emote)
	end

	w = w * self.sx
	h = h * self.sy

	return w, h
end

-- Apply movement
--
function Emote:update(dt)
	self.osc = self.osc + dt * 15

	if self.emote.update then
		self.emote:update(dt)
	end
end

-- Draw emote
--
function Emote:draw()
	local cx, cy  = self:center()
	local sx, sy  = self.sx, self.sy
	local ox, oy  = 0, _.__sin(self.osc) * 5
	
	lg.setColor(Config.color.white)

	if self.emote.draw then
		self.emote:draw(cx, cy, 0, sx, sy, ox, oy)
	else
		self.spritesheet:draw(self.emote, cx, cy, 0, sx, sy, ox, oy)
	end
end

return Emote