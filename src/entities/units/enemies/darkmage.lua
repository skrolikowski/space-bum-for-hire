-- DarkMage Enemy Unit
-- 

local Enemy    = require 'src.entities.units.enemies.enemy'
local DarkMage = Enemy:extend()

function DarkMage:new(data)
	Enemy.new(self, _:merge(data,
		Config.world.enemy['DarkMage']
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
function DarkMage:patrol()
	-- Detect Player
	-- InFocus: Interrupt to perform attack
	self.sightSensor = Sensors['sight'](self, { 'Player' }, self._sight.periphery)
	self.sightSensor:setShape(Shapes['circle'](self._sight.distance))
	self.sightSensor:setInFocus(function(other)
		self:interrupt():attack(other)
	end)

	-- turn
	self.isMirrored = not self.isMirrored

	-- unrest
	self.handle = self.timer:after(self._timing.unrest, function()
		self:interrupt():patrol()
	end)
end

-- Attack Action
--
function DarkMage:attack(other)
	-- repeat fire until player out of sight
	self.handle = self.timer:every(self._timing.cooldown, function()
		self:projectile(other)
	end)

	-- unrest
	self.timer:after(self._timing.cooldown * 3, function()
		self:interrupt():patrol()
	end)
end


-- Projectile attack
--
function DarkMage:projectile(other)
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
		x       = tx,
		y       = ty,
		impulse = Vec2(0, 0):polar(angle, speed),
	})
	--
	Config.audio.enemy.darkmage.attack:play()
end

return DarkMage