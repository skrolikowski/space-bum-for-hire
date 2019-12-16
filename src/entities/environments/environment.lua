-- Environment entity
-- Shane Krolikowski
--

local Entity      = require 'src.entities.entity'
local Environment = Entity:extend()

function Environment:new(data)
	if data.shape == 'rectangle' then
	-- Rectangle
		data.x         = data.x + data.width / 2
		data.y         = data.y + data.height / 2
		data.shapeData = {
			data.width,  -- rectangle width
			data.height
		}
	else
	-- Polygon
		data.shapeData = {}

		for __, point in pairs(data.polygon) do
			table.insert(data.shapeData, point.x)
			table.insert(data.shapeData, point.y)
		end
	end
	
	-- filters
	-- data.categories = {}  -- belongs to...
	-- data.mask       = {}  -- ingores these...

	Entity.new(self, data)
end

return Environment