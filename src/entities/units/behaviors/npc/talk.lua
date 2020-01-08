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

	-- -- start dialogue
	-- self.dialogue = Dialogue['comment'](host, 5, function()
	-- 	self.host.talking = false
	-- 	self.host.target  = nil
	-- end)
end

-- -- Update facing/speech
-- --
-- function Talk:update(dt)
-- 	local hx, hy = self.host:getPosition()
-- 	local tx, ty = self.host.target:getPosition()
	
-- 	self.host.isMirrored = tx < hx

-- 	self.dialogue:update(dt)
-- 	--
-- 	Base.update(self, dt)
-- end

-- -- Draw dialogue window
-- --
-- function Talk:draw()
-- 	self.dialogue:draw()
-- 	--
-- 	Base.draw(self)
-- end

return Talk