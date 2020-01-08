-- Comment
--

local Modern  = require 'modern'
local Comment = Modern:extend()

function Comment:new(host, delay, callback)
	self.name = 'dialogue'
	self.host = host

	-- text
	local index = _.__random(#Dialogue_.comment[host.name])
	local text  = Dialogue_.comment[host.name][index]
	local font  = Config.ui.font.xs

	self.text = lg.newText(font)
	self.text:setf(text, Config.world.meter * 8, 'center')
	self.width   = self.text:getWidth()  + Config.padding
	self.height  = self.text:getHeight() + Config.padding

	-- backdrop
	self.image = Config.image.sprites.comment
	self.quad  = lg.newQuad(0, 0, self.width, self.height, self.image:getDimensions())
	self.image:setWrap('repeat', 'repeat')

	-- start dialogue
	self.timer = Timer.new()
	self.timer:after(delay, callback)
end

-- Center position
--
function Comment:center()
	local cx, cy = self.host:getPosition()
	local w, h   = self.host:dimensions()

	return cx, cy - h/2 - self.height
end

-- Containing box
--
function Comment:container()
	local cx, cy = self:center()
	local w, h   = self:dimensions()
	local x      = cx - w/2
	local y      = cy - h/2

	return x, y, w, h
end

-- Comment width/height
--
function Comment:dimensions()
	return self.image:getDimensions()
end

-- Update
--
function Comment:update(dt)
	self.timer:update(dt)
end

-- Draw
--
function Comment:draw()
	local x, y, w, h = self:container()
	local halfPad    = self.padding / 2

	-- draw backdrop
	lg.setColor(Config.color.white)
	lg.draw(self.image, self.quad, x, y)

	-- draw text
	lg.draw(self.text, x + halfPad, y + halfPad)
end

return Comment