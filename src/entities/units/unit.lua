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
	self.health     = 100
	self.jumpHeight = 4000

	-- flags
	self.isMirrored = false
	self.isFlipped  = false
	self.onGround   = false
	self.onWall     = false
	self.canDestroy = true

	-- physics
	self.walls   = {}
	self.grounds = {}
	self:fixedRotation(true)
	self:setSleepingAllowed(false)
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
		if other.name == 'Environment' then
		-- on wall/ground
			if select(2, col:getNormal()) == -1 then
print(self.name, 'ground contact')
			-- ground contact
				if not self.grounds[other.uuid] then
					self.grounds[other.uuid] = other
					-- self.onGround = true
					-- print(self.name, 'onGround')
				end
			end
			
			if select(1, col:getNormal()) ~= 0 then
			-- wall contact
				if not self.walls[other.uuid] then
					self.walls[other.uuid] = other
					-- self.onWall = true
					-- print(self.name, 'onWall')
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
	if other.name == 'Environment' then
	-- off wall/ground
		
		if self.grounds[other.uuid] then
		-- ground departure
			self.grounds[other.uuid] = nil
		end

		if self.walls[other.uuid] then
		-- wall departure
			self.walls[other.uuid] = nil
		end

		-- if #self.grounds == 0 then
		-- -- onGrounds check
		-- 	self.onGround = false
		-- 	-- print(self.name, 'offGround')
		-- end

		-- if #self.walls == 0 then
		-- -- offWalls check
		-- 	self.onWall = false
		-- 	-- print(self.name, 'offWall')
		-- end
	end
end

function Unit:setBehavior(name)
	name = self.name .. '_' .. name
	
	if self.behavior then
	-- Reassignment
		if self.behavior.name ~= name then
		-- Change in behavior
			self.behavior:destroy()
			self.behavior = Behaviors[name](self)
		end
	else
	-- Init
		self.behavior = Behaviors[name](self)
	end
end

-- Update
--
function Unit:update(dt)
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
	self.behavior:draw()
	--
	Entity.draw(self)
end

return Unit