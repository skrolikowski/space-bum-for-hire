-- Base Camera
--

local Modern     = require 'modern'
local BaseCamera = Modern:extend()

function BaseCamera:new(name)
	self.name   = name
	self.camera = Camera(0, 0, Config.scale)
end

-- Pass through
--
function BaseCamera:zoomTo(zoom)
	self.camera:zoomTo(zoom)
end

-- Pass through
--
function BaseCamera:lookAt(...)
	self.camera:lookAt(...)
end

-- Update camera
--
function BaseCamera:update(dt)
	--
end

-- Draw camera
--
function BaseCamera:draw(callback)
	self.camera:attach()
	
	callback()

	self.camera:detach()
end

return BaseCamera