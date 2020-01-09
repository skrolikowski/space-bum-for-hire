-- Walk Behavior
--

local Base = require 'src.entities.units.behaviors.npc.base'
local Walk = Base:extend()

function Walk:new(host)
	self.sprite = Animator()
	self.sprite:addAnimation('walk', {
		image  = host.sprite.walk,
		width  = 64,
		height = 64,
		frames = { { 1, 1, 1, 10 } },
	})
	--
	Base.new(self, 'walk', host)

	-- flags
	self.edgeOnLeft  = false
	self.edgeOnRight = false
end

function Walk:destroy()
	self.leftEdge:destroy()
	self.rightEdge:destroy()
	--
	Base.destroy(self)
end

-- Set sensors for: NPC
--   - Environmental dispatcher
--
function Walk:setSensors()
	local x, y, w, h = self.bounds:container()
	local hW, hH     = w/2, h/2
	local leShape    = Shapes['edge'](-hW, hH + 4, -hW, hH + 12)
	local reShape    = Shapes['edge']( hW, hH + 4,  hW, hH + 12)
	local leftEdge, rightEdge

	-- left edge notification
	self.leftEdge = Sensors['dispatcher'](self.host, { 'Environment' })
	self.leftEdge:setShape(leShape)
	self.leftEdge:setOnContact(function(other, col)  self.edgeOnLeft = false end)
	self.leftEdge:setOffContact(function(other, col) self.edgeOnLeft = true  end)
	
	-- right edge notification
	self.rightEdge = Sensors['dispatcher'](self.host, { 'Environment' })
	self.rightEdge:setShape(reShape)
	self.rightEdge:setOnContact(function(other, col)  self.edgeOnRight = false end)
	self.rightEdge:setOffContact(function(other, col) self.edgeOnRight = true  end)
end

-- Update 
--
function Walk:update(dt)
	local vx, vy = self.host:getLinearVelocity()
	local ix, iy = 0, 0

	if self.host.isMirrored then
		if not self.edgeOnLeft then
			ix = self.host:mass() * (-self.host.speed - vx)
		end
	else
		if not self.edgeOnRight then
			ix = self.host:mass() * ( self.host.speed - vx)
		end
	end

	self.host:applyForce(ix, iy)
	--
	Base.update(self, dt)
end

return Walk