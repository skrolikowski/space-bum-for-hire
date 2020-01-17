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

	-- play sound
	Config.audio.weapon.pistol:play()
	Config.audio.weapon.pistol:seek(0)
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
end

return Pistol