-- Executioner Enemy Unit
-- 

local Enemy       = require 'src.entities.units.enemies.enemy'
local Executioner = Enemy:extend()

-- New executioner
--
function Executioner:new(data)
	Enemy.new(self, _:merge(data,
		Config.world.enemies['Executioner']
	))
	--
	-- hitbox
	local w, h = self:dimensions()

	self.hitbox = Sensors['hitbox'](self)
	self.hitbox:setShape(Shapes['circle'](0, h/4, w/2))

	--
	-- self:patrol()
end

-- Patrol Action
-- -----------
-- Sensor:  Detect Player
-- InFocus: Interrupted to hunt target
-- Audio:   None
--
function Executioner:patrol()
	self.running = true
	--
	-- Detect Player
	-- InFocus: Interrupt to hunt target
	self.sightSensor = Sensors['sight'](self, { 'Player' }, self._sight.periphery)
	self.sightSensor:setShape(Shapes['circle'](self._sight.distance))
	self.sightSensor:setInFocus(function(other)
		self:interrupt():hunt(other)
	end)

	-- turn
	self.isMirrored = not self.isMirrored

	-- unrest
	self.handle = self.timer:after(self._timing.unrest, function()
		self:interrupt():patrol()
	end)
end

-- Hunt Action
-- -----------
-- Sensor:  Detect Player
-- InFocus: Interrupted to strike target
-- Audio:   Hunt
--
function Executioner:hunt(other)
	local cx, cy   = self:getPosition()
	local tx, ty   = other:getPosition()
	local distance = Vec2(cx, cy):distance(Vec2(tx, ty))

	self.running    = true
	self.isMirrored = tx < cx
	--
	-- attack if target in range
	self.sightSensor = Sensors['sight'](self, { 'Player' },  _.__pi / 2)
	self.sightSensor:setShape(Shapes['circle'](distance / 2))
	self.sightSensor:setInFocus(function(other)
		self:interrupt():strike(other)
	end)

	-- unrest
	self.handle = self.timer:after(3, function()
		self:interrupt():patrol()
	end)
	--
	Config.audio.enemy.executioner.hunt:setVolume(0.5)
	Config.audio.enemy.executioner.hunt:play()
end

-- Strike Action
-- -----------
-- Sensor:  Strike
-- Audio:   Attack
--
function Executioner:strike()
	self.attacking    = true
	self.running      = true
	self.strikeSensor = Sensors['strike'](self)

	-- unrest
	self.handle = self.timer:after(2, function()
		self:interrupt():patrol()
	end)

	--
	Config.audio.enemy.executioner.attack:play()
end

return Executioner