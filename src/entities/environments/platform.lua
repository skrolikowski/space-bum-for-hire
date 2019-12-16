-- Platform entity
-- Shane Krolikowski
--

local Environment = require 'src.entities.environments.environment'
local Platform    = Environment:extend()

function Platform:new(data)

	-- filters
	-- data.categories = {}  -- belongs to...
	-- data.mask       = {}  -- ingores these...

	Environment.new(self, data)
end

return Platform