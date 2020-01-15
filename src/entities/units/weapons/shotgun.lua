-- Shotgun Weapon
--

local Weapon  = require 'src.entities.units.weapons.weapon'
local Shotgun = Weapon:extend()

function Shotgun:new(host)
	self.sprite = Animator()
	self.sprite:addAnimation('default', {
		image  = Config.image.spritesheet.effect.shotgun,
		width  = 60,
		height = 8,
		total  = 1,
		fps    = 50,
		frames = { { 1, 1, 17, 1 } },
		after  = function() self.blast = false end
	})

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

			-- play sound
			Config.audio.weapon.shotgun:play()
			Config.audio.weapon.shotgun:seek(0)
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
		ty = ty + ty * 0.05
	end

	-- line up with host entity shot
	self.blast = Vec2(tx, ty)

	-- New Projectile
	Sensors['projectile'](self, { x = tx, y = ty, angle = angle })
	Sensors['projectile'](self, { x = tx, y = ty, angle = angle - _.__pi/16 })
	Sensors['projectile'](self, { x = tx, y = ty, angle = angle + _.__pi/16 })
	Sensors['projectile'](self, { x = tx, y = ty, angle = angle - _.__pi/14 })
	Sensors['projectile'](self, { x = tx, y = ty, angle = angle + _.__pi/14 })
	Sensors['projectile'](self, { x = tx, y = ty, angle = angle - _.__pi/12 })
	Sensors['projectile'](self, { x = tx, y = ty, angle = angle + _.__pi/12 })
end

-- Draw shotgun blast
--
function Shotgun:draw()
	Weapon.draw(self)
	--
	if self.blast then
		local tx, ty  = self.blast:unpack()
		local w, h    = self.sprite:dimensions()
		local angle   = self.host.aimAngle
		local sx, sy  = 1, 1

		lg.push()
		lg.translate(tx, ty)
		lg.rotate(angle)

		lg.setColor(1,1,1,0.25)

		-- adjust arm angle for shooting animation
		if self.host.isMirrored then
			self.sprite:draw(0, 0, angle, -1, 1)
			self.sprite:draw(0, 0, angle - _.__pi/16, -1, 1)
			self.sprite:draw(0, 0, angle + _.__pi/16, -1, 1)
			self.sprite:draw(0, 0, angle - _.__pi/14, -0.75, 0.75)
			self.sprite:draw(0, 0, angle + _.__pi/14, -0.75, 0.75)
			self.sprite:draw(0, 0, angle - _.__pi/12, -0.5, 0.5)
			self.sprite:draw(0, 0, angle + _.__pi/12, -0.5, 0.5)
		else
			self.sprite:draw(0, 0, angle)
			self.sprite:draw(0, 0, angle - _.__pi/16)
			self.sprite:draw(0, 0, angle + _.__pi/16)
			self.sprite:draw(0, 0, angle - _.__pi/14, 0.75, 0.75)
			self.sprite:draw(0, 0, angle + _.__pi/14, 0.75, 0.75)
			self.sprite:draw(0, 0, angle - _.__pi/12, 0.5, 0.5)
			self.sprite:draw(0, 0, angle + _.__pi/12, 0.5, 0.5)
		end

		lg.pop()

	end
end

return Shotgun