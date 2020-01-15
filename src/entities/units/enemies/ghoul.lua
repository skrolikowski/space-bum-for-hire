-- Ghoul Enemy Unit
-- 

local Enemy = require 'src.entities.units.enemies.enemy'
local Ghoul = Enemy:extend()

function Ghoul:new(data)
	Enemy.new(self, _:merge(data,
		Config.world.enemies['Ghoul']
	))
	--
end

-- Bored action
--
function Ghoul:bored()
	self:interrupt():patrol(self.isMirrored and 'right' or 'left')
	--
	Config.audio.enemy.ghoul.bored:play()
end

-- Die action
--
function Ghoul:die()
	self:interrupt()
	self.dying = true
	--
	self.timer:after(2, function()
		self:destroy()
	end)
	--
	Config.audio.enemy.ghoul.die:play()
end

-- Interrupt current action
--
function Ghoul:interrupt()
	self:resetFlags()
	self.target = nil
	--
	if self.handle then
		self.timer:cancel(self.handle)
	end
	--
	if self.sightSensor then
		self.sightSensor:destroy()
	end

	return self
end

-- Patrol
--
function Ghoul:patrol(direction, delay)
	self.isMirrored = direction == 'left' or false
	--
	self.sightSensor = Sensors['sight'](self, { 'Player' }, self._sight.periphery)
	self.sightSensor:setShape(Shapes['circle'](self._sight.distance))
	self.sightSensor:setInFocus(function(other)
		print('spotted!')
		-- self:interrupt():hunt(other)
	end)
end

-- Hunt
--
function Ghoul:hunt(other)
	local hx, hy = self:getPosition()
	local tx, ty = other:getPosition()

	self.target     = other
	self.running    = true
	self.isMirrored = tx < hx
	--
	-- attack if target in range
	self.sightSensor = Sensors['sight'](self, { 'Player' }, self._sight.periphery)
	self.sightSensor:setShape(Shapes['circle'](self._attack.distance))
	self.sightSensor:setInFocus(function(other)
		self:interrupt():strike()
	end)
	-- give up after delay
	self.handle = self.timer:after(self._attack.forget, function()
		self.target  = nil
		self.running = false
	end)
	--
	Config.audio.enemy.ghoul.hunt:play()
end

-- Strike attack
--
function Ghoul:strike()
	self.attacking    = true
	self.strikeSensor = Sensors['strike'](self)
	--
	Config.audio.enemy.ghoul.attack:play()
end

return Ghoul