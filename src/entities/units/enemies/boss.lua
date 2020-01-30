-- Boss Enemy Unit
-- 

local Enemy = require 'src.entities.units.enemies.enemy'
local Boss  = Enemy:extend()

function Boss:new(data)
	Enemy.new(self, _:merge(data,
		Config.world.enemy['Boss']
	))
	--
	-- hitbox
	local w, h = self:dimensions()

	self.hitbox = Sensors['hitbox'](self)
	self.hitbox:setShape(Shapes['rectangle'](-w*0.1,h*0.25,w*0.4,h))

	--
	self:patrol()
end

-- Patrol Action
-- Sensor:  Detect Player
-- InFocus: Interrupted to attack target
-- Audio:   None
--
function Boss:patrol()
	-- Detect Player
	-- InFocus: Interrupt to perform attack
	self.sightSensor = Sensors['sight'](self, { 'Player' }, self._sight.periphery)
	self.sightSensor:setShape(Shapes['circle'](self._sight.distance))
	self.sightSensor:setInFocus(function(other)
		self:interrupt():attack(other)
	end)
end

-- Attack Action
--
function Boss:attack(other)
	if not other then
	-- Target is dead
		self:interrupt():patrol()
	end

	-- repeat fire until player out of sight
	self.handle = self.timer:every(self._timing.cooldown, function()
		if not other:isDestroyed() then
			self:projectile(other)
		end
	end)

	-- unrest
	self.timer:after(2, function()
		self:interrupt():patrol()
	end)
end


-- Projectile attack
--
function Boss:projectile(other)
	local cx, cy = self:getPosition()
	local ox, oy = other:getPosition()
	local w, h   = self:dimensions()
	local angle  = Vec2(cx, cy):headingTo(Vec2(ox, oy))
	local speed  = self._attack.speed

	-- blast coordinates
	local bx, by = Vec2():polar(angle, w):unpack()
	local tx, ty = self.body:getWorldPoints(bx, by)

	-- set attacking (self-disabling)
	self.attacking = true

	-- New Fireball
	Sensors['fireball'](self, {
		x  = tx,
		y  = ty,
		sx = 2,
		sy = 2,
		impulse = Vec2(0, 0):polar(angle, speed),
	})
	--
	Config.audio.enemy.boss.attack:play()
end

-- Death on contact
--
function Boss:beginContact(other, col)
	if col:isTouching() then
		if other.name == 'HitBox' and other.host then
			if not self.dying then
				other.host:die()
			end
		end
	end
end

return Boss