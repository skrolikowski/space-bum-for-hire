-- Custom camera
--

local Base         = require 'src.utils.cameras.camera'
local CustomCamera = Base:extend()

function CustomCamera:new(x, y, w, h)
	Base.new(self, 'CustomCamera')
	--
	self.width  = w or _World.width
	self.height = h or _World.height
	self.x      = x or self.width  / 2
	self.y      = y or self.height / 2
	--
	self.camera:lookAt(self.x, self.y)
end

return CustomCamera