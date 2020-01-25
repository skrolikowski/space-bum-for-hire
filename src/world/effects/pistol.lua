-- Pistol Fire Effect
--

local Base   = require 'src.world.effects.effect'
local Pistol = Base:extend()

-- New pistol fire effect
--
function Pistol:new(data)
	local total = data.total or 1
	local fps   = data.fps   or 30

	self.sprite = Animator()
	self.sprite:addAnimation('pistol', {
		image  = Config.image.spritesheet.effect.pistol,
		width  = 35,
		height = 6,
		total  = total,
		fps    = fps,
		frames = { { 1, 1, 14, 1 } },
		after  = function()
			total = total - 1

			if total == 0 then
				self:destroy()
			end
		end
	})
	--
	Base.new(self, 'pistol', data)

	-- raycast effect
	self.timer = Timer.new()
	self.ray   = {
		x     = self.pos.x + _.__cos(self.angle) * 300,
		y     = self.pos.y + _.__sin(self.angle) * 300,
		color = {1,0,0,0.15}
	}
	self.timer:tween(0.5, self.ray.color, {1,1,1,0}, 'linear')

	-- play sound
	Config.audio.weapon.pistol:play()
	Config.audio.weapon.pistol:seek(0)
end

-- Teardown
--
function Pistol:destroy()
	self.timer:clear()
	--
	Base.destroy(self)
end

-- Update
--
function Pistol:update(dt)
	self.timer:update(dt)
	--
	Base.update(self, dt)
end

-- Draw effect
--
function Pistol:draw()
	local tx, ty = self.pos:unpack()
	local angle  = self.angle
	local sx, sy = self.sx, self.sy

	if self.isMirrored then
		sx    = -sx
		angle = angle + _.__pi
	end

	lg.setColor(Config.color.white)
	self.sprite:draw(tx, ty, angle, sx, sy, 0, 2)

	-- bullet ray
	lg.setColor(self.ray.color)
	lg.line(tx, ty, self.ray.x, self.ray.y)
end

return Pistol