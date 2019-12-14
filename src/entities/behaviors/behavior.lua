-- Entity Behavior
-- Shane Krolikowski
--

local Modern   = require 'modern'
local Behavior = Modern:extend()

-- New behavior
--
function Behavior:new(name, host)
	self.name = name
	self.host = host
end

-- Destroy behavior
--
function Behavior:destroy()
	--
end

-- Update behavior
--
function Behavior:update(dt)
	self.sprite:update(dt)
end

-- Draw behavior
--
function Behavior:draw()
	local cx, cy     = self.host:getPosition()
	local w, h       = self.sprite:dimensions()
	local sx, sy     = self.host.sx, self.host.sy
	local isMirrored = self.host.isMirrored
	local isFlipped  = self.host.isFlipped
	local stateName  = self.name .. '\n'

	if isMirrored then sx = -sx end
	if isFlipped  then sy = -sy end

	love.graphics.setColor(Config.color.white)

	self.sprite:draw(cx, cy, 0, sx, sy, w/2, h/2)

	-- display state
	if self.host.locking  then stateName = stateName .. 'L' end
	if self.host.shooting then stateName = stateName .. 'S' end

	love.graphics.setColor(Config.color.white)
	love.graphics.setFont(Config.ui.font.sm)
	love.graphics.printf(stateName, cx - w/2, cy - h/2, w, 'center')
	-- love.graphics.printf(self.host.axis:heading(), cx - w/2, cy - h, w, 'center')
end

return Behavior