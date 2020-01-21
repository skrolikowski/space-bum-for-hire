-- Environment entity
-- Shane Krolikowski
--

local Entity      = require 'src.entities.entity'
local Environment = Entity:extend()

function Environment:new(data)
	local shapeData = {}
	
	if data.shape == 'rectangle' then
	-- Rectangle
		data.x         = data.x + data.width / 2
		data.y         = data.y + data.height / 2
		data.shapeData = { 0, 0, data.width, data.height }
	else
	-- Polygon
		data.shapeData = {}
		
		for __, point in pairs(data.polygon) do
			table.insert(data.shapeData, point.x - data.x)
			table.insert(data.shapeData, point.y - data.y)
		end
	end	
	--
	Entity.new(self, _:merge(data, {
		name     = data.name or 'Environment',
		category = 'Environment'
	}))

	-- set entity fixture/shape
	self:setFixture(data.shape, unpack(self.shapeData))
end

-- Set collision filter data
--
function Environment:setFixture(shape, ...)
	Entity.setFixture(self, shape, ...)
	--
	self.fixture:setGroupIndex(Config.world.filter.group.environment)
	self.fixture:setCategory(Config.world.filter.category.environment)
end

-- Draw entity
--
function Environment:draw()
	if self.visible then
		lg.setColor(Config.color.shape)
		self.shape:draw()
	end
end

return Environment