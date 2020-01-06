-- Cutscene camera
--

local Base           = require 'src.utils.cameras.camera'
local CutsceneCamera = Base:extend()

function CutsceneCamera:new()
	Base.new(self, 'CutsceneCamera')
	--
	self.width  = Gamestate:current().width
	self.height = Gamestate:current().height
	self.x      = self.width  / 2
	self.y      = self.height / 2

	-- camera target
	self.target = nil

	--
	self.camera:lookAt(self.x, self.y)
end

-- -- Update Camera Focus/HUD
-- --
-- function CutsceneCamera:update(dt)
-- 	if self.target ~= nil then
-- 		self.camera:lookAt(self.target:getPosition())
-- 	else
-- 		self.camera:lookAt(self.x, self.y)
-- 	end
-- 	--
-- 	Base.update(self, dt)
-- end

-- Draw Player HUD
--
function CutsceneCamera:draw(callback)
	Base.draw(self, callback)
	--
	--TODO: draw ui
end

return CutsceneCamera