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
end

-- Bored action
-- Start patrol w/ sound
--
function Ghoul:bored()
	self:interrupt():patrol(self.isMirrored and 'right' or 'left')
	--
	-- Config.audio.enemy.ghoul.bored:play()
end

-- Enemy Patrol
-- Choose direction to patrol for `delay`.
-- If target found, interrupt to Hunt.
--
function Ghoul:patrol(direction, delay)
	self.isMirrored = direction == 'left' or false
	--
	self.sightSensor = Sensors['sight'](self, { 'Player' })
	self.sightSensor:setShape(Shapes['circle'](self._sight.distance))
	self.sightSensor:setInFocus(function(other)
		self:interrupt():attack(other)
	end)
end

-- Strike attack
--
function Ghoul:attack(other)
	local cx, cy = self:getPosition()
	local tx, ty = other:getPosition()
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

	self.sightSensor = Sensors['sight'](self, { 'Player' }, _.__pi / 2)
	self.sightSensor:setShape(Shapes['circle'](75))
	self.sightSensor:setInFocus(function(other)
		self.timer:script(function(wait)
			self.attacking    = true
			self.strikeSensor = Sensors['strike'](self)
			wait(0.5)
			self.running = true
		end)
		--
		Config.audio.enemy.ghoul.attack:play()
	end)
end

-- Jumping attack
--
function Ghoul:jumpingAttack(other, distance)
	local cx, cy = self:getPosition()
	local tx, ty = other:getPosition()

	self.jumping   = true
	self.isMirrored = tx < cx

	-- jump!
	if self.isMirrored then
		self:setLinearVelocity(-distance, -600)
	else
		self:setLinearVelocity( distance, -600)
	end
	
	-- attack in air
	self.handle = self.timer:after(1, function()
		self.timer:script(function(wait)
			self.attacking    = true
			self.strikeSensor = Sensors['strike'](self)
			wait(0.5)
			self.running = true
		end)
		--
		Config.audio.enemy.ghoul.attack:play()
	end)
end

return Ghoul