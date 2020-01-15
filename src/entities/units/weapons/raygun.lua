-- Raygun Weapon
--

local Weapon = require 'src.entities.units.weapons.weapon'
local Raygun = Weapon:extend()

function Raygun:new(host)
	self.sprite = Animator()
	self.sprite:addAnimation('default', {
		image  = Config.image.spritesheet.effect.laser,
		width  = 129,
		height = 38,
		total  = 1,
		fps    = 25,
		frames = { { 1, 1, 15, 1 } },
		after  = function() self.blast = false end
	})

	-- weapon scaling
	self.sx = 0.85
	self.sy = 0.85
	--
	Weapon.new(self, 'raygun', host)
end

-- Trigger weapon
--
function Raygun:trigger(dt, et)
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
			Config.audio.weapon.raygun:play()
			Config.audio.weapon.raygun:seek(0)
		else
			-- dry fire
			Config.audio.weapon.dryfire:play()
		end
	end
end

-- Raygun shot
--
function Raygun:fire()
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

	-- line up with host entity shot
	self.blast = Vec2(tx, ty)

	-- New Projectile
	Sensors['projectile'](self, { x = tx, y = ty })
end

-- Draw shotgun blast
--
function Raygun:draw()
	Weapon.draw(self)
	--
	if self.blast then
		local tx, ty = self.blast:unpack()
		local w, h   = self.weaponSprite:getDimensions()
		local angle  = self.host.aimAngle
		local sx, sy = 1, 1

		if self.host.isMirrored then
			sx    = -sx
			angle = angle + _.__pi
		end

		lg.setColor(Config.color.white)
		self.sprite:draw(tx, ty, angle, sx, sy, 0, 20)
	end
end

return Raygun