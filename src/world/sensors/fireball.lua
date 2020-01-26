-- Weapon Fireball
-- Ignores gravity, given initial impulse, invokes damage
--

local Modern   = require 'modern'
local Fireball = Modern:extend()

-- New Fireball
-- Host is firing weapon
--
function Fireball:new(host, data)
	self.name     = 'Fireball'
	self.uuid     = Util:uuid()
	self.affects  = Util:toBoolean({ 'Environment', 'HitBox' })
	self.category = 'Fireball'
	self.host     = host
	self.radius   = host._attack.radius or 5
	self.damage   = host._attack.damage or 0

	-- scaling
	self.sx = data.sx or 1.5
	self.sy = data.sy or 1.5

	if _:isTable(self.damage) then
		self.damage = _.__random(self.damage.min, self.damage.max)
	end

	-- flags
	self.isMirrored = not host.isMirrored

	-- lifetime
	self.timer = Timer.new()
	self.timer:every(0.1, function() self:decay() end)

	-- body
	self.body  = lp.newBody(Gamestate:current():getWorld(), data.x, data.y, 'dynamic')
	self.body:setGravityScale(0)
	self.body:applyLinearImpulse(data.impulse:unpack())

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

	-- animation
	self.sprite = Animator()
	self.sprite:addAnimation('default', {
		image  = Config.image.spritesheet.effect.necro_proj,
		width  = 34,
		height = 9,
		frames = { { 1, 1, 1, 3 } },
	})
end

-- Decay damage for specified amount
--
function Fireball:decay()
	self.damage = self.damage - (self.host._attack.decay or 1)

	-- destroy
	if self.damage <= 0 then
		self:destroy()
	end
end

-- Update
--
function Fireball:update(dt)
	self.timer:update(dt)
	self.sprite:update(dt)
end

-- Flag for removal
--
function Fireball:destroy()
	self.timer:clear()
	--
	self.remove = true
	self.body:destroy()
end

-- Check for collisions
--
function Fireball:beginContact(other, col)
	if col:isTouching() then
		if self.affects[other.name] or self.affects[other.category] then
			if Gamestate:current().player then
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
			end
			--
			self:destroy()
		end
	end
end

-- Check for separations
--
function Fireball:endContact(other, col)
	--
end

-- Draw Fireball
--
function Fireball:draw()
	lg.setColor(Config.color.sensor.projectile)
	self.shape:draw()
	--
	local cx, cy = self.body:getPosition()
	local w, h   = self.sprite:dimensions()
	local sx, sy = (self.sx or 1), (self.sy or 1)
	local angle  = self.angle
	local ox     = w/2 + (self.ox or 0)
	local oy     = h/2 + (self.oy or 0)

	if self.isMirrored then sx = -sx end
	if self.isFlipped  then sy = -sy end

	lg.setColor(Config.color.white)
	self.sprite:draw(cx, cy, angle, sx, sy, w/4, h/2)
end

return Fireball