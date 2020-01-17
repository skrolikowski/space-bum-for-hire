-- Pistol Weapon
--

local Weapon = require 'src.entities.units.weapons.weapon'
local Pistol = Weapon:extend()

function Pistol:new(host)
	self.sprite = Animator()

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
		else
			-- dry fire
			Config.audio.weapon.dryfire:play()
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
		ty = ty + h * 0.65
	end

	-- Blast effect
	Effects['pistol']({
		x          = tx,
		y          = ty,
		angle      = self.host.aimAngle,
		isMirrored = self.host.isMirrored,
	})

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
end

return Pistol