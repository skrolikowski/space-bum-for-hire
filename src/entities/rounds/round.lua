-- Pistol Rounds
--

local Modern = require 'modern'
local Round  = Modern:extend()

function Round:new(name, host, x, y, angle)
	self.host = host
	
	-- properties
	self.name   = name
	self.x      = x
	self.y      = y
	self.angle  = angle or 0
	self.hits   = {}
	self.range  = _World.width / 4
	self.damage = 8

	-- flags
	self.remove = false

	-- start attack
	self:query()
end

-- Query collisions
--
function Round:query()
	local magX  = self.x + _.__cos(self.angle) * self.range
	local magY  = self.y + _.__sin(self.angle) * self.range
	
	-- cast ray and gather collisions..
	_World:querySegment(self.x, self.y, magX, magY,
			function(...) return self:recordCollision(...)
		end)
	
	-- select closest collision..
	if #self.hits > 0 then
		_.__sort(self.hits,
			function(a, b)
				if b then return a.fraction < b.fraction
				else      return b
				end
			end)

		-- inflict damage
		self:inflictDamage()
	end
end

-- Record all collisions
--
function Round:recordCollision(fix, x, y, xn, yn, fraction)
	table.insert(self.hits, {
		pos      = Vec2(x, y),
		normal   = Vec2(xn, yn),
		fraction = fraction,
		fixture  = fix
	})
	
	return 1
end

-- Inflict damage to `others`
-- (sorted by distance)
--
function Round:inflictDamage()
	local hit     = self.hits[1]
	local entity  = hit.fixture:getUserData()
	local contact = Contact(self, hit.pos, hit.normal)

	entity:beginContact(self, contact)
end

function Round:update(dt)
	self.sprite:update(dt)
end

-- Draw pistol animation
--
function Round:draw()
	local transform = lx.newTransform(self.x, self.y, self.angle)

	love.graphics.setColor(Config.color.white)
	self.sprite:draw(transform)

	-- DEBUG
	if self.hits[1] then
		love.graphics.setColor(1,0,0,1)
		love.graphics.circle('fill', self.hits[1].pos.x, self.hits[1].pos.y, '3')
	end
end

return Round