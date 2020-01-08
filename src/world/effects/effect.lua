-- Base Effect
--

local Modern = require 'modern'
local Effect = Modern:extend()

-- New effect
--
function Effect:new(name, data)
	local width  = data.width
	local height = data.height

	self.pos = Vec2(data.x, data.y)

	-- scaling
	local w, h = self.sprite:dimensions()

	self.sx = data.width  / w
	self.sy = data.height / h

	-- flags
	self.isMirrored = data.isMirrored == true or false
	self.isFlipped  = data.isFlipped  == true or false
end

-- Mark for removal
--
function Effect:destroy()
	self.remove = true
end

-- Update effect
--
function Effect:update(dt)
	self.sprite:update(dt)
end

-- Draw effect
--
function Effect:draw()
	local cx, cy     = self.pos:unpack()
	local w, h       = self.sprite:dimensions()
	local sx, sy     = (self.sx or 1), (self.sy or 1)
	local isMirrored = self.isMirrored
	local isFlipped  = self.isFlipped

	local ox = w/2 + (self.ox or 0)
	local oy = h/2 + (self.oy or 0)

	if isMirrored then sx = -sx end
	if isFlipped  then sy = -sy end

	lg.setColor(Config.color.white)
	self.sprite:draw(cx, cy, 0, sx, sy, ox, oy)
end

return Effect