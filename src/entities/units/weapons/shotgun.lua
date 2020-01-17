-- Shotgun Weapon
--

local Weapon  = require 'src.entities.units.weapons.weapon'
local Shotgun = Weapon:extend()

function Shotgun:new(host)
	self.sprite = Animator()

	-- weapon scaling
	self.sx = 0.75
	self.sy = 0.75
	--
	Weapon.new(self, 'shotgun', host)
end

-- Trigger weapon
--
function Shotgun:trigger(dt, et)
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
		else
			-- dry fire
			Config.audio.weapon.dryfire:play()
		end
	end
end

-- Shotgun shot
--
function Shotgun:fire()
	local w, h  = self.weaponSprite:getDimensions()
	local angle = self.host.aimAngle
	local speed = self.weapon.speed

	-- blast coordinates
	local bx, by = Vec2(0, -h/2):polar(angle, w):unpack()
	local tx, ty = self.host.body:getWorldPoints(bx, by)

	-- adjust arm placement for crouch animation
	--
	if self.host.behavior.name == 'Player_crouch' then
		ty = ty + h * 0.65
	end

	-- Blast effect
	Effects['shotgun']({
		x          = tx,
		y          = ty,
		angle      = self.host.aimAngle,
		isMirrored = self.host.isMirrored,
	})

	-- New Projectile
	Sensors['projectile'](self, { x = tx, y = ty, angle = angle })
	Sensors['projectile'](self, { x = tx, y = ty, angle = angle - _.__pi/16 })
	Sensors['projectile'](self, { x = tx, y = ty, angle = angle + _.__pi/16 })
	Sensors['projectile'](self, { x = tx, y = ty, angle = angle - _.__pi/14 })
	Sensors['projectile'](self, { x = tx, y = ty, angle = angle + _.__pi/14 })
	Sensors['projectile'](self, { x = tx, y = ty, angle = angle - _.__pi/12 })
	Sensors['projectile'](self, { x = tx, y = ty, angle = angle + _.__pi/12 })
end

return Shotgun