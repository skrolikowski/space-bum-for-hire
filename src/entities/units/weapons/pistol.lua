-- Pistol Weapon
--

local Weapon = require 'src.entities.units.weapons.weapon'
local Pistol = Weapon:extend()

function Pistol:new(host)
	self.sprite = Animator()
	self.sprite:addAnimation('default', {
		image  = Config.image.spritesheet.effect.pistol,
		width  = 35,
		height = 6,
		total  = 1,
		fps    = 35,
		frames = { { 1, 1, 14, 1 } },
		after  = function() self.blast = false end
	})

	-- scaling
	self.sx = 0.85
	self.sy = 0.85
	--
	Weapon.new(self, 'pistol', host)
end

-- Trigger weapon
--
function Pistol:trigger(dt, et)
	Weapon.trigger(self, dt, et)
	--

	if not self.jammed then
		if Config.world.hud.ammo[self.weapon.clip].now > 0 then
			self:fire()
			self.sprite:restart()

			-- cooldown
			self.jammed = true
			self.timer:after(self.weapon.cooldown, function() self.jammed = false end)

			-- update ammo
			Gamestate.current().hud:decrease({
				category = 'ammo',
				name     = self.weapon.clip,
				value    = 1
			})

			-- play sound
			-- Config.audio.weapon.pistol.fire:play()
		else
			--TODO: play empty round sound
			-- Config.audio.weapon.pistol.empty:play()
		end
	end
end

-- Pistol shot
--
function Pistol:fire()
	local w, h  = self.weaponSprite:getDimensions()
	local angle = self.host.aimAngle
	local speed = self.weapon.speed

	-- blast coordinates
	local bx, by = Vec2(0, -h/2):polar(angle, w):unpack()
	local tx, ty = self.host.body:getWorldPoints(bx, by)

	-- adjust arm placement for crouch animation
	--
	if self.host.behavior.name == 'Player_crouch' then
		ty = ty + ty * 0.05
	end

	-- line up with host entity shot
	self.blast = Vec2(tx, ty)

	-- New Projectile
	Sensors['projectile'](self, {
		x       = tx,
		y       = ty,
		impulse = Vec2(0, 0):polar(angle, speed),
	})
end

-- Draw pistol blast
--
function Pistol:draw()
	Weapon.draw(self)
	--
	if self.blast then
		local tx, ty = self.blast:unpack()
		local angle  = self.host.aimAngle

		lg.setColor(Config.color.white)
		self.sprite:draw(tx, ty, angle)
	end
end

return Pistol