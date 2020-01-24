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
end

-- Tear down
--
function Walk:destroy()
	self.leftEdge:destroy()
	self.rightEdge:destroy()
	--
	Base.destroy(self)
end

-- Set sensors for:
--   - Environmental dispatcher
--
function Walk:setSensors()
	local x, y, w, h = self.bounds:container()
	local pad = Config.tileSize

	self.leftEdge = Sensors['dispatcher'](self.host, { 'Environment' })
	self.leftEdge:setShape(Shapes['circle'](-w/2 - pad/2, h/2 + pad/2, 2))
	self.leftEdge:setOffContact(function(other, col) self.host.walking = false end)

	self.rightEdge = Sensors['dispatcher'](self.host, { 'Environment' })
	self.rightEdge:setShape(Shapes['circle']( w/2 + pad/2, h/2 + pad/2, 2))
	self.rightEdge:setOffContact(function(other, col) self.host.walking = false end)

	--
	-- check for immediate contact
	self.leftEdge:checkForContacts(function(isContact)
		if not isContact then
			self.host.walking = false
		end
	end)

	self.rightEdge:checkForContacts(function(isContact)
		if not isContact then
			self.host.walking = false
		end
	end)
end

-- Handle collision detection
-- Stop on wall
--
function Walk:beginContact(other, col)
	if other.category == 'Environment' then
		if select(1, col:getNormal()) ~= 0 then
		-- wall contact
			self.host.walking = false
		end
	end
end

-- Update 
--
function Walk:update(dt)
	local vx, vy = self.host:getLinearVelocity()
	local ix, iy = 0, 0

	if self.host.isMirrored then
		ix = self.host:mass() * (-self.host.speed - vx)
	else
		ix = self.host:mass() * ( self.host.speed - vx)
	end

	self.host:applyForce(ix, iy)
	--
	Base.update(self, dt)
end

return Walk