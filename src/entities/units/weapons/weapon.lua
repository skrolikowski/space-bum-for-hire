-- Entity Weapon
-- Shane Krolikowski
--

local Modern = require 'modern'
local Weapon = Modern:extend()

-- New weapon
--
function Weapon:new(name, host)
	self.name  = name
	self.host  = host
	self.blast = Vec2(0, 0)
	self.timer = Timer.new()

	-- sprite scaling
	self.sx = 1
	self.sy = 1

	-- flags
	self.firing  = false
	self.isReady = true
end

-- Destroy weapon (...not really)
--
function Weapon:destroy()
	self.timer:clear()
end

-- Get aiming angle of Unit Entity
-- TODO: re-factor
--
function Weapon:updateAimAngle()
	local isMirrored = self.host.isMirrored
	local isLocked   = self.host.locking
	local ax, ay     = self.host.axis:unpack()
	local angle

	-- can only aim downward if locked in position
	--
	if not isLocked then
		ay = _.__min(0, ay)
	end

	angle = Vec2(ax, ay):normalize():heading()

	-- adjust aiming angle
	--
	if angle == 0 and isMirrored then
		angle = _.__pi
	end


	self.angle = angle
end

function Weapon:fire()
	local w, h = self.host:dimensions()

	-- line up with host entity shot
	self.blast = Vec2(0, -h/5):polar(self.angle, w)

	-- New Projectile
	local wx, wy  = self.host.body:getWorldPoints(self.blast:unpack())
	local impulse = self.blast:polar(self.angle, self.speed)

	Sensors['projectile'](self, wx, wy, impulse, self.damage)
end

-- Trigger weapon
--
function Weapon:trigger(dt, et)
	self.host.shooting = true
end

-- Holster weapon
--
function Weapon:holster()
	self.host.shooting = false
end

-- Update weapon
--
function Weapon:update(dt)
	self:updateAimAngle()
	--
	self.timer:update(dt)
	self.sprite:update(dt)
end

-- Draw weapon
--
function Weapon:draw()
	-- draw weapon blast
	if self.firing then
		local cx, cy = self.host.body:getWorldPoints(self.blast:unpack())
		local sx, sy = self.sx, self.sy

		lg.setColor(Config.color.white)
		self.sprite:draw(cx, cy, self.angle, sx, sy)
	end

	-- draw player arm
	-- TODO: re-factor
	if self.host.shooting then
		local image  = Config.image.sprites.playerAim
		local cx, cy = self.host:getPosition()
		local w, h   = image:getDimensions()
		local angle  = self.angle
		local sx, sy = 1, 1

		-- adjust arm angle for shooting animation
		if self.host.isMirrored then
			sx    = -sx
			angle = angle + _.__pi
		end

		-- adjust arm placement for crouch animation
		--
		if self.host.behavior.name == 'Player_crouch' then
			h = -h/4
		end

		lg.setColor(Config.color.white)
		lg.draw(image, cx, cy-h, angle, sx, sy)
	end
end

return Weapon