-- Executioner Enemy Unit
-- 

local Enemy       = require 'src.entities.units.enemies.enemy'
local Executioner = Enemy:extend()

function Executioner:new(data)
	Enemy.new(self, data)
    --
	-- properties
	self.health     = 300
	self.speed      = 500
	self.jumpHeight = 3000

	-- flags
	self.attacking  = false
	self.jumping    = false
	self.running    = false

    -- default behavior
    self:patrol()
end

return Executioner