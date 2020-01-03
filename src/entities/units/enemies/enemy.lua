-- Enemy Unit
-- 

local Unit  = require 'src.entities.units.unit'
local Enemy = Unit:extend()

function Enemy:new(data)
	Unit.new(self, _:merge(data, {
		name = data.name or 'Enemy'
	}))
	--
	-- AI
	self.sight  = Sensors['sight'](self, { 'Player' })
	self.timer  = Timer.new()
end

-- Clear timer
--
function Enemy:destroy()
	self.timer:clear()
	--
	Unit.destroy(self)
end

-- In Focus Event
-- Handle when entity comes into focus
--
function Enemy:inFocus(other)
	-- print('inFocus', other.name)
	self.target = other
end

-- Out of Focus Event
-- Handle when entity goes out of focus
--
function Enemy:outOfFocus(other)
	-- print('outOfFocus', other.name)
	-- forget target..
	self.timer:after(3, function() self.target = false end)
end

-- Handle entity entering sight range
--
function Enemy:inRange(other, col)
	-- print('inRange', other.name)
end

-- Handle entity exiting sight range
--
function Enemy:outOfRange(other, col)
	-- print('outOfRange', other.name)
end

-- Update enemy entity
--
function Enemy:update(dt)
	self.timer:update(dt)
	--
	Unit.update(self, dt)
end

return Enemy