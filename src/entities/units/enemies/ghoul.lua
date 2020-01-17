-- Ghoul Enemy Unit
-- 

local Enemy = require 'src.entities.units.enemies.enemy'
local Ghoul = Enemy:extend()

function Ghoul:new(data)
	Enemy.new(self, _:merge(data,
		Config.world.enemies['Ghoul']
	))
	--
	-- hitbox
	local w, h = self:dimensions()

	self.hitbox = Sensors['hitbox'](self)
	self.hitbox:setShape(Shapes['circle'](h*0.7))

	--
	self:patrol()
end

-- Patrol Action
-- Sensor:  Detect Player
-- InFocus: Interrupted to attack target
-- Audio:   None
--
function Ghoul:patrol()
	-- Detect Player
	-- InFocus: Interrupt to perform attack
	self.sightSensor = Sensors['sight'](self, { 'Player' })
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

-- Strike attack
--
function Ghoul:attack(other)
	local cx, cy   = self:getPosition()
	local tx, ty   = other:getPosition()
	local distance = Vec2(cx, cy):distance(Vec2(tx, ty))

	if distance < self._attack.distance then
		self:runningAttack(other, distance)
	else
		self:jumpingAttack(other, distance)
	end
end

-- Running attack
--
function Ghoul:runningAttack(other, distance)
	local cx, cy = self:getPosition()
	local tx, ty = other:getPosition()

	self.running    = true
	self.isMirrored = tx < cx
	--
	-- Detect Player
	-- InFocus: Interrupted to strike target
	self.sightSensor = Sensors['sight'](self, { 'Player' }, _.__pi / 2)
	self.sightSensor:setShape(Shapes['circle'](distance / 2))
	self.sightSensor:setInFocus(function(other)
		self:interrupt():strike(other)
	end)
end

-- Jumping attack
--
function Ghoul:jumpingAttack(other, distance)
	local cx, cy = self:getPosition()
	local tx, ty = other:getPosition()

	self.jumping    = true
	self.isMirrored = tx < cx

	-- jump!
	if self.isMirrored then
		self:setLinearVelocity(-distance, -600)
	else
		self:setLinearVelocity( distance, -600)
	end
	
	-- attack in air
	self.handle = self.timer:after(1, function()
		self:interrupt():strike(other)
	end)
end

-- Strike attack
--
function Ghoul:strike(other)
	self.attacking    = true
	self.running      = true
	self.strikeSensor = Sensors['strike'](self)

	-- unrest
	self.handle = self.timer:after(2, function()
		self:interrupt():patrol()
	end)

	--
	Config.audio.enemy.ghoul.attack:play()
end

return Ghoul