-- Run Behavior
--

local Base = require 'src.entities.units.behaviors.enemy.base'
local Run  = Base:extend()

function Run:new(host)
	self.sprite = Animator()
	self.sprite:addAnimation('run', {
		image  = host.sprite,
		width  = 87,
		height = 59,
		fps    = 8,
		frames = {
			{ 1, 5, 1, 5 },
			{ 2, 1, 2, 5 }
		}
	})
	--
	Base.new(self, 'run', host)
end

-- Tear down
--
function Run:destroy()
	self.edge:destroy()
	--
	Base.destroy(self)
end

-- Set sensors for: NPC
--   - Environmental dispatcher
--
function Run:setSensors()
	Base.setSensors(self)
	--
	local x, y, w, h  = self.bounds:container()
	local hW, hH, pad = w/2, h/2, Config.tileSize
	local shape, edge

	if self.host.isMirrored then
		shape = Shapes['edge'](-hW-pad, hH+8, -hW-pad, hH)
	else
		shape = Shapes['edge']( hW+pad, hH+8,  hW+pad, hH)
	end

	self.edge = Sensors['dispatcher'](self.host, { 'Environment' })
	self.edge:setShape(shape)
	self.edge:setOffContact(function(other, col) self.host.running = false end)
end

-- Handle collision detection
-- Stop on wall
--
function Run:beginContact(other, col)
	if select(1, col:getNormal()) ~= 0 then
	-- wall contact
		self.host.running = false
	end
end

-- Update
--
function Run:update(dt)
	local vx, vy = self.host:getLinearVelocity()
	local ix, iy = 0, 0

	if self.host.isMirrored  then
		ix = self.host:mass() * (-self.host.speed - vx)
	else
		ix = self.host:mass() * ( self.host.speed - vx)
	end

	self.host:applyForce(ix, iy)
	--
	Base.update(self, dt)
end

return Run