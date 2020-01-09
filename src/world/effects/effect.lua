-- Base Effect
--

local Modern = require 'modern'
local Effect = Modern:extend()

-- New effect
--
function Effect:new(name, data)
	local sw, sh = self:dimensions()
	--
	-- properties
	self.name   = name
	self.bounds = AABB:fromContainer(data.x, data.y, sw, sh)

	-- scaling
	self.sx = data.width  / sw
	self.sy = data.height / sh

	-- flags
	self.isMirrored = data.isMirrored == true or false
	self.isFlipped  = data.isFlipped  == true or false

	-- ENTER THE WORLD ---
	local cx, cy = self.bounds:center()

	-- body & shape	
	self.body  = lp.newBody(_World.world, cx, cy, 'static')
	self.shape = Shapes['rectangle'](sw, sh)
	self.shape:setBody(self.body)

	-- fixture
	self.fixture = lp.newFixture(self.body, self.shape.shape, 1)
	self.fixture:setGroupIndex(Config.world.filter.group.effect)
	-- self.fixture:setCategory(Config.world.filter.category.effect)
	-- self.fixture:setMask(unpack(Config.world.filter.mask.effect))
	self.fixture:setUserData(self)
	self.fixture:setSensor(true)
end


-- Body position
--
function Effect:getPosition()
	return self.body:getPosition()
end

-- Effect width/height
--
function Effect:dimensions()
	return self.sprite:dimensions()
end

-- Flag for removal
--
function Effect:destroy()
	self.remove = true
	self.body:destroy()
end

-- Check for collisions
--
function Effect:beginContact(other, col)
	--
end

-- Check for separations
--
function Effect:endContact(other, col)
	--
end

-- Update effect
--
function Effect:update(dt)
	self.sprite:update(dt)
end

-- Draw effect
--
function Effect:draw()
	local cx, cy     = self:getPosition()
	local w, h       = self:dimensions()
	local sx, sy     = (self.sx or 1), (self.sy or 1)
	local isMirrored = self.isMirrored
	local isFlipped  = self.isFlipped

	local ox = w/2 + (self.ox or 0)
	local oy = h/2 + (self.oy or 0)

	if isMirrored then sx = -sx end
	if isFlipped  then sy = -sy end

	lg.setColor(Config.color.white)
	self.sprite:draw(cx, cy, 0, sx, sy, ox, oy)
end

return Effect