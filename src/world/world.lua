-- World
-- Shane Krolikowski
--

local Modern = require 'modern'
local World  = Modern:extend()

-- Create new world
--
function World:new()
	lp.setMeter(Config.world.meter)

	self.world = love.physics.newWorld(
		Config.world.gravity.x,
		Config.world.gravity.y * Config.world.meter,
		true
	)
	self.width  = Config.width
	self.height = Config.height

	self:bootstrap()
end

-- Set up world
--
function World:bootstrap()
	-- register collision callbacks
	self.world:setCallbacks(
		function(a, b, col) self:beginContact(a, b, col) end,
		function(a, b, col) self:endContact(a, b, col)   end,
		function(a, b, col) self:preSolve(a, b, col)     end,
		function(a, b, col, norm, tang) self:postSolve(a, b, col, norm, tang) end
	)
end

-- Destroy world
--
function World:destroy()
	self.world:destroy()
end

-- World dimensions
--
function World:dimensions()
	return self.width, self.height
end

-- World bounds
--
function World:bounds()
	return AABB(0, 0, self:dimensions())
end

-- Query - point
--
function World:queryPoint(x, y, callback)
	if callback then
		self.world:queryBoundingBox(x, y, x, y, callback)
	else
		return self.world:fetchInBounds(AABB(x, y, x, y))
	end
end

-- Query - rect
--
function World:queryRect(x, y, w, h, callback)
	if callback then
		self.world:queryBoundingBox(x, y, x+w, y+h, callback)
	else
		return self.world:fetchInBounds(AABB(x, y, x+w, y+h))
	end
end

-- Query - entire screen
--
function World:queryScreen(callback)
	local cx, cy = _Camera.x, _Camera.y
	local left   = cx - Config.width / 2
	local top    = cy - Config.height / 2
	local right  = cx + Config.width / 2
	local bottom = cy + Config.height / 2

	if callback then
		self.world:queryBoundingBox(left, top, right, bottom, callback)
	else
		return self.world:fetchInBounds(left, top, right, bottom)
	end
end

-- Query - entire world
--
function World:queryWorld(callback)
	if callback then
		self.world:queryBoundingBox(0, 0, self.width, self.height, callback)
	else
		return self.world:fetchInBounds(0, 0, self.width, self.height)
	end
end

-- Query - line segment
--
function World:querySegment(x1, y1, x2, y2, callback)
	if callback then
		self.world:rayCast(x1, y1, x2, y2, callback)
	else
		return self:fetchOnLine(x1, y1, x2, y2)
	end
end

-- Fetch fixtures in bounds
--
function World:fetchInBounds(left, top, right, bottom)
	local fixtures = {}

	self.world:queryBoundingBox(left, top, right, bottom,
		function(fixture)
			table.insert(fixtures, fixture)

			return true
		end)

		return fixtures
end

-- Fetch fixtures in bounds
--
function World:fetchOnLine(x1, y1, x2, y2)
	local fixtures = {}

	self.world:rayCast(x1, y1, x2, y2,
		function(fixture)
			table.insert(fixtures, fixture)

			return true
		end)

		return fixtures
end

-- Fetch an Entity
--
function World:fetchEntityById(id)
	local bodies = self.world:getBodies()
	local fixture, entity

	for __, body in pairs(bodies) do
		fixture = body:getFixtures()[1]
		entity  = fixture:getUserData()

		if entity.id and entity.id == id then
			return entity
		end
	end

	return false
end

-- Event - handle onClick (mouse)
--
function World:onClick(x, y, button)
	--
end

-- Event - handle onHover (mouse)
--
function World:onHover(x, y)
	self.world:queryPoint(x, y, function()
		
	end)
end

-- Event - Fixtures begin to overlap
--
function World:beginContact(fix1, fix2, col)
	fix1:getUserData():beginContact(fix2:getUserData(), col)
	fix2:getUserData():beginContact(fix1:getUserData(), col)
end

-- Event - Fixtures cease to overlap
--
function World:endContact(fix1, fix2, col)
	fix1:getUserData():endContact(fix2:getUserData(), col)
	fix2:getUserData():endContact(fix1:getUserData(), col)
end

-- Event - Before collision resolution
--
function World:preSolve(fix1, fix2, col)
	fix1:getUserData():preSolve(fix2:getUserData(), col)
	fix2:getUserData():preSolve(fix1:getUserData(), col)
end

-- Event - Collision has been resolved
--
function World:postSolve(fix1, fix2, col, norm, tang)
	fix1:getUserData():postSolve(fix2:getUserData(), col, norm, tang)
	fix2:getUserData():postSolve(fix1:getUserData(), col, norm, tang)
end

-- Update world and it's entities
--
function World:update(dt)
	self.world:update(dt)

	self:queryWorld(
		function(fix)
			fix:getUserData():update(dt)
			return true
		end
	)
end

-- Draw all world entities
--
function World:draw()
	self:queryScreen(
		function(fix)
			fix:getUserData():draw()
			return true
		end
	)
end

return World