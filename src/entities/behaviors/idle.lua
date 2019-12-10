-- Idle Behavior
--

local Modern = require 'modern'
local Idle   = Modern:extend()

function Idle:new(host)
	self.host = host

	self.host.sprite:addAnimation('idle', {
		image  = Config.image.spritesheet.cyberpunk.idle,
		width  = 64,
		height = 64,
		frames = { { 1, 1, 1, 6 } }
	})
end

function Idle:update(dt)
	--
end

function Idle:draw()
	if self.visible then
    	local cx, cy = self:getPosition()
    	local w, h   = self.sprite:dimensions()
    	local sx, sy = self.sx, self.sy

        if self.isMirrored then sx = -sx end
        if self.isFlipped  then sy = -sy end

        love.graphics.setColor(Config.color.white)

        self.sprite:draw(cx, cy, 0, sx, sy, w/2, h/2)
    end
end

return Idle