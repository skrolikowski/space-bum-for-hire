-- Fall Behavior
--

local Behavior = require 'src.entities.behaviors.behavior'
local Fall     = Behavior:extend()

function Fall:new(host)
	self.sprite = Animator()
	self.sprite:addAnimation('fall', {
		image  = Config.image.spritesheet.cyberpunk.jump,
		width  = 64,
		height = 64,
		frames = { { 1, 8, 1, 8 } }
	})
	self.sprite:addAnimation('jumpAim', {
		image  = Config.image.spritesheet.cyberpunk.jumpAim,
		width  = 64,
		height = 64,
		frames = { { 1, 3, 1, 3 } }
	})
	self.sprite:addAnimation('jumpAimUp', {
		image  = Config.image.spritesheet.cyberpunk.jumpAim,
		width  = 64,
		height = 64,
		total  = 1,
		frames = { { 1, 4, 1, 5 } }
	})
	self.sprite:addAnimation('jumpAimDown', {
		image  = Config.image.spritesheet.cyberpunk.jumpAim,
		width  = 64,
		height = 64,
		total  = 1,
		frames = { { 1, 1, 1, 2 } }
	})
	--
	Behavior.new(self, 'fall', host)
end

-- Switch out animation
--
function Fall:update(dt)
	local isAiming = self.host.shooting

	-- update animation
	if isAiming then
	-- Aiming
		if self.host.axis.y < 0 then
			self.sprite:switchTo('jumpAimUp')
		elseif self.host.axis.y > 0 then
			self.sprite:switchTo('jumpAimDown')
		else
			self.sprite:switchTo('jumpAim')
		end
	else
	-- Jump
		self.sprite:switchTo('jump')
	end
	--
	Behavior.update(self, dt)
end

return Fall