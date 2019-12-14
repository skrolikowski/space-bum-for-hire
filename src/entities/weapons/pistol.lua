-- PistolWeapon Weapon
--

local Weapon       = require 'src.entities.weapons.weapon'
local PistolWeapon = Weapon:extend()

function PistolWeapon:new(host)
	Weapon.new(self, 'pistol-weapon', host)

	-- properties
	self.fireRate = { now = 0, max = 0.25 }
	self.round    = WeaponRounds['pistol']
	self.rounds   = Config.world.player.rounds.pistol
end

-- Trigger weapon
--
function PistolWeapon:trigger(dt, et)
	if self.fireRate.now == 0 then
		self:fire()
		self.firing = true
		--
		self.rounds       = self.rounds - 1
		self.fireRate.now = self.fireRate.max
		-- update global
		Config.world.player.rounds.pistol = self.rounds
		-- play sound
		Config.audio.round.pistol:play()
	end
	--
	Weapon.trigger(self, dt, et)
end

-- Fire!
--
function PistolWeapon:fire()
	local cx, cy = self.host:getPosition()
	local vx, vy = self.host:getLinearVelocity()
	local w, h   = self.host.width, self.host.height
	local ax, ay = self.host.axis:unpack()

	if self.host.isMirrored then
		ax   = -ax
	end

	-- round position & angle
	local angle = Vec2(ax, ay):heading()
	self.nx    = cx         + _.__cos(angle) * (w / 2) + (vx * 0.1)
	self.ny    = cy - h / 4 + _.__sin(angle) * (w / 2) + (vy * 0.1)

	table.insert(self.children, self.round(self, self.nx, self.ny, angle))
end

return PistolWeapon