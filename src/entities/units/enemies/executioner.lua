-- Executioner Enemy Unit
-- 

local Enemy       = require 'src.entities.units.enemies.enemy'
local Executioner = Enemy:extend()

function Executioner:new(data)
	Enemy.new(self, _:merge(data,
		Config.world.enemies['Executioner']
	))
	--
end

-- Bored action
--
function Executioner:bored()
	self:interrupt():patrol(self.isMirrored and 'right' or 'left', 3)
	--
	Config.audio.enemy.executioner.bored:play()
end

-- Die action
--
function Executioner:die()
	self:interrupt()
	self.dying = true
	--
	-- self.timer:after(3, function()
	-- 	self:destroy()
	-- end)
	--
	Config.audio.enemy.executioner.die:play()
end

-- Interrupt current action
--
function Executioner:interrupt()
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
function Executioner:patrol(direction, delay)
	self.running    = true
	self.isMirrored = direction == 'left' or false
	--
	self.sightSensor = Sensors['sight'](self, { 'Player' }, self._sight.periphery)
	self.sightSensor:setShape(Shapes['circle'](self._sight.distance))
	self.sightSensor:setInFocus(function(other)
		self:interrupt():hunt(other)
	end)
	--
	self.handle = self.timer:every(delay, function()
		self.running = false
	end)
end

-- Hunt
--
function Executioner:hunt(other)
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
	Config.audio.enemy.executioner.hunt:play()
end

-- Strike attack
--
function Executioner:strike()
	self.attacking    = true
	self.strikeSensor = Sensors['strike'](self)
	--
	Config.audio.enemy.executioner.attack:play()
end

return Executioner