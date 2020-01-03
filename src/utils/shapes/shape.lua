-- Physics Shape
-- Shane Krolikowski
--

local Modern = require 'modern'
local Shape  = Modern:extend()

function Shape:setBody(body)
	self.body = body
end

function Shape:center()
	return self:bounds():center()
end

function Shape:dimensions()
	return self:bounds():dimensions()
end

function Shape:bounds()
	return AABB(self.shape:computeAABB(0,0,0))
end

function Shape:getRadius()
	return self.shape:getRadius()
end

function Shape:getType()
	return self.shape:getType()
end

function Shape:computeMass(density)
	return self.shape:computeMass(density)
end

function Shape:computeAABB(...)
	return self.shape:computeAABB(...)
end

function Shape:testPoint(...)
	return self.shape:testPoint(...)
end

function Shape:rayCast(...)
	return self.shape:rayCast(...)
end

return Shape