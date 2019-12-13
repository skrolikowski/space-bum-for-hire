-- Pistol Weapon
--

local Weapon = require 'src.entities.weapons.weapon'
local Pistol = Weapon:extend()

function Pistol:new(host)
	Weapon.new(self, 'pistol', host)

	-- properties
	self.fireRate = { now = 0, max = 0.25 }
	self.round    = WeaponRounds['pistol']
	self.rounds   = Config.world.player.rounds.pistol
end

-- Trigger weapon
--
function Pistol:trigger(dt, et)
	if self.fireRate.now == 0 then
		self:fire()
		self.firing = true
		--
		self.rounds       = self.rounds - 1
		self.fireRate.now = self.fireRate.max
		--
		Config.world.player.rounds.pistol = self.rounds
	end
	--
	Weapon.trigger(self, dt, et)
end

-- Fire!
--
function Pistol:fire()
	local cx, cy  = self.host:getPosition()
	local w, h    = self.host.width, self.host.height
	local vx, vy  = self.host:getLinearVelocity()
	local sx, sy  = self.host.sx, self.host.sy
	local heading = self.host.heading.y
	local angle

	if heading == 'N' then
	-- Aiming Up
		angle = -_.__pi / 7
	elseif heading == 'S' then
	-- Aiming Down
		angle =  _.__pi / 5
	else
	-- Aiming Forward
		angle = 0
	end

	if self.host.isMirrored then sx = -sx end
	if self.host.isFlipped  then sy = -sy end

	local nx = cx       + _.__cos(angle) * (w / 2)
	local ny = cy - h/4 + _.__sin(angle) * (w / 2)

	table.insert(self.children, self.round(self, nx, ny, angle, sx, sy))
	--
	-- TODO: 
	-- Damage -> _World:querySegment()
end

return Pistol