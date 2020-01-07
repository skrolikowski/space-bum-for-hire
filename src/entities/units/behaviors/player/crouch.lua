-- Crouch Behavior
--

local Behavior = require 'src.entities.units.behaviors.behavior'
local Base     = require 'src.entities.units.behaviors.player.base'
local Crouch   = Base:extend()

function Crouch:new(host)
	self.sprite = Animator()
	self.sprite:addAnimation('crouch', {
		image  = host.sprite.crouch,
		width  = 64,
		height = 64,
		total  = 1,
		frames = { { 1, 1, 1, 3 } },
		after  = function()
			self.isCrouched = true
		end
	})
	self.sprite:addAnimation('crouched', {
		image  = host.sprite.crouch,
		width  = 64,
		height = 64,
		frames = { { 1, 3, 1, 3 } }
	})
	self.sprite:addAnimation('crouchAim', {
		image  = host.sprite.crouchAim,
		width  = 64,
		height = 64,
		frames = { { 1, 1, 1, 1 } }
	})
	--
	Base.new(self, 'crouch', host)

	self.isCrouched = false
	self:slide()
end

-- Override `reshape`
--
function Crouch:setBounds()
	local x, y, w, h = unpack(self.host.shapeData)
	--
	self.bounds = AABB:fromContainer(x, y + h/4, w/3, h/2)
end

-- Set up Hit Boxes for base
-- Player sprite
--
function Crouch:setHitBoxes()
	self:addHitBox('body', Shapes['rectangle'](self.bounds:scale(0.75, 0.75):container()))
end

-- Update animation
--
function Crouch:update(dt)
	local isAiming = self.host.lockedIn == self.name or
	                 self.host.shooting

	if isAiming then
	-- Aiming
		self.sprite:switchTo('crouchAim')
	else
	-- Crouching
		if self.isCrouched then
			self.sprite:switchTo('crouched')
		else
			self.sprite:switchTo('crouch')
		end
	end
	--
	Base.update(self, dt)
end

-- Slide into crouch if running..
--
function Crouch:slide()
	local vx, vy = self.host:getLinearVelocity()

	vx = vx - vx * 0.45

	self.host:setLinearVelocity(vx, vy)
end

return Crouch