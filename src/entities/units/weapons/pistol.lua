-- Pistol Weapon
--

local Weapon = require 'src.entities.units.weapons.weapon'
local Pistol = Weapon:extend()

function Pistol:new(host, x, y)
	Weapon.new(self, 'Pistol', host)
	--
	self.sprite = Animator()
	self.sprite:addAnimation('default', {
		image  = Config.world.weapon.pistol.animation,
		width  = 35,
		height = 6,
		total  = 1,
		fps    = 35,
		frames = { { 1, 1, 14, 1 } },
		after  = function() self.firing = false end
	})

	-- properties
	--TODO: power-ups? update stats
	self.cooldown = Config.world.weapon.pistol.cooldown
	self.damage   = Config.world.weapon.pistol.damage
	self.speed    = Config.world.weapon.pistol.speed
end

-- Trigger weapon
--
function Pistol:trigger(dt, et)
	if self.isReady then
		if Config.world.player.weapon.rounds > 0 then
			self:fire()
			self.firing = true
			self.sprite:restart()

			-- cooldown
			self.isReady = false
			self.timer:after(self.cooldown, function() self.isReady = true end)

			-- update rounds
			Config.world.player.weapon.rounds = Config.world.player.weapon.rounds - 1

			-- play sound
			Config.world.weapon.pistol.audio.fire:play()
		else
			--TODO: play empty round sound
			-- Config.world.weapon.pistol.audio.empty:play()
		end
	end
	--
	Weapon.trigger(self, dt, et)
end

return Pistol