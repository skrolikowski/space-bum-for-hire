-- Dialogue Interface
--

local Modern   = require 'modern'
local Dialogue = Modern:extend()

-- New Dialogue
--
function Dialogue:new(host)
	self.name  = 'dialogue'
	self.host  = host
	self.timer = Timer.new()

	-- scaling
	self.sx = 0.75
	self.sy = 0.75

	-- background
	self.background = Config.ui.hud.dialogue
	self.padding    = 15

	-- bootstrap
	self:setTransform()
	self:setText()
end

-- Set transform for drawing dialogue
--
function Dialogue:setTransform()
	local bounds = self.host:bounds()
	local w, h   = self:dimensions()

	self.transform = lx.newTransform()
	self.transform:translate(0, bounds:getHeight() - h - self.padding)
	self.transform:scale(self.sx, self.sy)
end

-- Set index of dialogue script
--
function Dialogue:setText(index)
	local script = Config.dialogue[self.host.name].dialogue
	local font   = Config.ui.font.xs
	local w, h   = self:dimensions()
	local index  = index or 1

	self.text = lg.newText(font)
	self.text:setf(script[index], w, 'center')

	-- allow for reading
	-- self.timer = Timer.new()
	-- self.timer:after(5, function() self:setText(index + 1) end)
end

-- Dialogue position
--
function Dialogue:center()
	local cx, cy = self.host:getPosition()
	local w, h   = self.host:dimensions()

	return cx, cy - h/2 - self.height
end

-- Containing box
--
function Dialogue:container()
	local cx, cy = self:center()
	local w, h   = self:dimensions()
	local x      = cx - w/2
	local y      = cy - h/2

	return x, y, w, h
end


-- Dialogue dimensions
--
function Dialogue:dimensions()
	local w, h = self.background:getDimensions()

	w = w * self.sx
	h = h * self.sy

	return w, h
end

-- Update w/ Dialogue
--
function Dialogue:update(dt)
	self.timer:update(dt)
	--
	-- TODO: reveal text
end

-- Draw Dialogue
--
function Dialogue:draw()
	local x, y, w, h = self:container()
	local r, g, b    = unpack(Config.color.white)
	local halfPad    = self.padding / 2

	lg.setColor(r, g, b, 0.90)
	lg.draw(self.background, self.transform)

	-- draw text
	lg.draw(self.text, x + halfPad, y + halfPad)
end

return Dialogue