-- Weapon Projectile
-- Ignores gravity, given initial impulse, invokes damage
--

local Modern     = require 'modern'
local Projectile = Modern:extend()

-- New Projectile
-- Host is firing weapon
--
function Projectile:new(host, data)
	self.name     = 'Projectile'
	self.uuid     = Util:uuid()
	self.affects  = Util:toBoolean({ 'Environment', 'HitBox' })
	self.category = 'Projectile'
	self.host     = host
	self.radius   = host.weapon.radius or 1
	self.damage   = host.weapon.damage or 0

	if _:isTable(self.damage) then
		self.damage = _.__random(self.damage.min, self.damage.max)
	end

	-- -- lifetime
	self.timer = Timer.new()
	self.timer:every(0.1, function() self:decay() end)

	-- calculate impulse
	local angle = data.angle or host.host.aimAngle
	local mag   = host.weapon.speed
	local impulse = Vec2(0, 0):polar(angle, mag)

	-- body
	self.body  = lp.newBody(_World.world, data.x, data.y, 'dynamic')
	self.body:setGravityScale(0)
	self.body:applyLinearImpulse(impulse:unpack())

	-- shape
	self.shape = Shapes['circle'](self.radius)
	self.shape:setBody(self.body)

	-- fixture
	self.fixture = lp.newFixture(self.body, self.shape.shape, 1)
	self.fixture:setGroupIndex(Config.world.filter.group.sensor)
	self.fixture:setCategory(Config.world.filter.category.sensor)
	self.fixture:setMask(unpack(Config.world.filter.mask.sensor))
	self.fixture:setUserData(self)
	self.fixture:setSensor(true)
end

-- Decay damage for specified amount
--
function Projectile:decay()
	self.damage = self.damage - (self.host.weapon.decay or 1)

	-- destroy
	if self.damage <= 0 then
		self:destroy()
	end
end

-- Update
--
function Projectile:update(dt)
	self.timer:update(dt)
end

-- Flag for removal
--
function Projectile:destroy()
	self.timer:clear()
	--
	self.remove = true
	self.body:destroy()
end

-- Check for collisions
--
function Projectile:beginContact(other, col)
	if col:isTouching() then
		if self.affects[other.name] or self.affects[other.category] then
			local cx, cy   = self.body:getPosition()
			local px, py   = Gamestate:current().player:getPosition()
			local distance = Vec2(cx, cy):distance(Vec2(px, py))
			local volume   = _.__max(0, 1 - distance / Config.width)
			local clip

			if other.name == 'Environment' then
			-- Impact w/ Environment
				clip = _.__random(#Config.audio.weapon.impact)

				Config.audio.weapon.impact[clip]:setVolume(volume)
				Config.audio.weapon.impact[clip]:play()
				Config.audio.weapon.impact[clip]:seek(0)
			elseif other.name == 'HitBox' then
			-- Impact w/ Unit
				clip = _.__random(#Config.audio.weapon.pierce)

				Config.audio.weapon.pierce[clip]:setVolume(volume)
				Config.audio.weapon.pierce[clip]:play()
				Config.audio.weapon.pierce[clip]:seek(0)
			end
			--
			self:destroy()
		end
	end
end

-- Check for separations
--
function Projectile:endContact(other, col)
	--
end

-- Draw Projectile
--
function Projectile:draw()
	lg.setColor(Config.color.sensor.projectile)
	self.shape:draw()
end

return Projectile