-- Script Dialogue
--

local Modern = require 'modern'
local Script = Modern:extend()

-- New Script
--
function Script:new(host, data)
	-- properties
	self.host       = host
	self.avatars    = Config.image.spritesheet.avatars
	self.avatar     = _.__lower(data.title)
	self.background = Config.ui.hud.script

	-- dimensions
	self.width  = self.background:getWidth()
	self.height = self.background:getHeight()

	-- scaling
	self.sx = 0.4
	self.sy = 0.4

	-- flags
	self.isMirrored = false

	-- dialogue
	self.title = lg.newText(Config.ui.font.lg)
	self.title:setf(data.title, Config.world.meter * 6, 'left')

	self.text = lg.newText(Config.ui.font.lg)
	self.text:setf(data.text, Config.world.meter * 16, 'center')
end

-- Update
--
function Script:update(dt)
	--
end

function Script:draw()
	local cx, cy = self.host:getPosition()
	local w, h   = self.width, self.height
	local sx, sy = self.sx, self.sy
	local tx     = cx - w * sx / 2
	local ty     = cy - h * sy / 2 - h / 3

	if self.isMirrored then
		sx = -sx
	end

	lg.push("all")
	lg.translate(tx, ty)
	lg.scale(sx, sy)
	--
	lg.setColor(Config.color.white)

	-- background
	lg.draw(self.background)

	-- avatar
	self.avatars:draw(self.avatar, Config.world.meter * 16.75, Config.world.meter, 0, 5, 5)

	-- title
	lg.draw(self.title, Config.world.meter * 2, Config.world.meter * 0.75)

	-- dialogue
	lg.draw(self.text, Config.world.meter, Config.world.meter * 3)
	
	--
	lg.pop()
end

return Script