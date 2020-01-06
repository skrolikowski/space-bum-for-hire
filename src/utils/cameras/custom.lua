-- Custom camera
--

local Base         = require 'src.utils.cameras.camera'
local CustomCamera = Base:extend()

function CustomCamera:new(x, y)
	Base.new(self, 'CustomCamera')
	--
	self.width  = w or Gamestate:current().width
	self.height = h or Gamestate:current().height
	self.x      = x or 0
	self.y      = y or 0
	--
	self.camera:lookAt(self.x, self.y)
end

return CustomCamera