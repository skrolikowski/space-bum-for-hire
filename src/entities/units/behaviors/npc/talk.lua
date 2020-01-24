-- Talk Behavior
--

local Base = require 'src.entities.units.behaviors.npc.base'
local Talk = Base:extend()

function Talk:new(host)
	self.sprite = Animator()
	self.sprite:addAnimation('talk', {
		image  = host.sprite.talk,
		width  = 64,
		height = 64,
		frames = { { 1, 1, 1, 8 } }
	})
	--
	Base.new(self, 'talk', host)
end

-- -- Always facing target
-- --
-- function Talk:update(dt)
-- 	local hx, hy = self.host:getPosition()
-- 	local tx, ty = self.host.target:getPosition()
	
-- 	self.host.isMirrored = tx < hx
-- 	--
-- 	Base.update(self, dt)
-- end

return Talk