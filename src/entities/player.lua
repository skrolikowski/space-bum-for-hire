-- Player entity
-- Shane Krolikowski
--

local Entity = require 'src.entities.entity'
local Player = Entity:extend()

function Player:new(x, y)
	Entity.new(self, {
		x        = x,
		y        = y,
		bodyType = 'dynamic',
		shape = {
			type = 'rectangle',
			props = { 32, 64 }
		},
		categories = {
			-- belongs to...
			Config.world.categories.civilians
		},
		masks = {
			-- ingores these...
			Config.world.categories.civilians,
		}
	})
end

return Player