-- Pistol Rounds
--

local Round  = require 'src.entities.rounds.round'
local Pistol = Round:extend()

function Pistol:new(host, x, y, angle, sx, sy)
	self.sprite = Animator()
	self.sprite:addAnimation('default', {
		image  = Config.image.spritesheet.round.pistol,
		width  = 35,
		height = 6,
		total  = 1,
		fps    = 50,
		frames = { { 1, 1, 14, 1 } },
		after  = function() self.remove = true end
	})
	--
	Round.new(self, host, x, y, angle, sx, sy)
	--
	Config.audio.round.pistol:play()
end

return Pistol