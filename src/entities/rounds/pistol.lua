-- Pistol Rounds
--

local Round       = require 'src.entities.rounds.round'
local PistolRound = Round:extend()

function PistolRound:new(host, x, y, angle)
	self.sprite = Animator()
	self.sprite:addAnimation('default', {
		image  = Config.image.spritesheet.particles.pistol,
		width  = 35,
		height = 6,
		total  = 1,
		fps    = 50,
		frames = { { 1, 1, 14, 1 } },
		after  = function() self.remove = true end
		-- NOTE: setting remove could be a problem
		--       if the attack doesn't finish in time.
	})
	--
	Round.new(self, 'pistol-round', host, x, y, angle)
end

return PistolRound