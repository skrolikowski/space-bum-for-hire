-- Executioner Enemy Unit
-- 

local Enemy       = require 'src.entities.units.enemies.enemy'
local Executioner = Enemy:extend()

function Executioner:new(data)
	Enemy.new(self, _:merge(data,
		Config.world.enemies['Executioner']
	))
	--
	-- hitbox
	local w, h = self:dimensions()

	self.hitbox = Sensors['hitbox'](self)
	self.hitbox:setShape(Shapes['circle'](0, h/2, w/2))
end

-- Bored action
--
function Executioner:bored()
	self:interrupt():patrol(self.isMirrored and 'right' or 'left', 3)
	--
	Config.audio.enemy.executioner.bored:play()
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

-- Strike attack
--
function Executioner:attack()
	self.attacking    = true
	self.strikeSensor = Sensors['strike'](self)
	--
	Config.audio.enemy.executioner.attack:play()
end

return Executioner