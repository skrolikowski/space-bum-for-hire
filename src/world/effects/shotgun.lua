-- Shotgun Fire Effect
--

local Base    = require 'src.world.effects.effect'
local Shotgun = Base:extend()

-- New pistol fire effect
--
function Shotgun:new(data)
	local total = data.total or 1
	local fps   = data.fps   or 50

	self.sprite = Animator()
	self.sprite:addAnimation('shotgun', {
		image  = Config.image.spritesheet.effect.shotgun,
		width  = 60,
		height = 8,
		total  = total,
		fps    = fps,
		frames = { { 1, 1, 17, 1 } },
		after  = function()
			total = total - 1

			if total == 0 then
				self:destroy()
			end
		end
	})
	--
	Base.new(self, 'shotgun', data)

	-- play sound
	Config.audio.weapon.shotgun:play()
	Config.audio.weapon.shotgun:seek(0)
end

-- Draw effect
--
function Shotgun:draw()
	local tx, ty  = self.pos:unpack()
	local angle   = self.angle
	local sx, sy  = self.sx, self.sy
	local r, g, b = Config.color.white

	if self.isMirrored then
		sx    = -sx
		angle = angle + _.__pi
	end

	lg.push()
	lg.translate(tx, ty)
	lg.rotate(angle)
	lg.scale(sx, sy)

	lg.setColor(r, g, b, 0.25)

	self.sprite:draw(0, 0)
	self.sprite:draw(0, 0, -_.__pi/16)
	self.sprite:draw(0, 0,  _.__pi/16)
	self.sprite:draw(0, 0, -_.__pi/14, 0.75, 0.75)
	self.sprite:draw(0, 0,  _.__pi/14, 0.75, 0.75)
	self.sprite:draw(0, 0, -_.__pi/12, 0.5,  0.5)
	self.sprite:draw(0, 0,  _.__pi/12, 0.5,  0.5)

	lg.pop()
end

return Shotgun