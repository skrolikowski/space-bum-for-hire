-- Comment
--

local Modern  = require 'modern'
local Comment = Modern:extend()

function Comment:new(host, text)
	-- properties
	self.host = host

	-- dialogue - text
	self.text = lg.newText(Config.ui.font.xs)
	self.text:setf(text, Config.tileSize * 16, 'center')
	
	-- dimensions
	self.width  = self.text:getWidth()  + Config.padding
	self.height = self.text:getHeight() + Config.padding

	-- scaling
	self.sx = 1
	self.sy = 1

	-- background
	self.image = Config.image.sprites.comment
	self.quad  = lg.newQuad(0, 0, self.width, self.height, self.image:getDimensions())
	self.image:setWrap('repeat', 'repeat')
end

-- Update
--
function Comment:update(dt)
	--
end

-- Draw
--
function Comment:draw()
	local cx, cy = self.host:getPosition()
	local w, h   = self.width, self.height
	local sx, sy = self.sx, self.sy
	local tx     = cx - w * sx / 2
	local ty     = cy - h * sy - h

	lg.push("all")
	lg.translate(tx, ty)
	lg.scale(sx, sy)
	--
	lg.setColor(Config.color.white)

	-- draw backdrop
	lg.draw(self.image, self.quad)

	-- draw text
	lg.draw(self.text)

	--
	lg.pop()
end

return Comment