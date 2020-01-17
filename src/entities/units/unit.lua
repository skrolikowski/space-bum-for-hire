-- Unit Entity
--

local Entity = require 'src.entities.entity'
local Unit   = Entity:extend()


function Unit:new(data)
	Entity.new(self, _:merge(data, {
		-- @overrides
		x        = data.x + data.width / 2,
		y        = data.y + data.height / 2,
		category = 'Unit',
		density  = 25,
		bodyType = 'dynamic',
	}))

	-- properties
	self.title      = data.title or 'Unit'
	self.speed      = data.speed  or 500
	self.health     = data.health or 100
	self.initHealth = self.health
	self.jumpHeight = data.jumpHeight or 4500

	-- variants
	if _:isTable(self.health) then
		self.health     = _.__random(self.health.min, self.health.max)
		self.initHealth = self.health
	end
	
	-- flags
	self.isMirrored = false
	self.isFlipped  = false
	self.onGround   = false
	self.onWall     = false
	self.canDestroy = data.canDestroy or true

	-- AI
	self.timer = Timer.new()

	-- physics
	self.walls   = {}
	self.grounds = {}
	self:fixedRotation(true)
	self:setSleepingAllowed(false)
end

-- Tear down
--
function Unit:destroy()
	self.timer:clear()
	--
	Entity.destroy(self)
end

-- Default action
function Unit:bored()
	--
end

-- Death action
function Unit:die()
	self.dying = true
end

-- Define shape sprite needs to interact with environment
--
function Unit:setFixture(shape, ...)
	Entity.setFixture(self, shape, ...)
	--
	self.fixture:setGroupIndex(Config.world.filter.group.unit)
	self.fixture:setCategory(Config.world.filter.category.unit)
	self.fixture:setMask(Config.world.filter.mask.unit)
end

-- Handle collisions
--
function Unit:beginContact(other, col)
	if col:isTouching() then
		self.behavior:beginContact(other, col)
		--
		if other.category == 'Environment' then
		-- Environmental Contact
			if select(2, col:getNormal()) ~= 0 then
			-- ground contact
				if not self.grounds[other.uuid] then
					self.grounds[other.uuid] = other
				end
			end
			
			if select(1, col:getNormal()) ~= 0 then
			-- wall contact
				if not self.walls[other.uuid] then
					self.walls[other.uuid] = other
				end
			end
		end
	end
end

-- Handle separations
--
function Unit:endContact(other, col)
	self.behavior:endContact(other, col)
	--
	if other.category == 'Environment' then
	-- off wall/ground
		
		if self.grounds[other.uuid] then
		-- ground departure
			self.grounds[other.uuid] = nil
		end

		if self.walls[other.uuid] then
		-- wall departure
			self.walls[other.uuid] = nil
		end
	end
end

-- Set behavior only if new behavior requested
--
function Unit:setBehavior(name, ...)
	name = self.name .. '_' .. name
	
	if self.behavior then
	-- Reassignment
		if self.behavior.name ~= name then
-- print(self.behavior.name, name)
		-- Change in behavior
			self.behavior:destroy()
			self.behavior = Behaviors[name](self, ...)
		end
	else
	-- Init
		self.behavior = Behaviors[name](self, ...)
	end
end

-- Update
--
function Unit:update(dt)
	self.timer:update(dt)
	self.behavior:update(dt)

	-- set flags
	self.onGround = _:size(self.grounds) > 0
	self.onWall   = _:size(self.walls) > 0
	--
	Entity.update(self, dt)
end

-- Draw
--
function Unit:draw()
	if self.visible then
		self.behavior:draw()
	end
	--
	Entity.draw(self)
end

return Unit