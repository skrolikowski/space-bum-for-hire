-- Fall Behavior
--

local Base = require 'src.entities.units.behaviors.player.base'
local Fall = Base:extend()

function Fall:new(host)
	self.sprite = Animator()
	self.sprite:addAnimation('fall', {
		image  = Config.image.spritesheet.player.jump,
		width  = 64,
		height = 64,
		frames = { { 1, 8, 1, 8 } }
	})
	self.sprite:addAnimation('jumpAim', {
		image  = Config.image.spritesheet.player.jumpAim,
		width  = 64,
		height = 64,
		frames = { { 1, 1, 1, 1 } }
	})
	--
	Base.new(self, 'fall', host)
end

-- Switch out animation
--
function Fall:update(dt)
	local isAiming = self.host.shooting

	-- update animation
	if isAiming then
	-- Aiming
		self.sprite:switchTo('jumpAim')
	else
	-- Jump
		self.sprite:switchTo('fall')
	end
	--
	Base.update(self, dt)
end

return Fall