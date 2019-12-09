-- Environment entity
-- Shane Krolikowski
--

local Entity      = require 'src.entities.entity'
local Environment = Entity:extend()

function Environment:new(data)
	data.x         = data.x + data.width / 2
	data.y         = data.y + data.height / 2
	data.shape     = 'rectangle'
	data.shapeData = { data.width, data.height }
	
	-- filters
	-- data.categories = {}  -- belongs to...
	-- data.mask       = {}  -- ingores these...

	Entity.new(self, data)
end

return Environment