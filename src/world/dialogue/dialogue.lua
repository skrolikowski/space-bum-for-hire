-- Dialogue
--

local Modern   = require 'modern'
local Dialogue = Modern:extend()

function Dialogue:new(host, callback)
	self.name  = 'dialogue'
	self.host  = host
	self.after = after or function() end

	-- text
	local index = _.__random(#Config.dialogue[host.name].comment)
	local text  = Config.dialogue[host.name].comment[index]
	local font  = Config.ui.font.xs

	self.text = lg.newText(font)
	self.text:setf(text, 150, 'center')
	self.padding = 10
	self.width   = self.text:getWidth()  + self.padding
	self.height  = self.text:getHeight() + self.padding

	-- backdrop
	self.image = Config.image.sprites.comment
	self.quad  = lg.newQuad(0, 0, self.width, self.height, self.image:getDimensions())
	self.image:setWrap('repeat', 'repeat')

	-- start dialogue
	self.timer = Timer.new()
	self.timer:after(5, callback)
end

-- Center position
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

-- Dialogue width/height
--
function Dialogue:dimensions()
	return self.width, self.height
end

-- Update
--
function Dialogue:update(dt)
	--TODO: scrolling text
	self.timer:update(dt)
end

-- Draw
--
function Dialogue:draw()
	local x, y, w, h = self:container()

	lg.setColor(Config.color.white)
	lg.draw(self.image, self.quad, x, y)

	-- draw text
	-- lg.setFont(Config.ui.font.xs)
	-- lg.printf(self.text, x + 5, y + h/2, w - 10, 'center')
	lg.draw(self.text, x + self.padding/2, y + self.padding/2)
end

return Dialogue