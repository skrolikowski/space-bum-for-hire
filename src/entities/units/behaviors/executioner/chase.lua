-- Chase Behavior
--

local Base  = require 'src.entities.units.behaviors.executioner.base'
local Chase = Base:extend()

-- Create new chase behavior
--
function Chase:new(host)
	self.target   = host.target
	-- self.platform = host.onGround

	--
	self.sprite = Animator()
	self.sprite:addAnimation('run', {
		image  = Config.image.spritesheet.enemies.executioner,
		width  = 87,
		height = 59,
		fps    = 8,
		frames = {
			{ 1, 5, 1, 5 },
			{ 2, 1, 2, 5 }
		}
	})
	--
	Base.new(self, 'chase', host)
end

-- Chase
--
function Chase:update(dt)
	local targetPos = Vec2(self.target:getPosition())
	local hostPos   = Vec2(self.host:getPosition())
	local axis      = (targetPos - hostPos):normalize()

	if hostPos:distance(targetPos) <= 50 then
        self.host.attacking = true
    else
    	local vx, vy = self.host:getLinearVelocity()
    	local ix, iy = 0, 0

		-- Facing
		self.isMirrored = vx < 0
		
		if axis.x < 0  then
			ix = self.host:mass() * (-self.host.speed - vx)
		elseif axis.x > 0 then
			ix = self.host:mass() * ( self.host.speed - vx)
		end

		self.host:applyForce(ix, iy)
    end
	--
	Base.update(self, dt)
end

return Chase