-- Rectangle Physics Shape
--

local Polygon   = require 'src.entities.shapes.polygon'
local Rectangle = Polygon:extend()

-- New rectangle shape
--
function Rectangle:new(...)
	self.shape = lp.newRectangleShape(...)
end

return Rectangle