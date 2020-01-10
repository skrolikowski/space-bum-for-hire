-- Doctor Unit Entity
-- Non-agressive, super smart techy dudes.
-- They wander the galaxy looking for "losers" to outsmart.
--

local NPC    = require 'src.entities.units.npcs.npc'
local Doctor = NPC:extend()

function Doctor:new(data)
	NPC.new(self, _:merge(data, {
		name  = 'Doctor',
		title = data.title or 'Doctor',
		shape = 'rectangle',
	}))
	--
end

-- Pace
--
function Doctor:pace(direction)
	self.walking    = true
	self.isMirrored = direction == 'left' or false
	--
	self.pacing = self.timer:every(5, function()
		self.isMirrored = not self.isMirrored
	end)
	
	-- sight detection
	-- interact with entities
	--
	self.sight = Sensors['sight'](self, { 'Unit' })
	self.sight:setShape(Shapes['circle'](0, 0, 100))
	self.sight:setInFocus(function(other)
		self.walking = false
		self.sight:destroy()
		self.timer:cancel(self.pacing)
		--
		if other.name == 'Player' then
		-- Comment to Player
			self:comment(other, 5, function()
				self:pace()
			end)
		elseif other.category == 'Enemy' then
		-- Flee from Enemy
			self:flee(other, 400, 3, function()
				self:pace()
			end)
		end
	end)
end

return Doctor