-- Walk Behavior
--

local Base = require 'src.entities.units.behaviors.npc.base'
local Walk = Base:extend()

function Walk:new(host)
	local cycles = _.__random(2, 4)

	self.sprite = Animator()
	self.sprite:addAnimation('walk', {
		image  = Config.image.spritesheet.doctor.walk,
		width  = 64,
		height = 64,
		total  = cycles,
		frames = { { 1, 1, 1, 10 } },
		after  = function()
			cycles = cycles - 1

			if cycles == 0 then
				self.host.walking = false
			end
		end
	})
	--
	Base.new(self, 'walk', host)

	-- flags
	self.edgeOnLeft  = false
	self.edgeOnRight = false
end

function Walk:destroy()
	self.sight:destroy()
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

	-- dialogue sensor
	self.sight = Sensors['sight'](self.host, { 'Unit' })
	self.sight:setShape(Shapes['circle'](0, 0, 100))
	self.sight:setInFocus(function(other) self:inFocus(other) end)

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

-- In Focus Event
-- Handle when entity comes into focus
--
function Walk:inFocus(other)
	if other.category == 'Enemy' then
	-- Run from enemies
		self.host.fleeing = true
		self.host.target  = other
	elseif other.name == 'Player' then
	-- Comment to player
		if self.host.talking == false then
			self.host.talking = true
			self.host.target  = other
		end
	end
end

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