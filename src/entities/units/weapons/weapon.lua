-- Entity Weapon
-- Shane Krolikowski
--

local Modern = require 'modern'
local Weapon = Modern:extend()

-- New weapon
--
function Weapon:new(name, host)
	self.name  = name
	self.host  = host
	self.timer = Timer.new()

	-- weapon
	self.weapon       = Config.world.weapon[name]
	self.weaponSprite = self:setWeaponCanvas()
end

-- Tear down
--
function Weapon:destroy()
	self.timer:clear()
end

--
--
function Weapon:setWeaponCanvas()
	local armImage    = Config.image.sprites.arm[_.__lower(self.host.name)]
	local weaponImage = Config.image.spritesheet[self.weapon.spritesheet]

	-- dimensions
	local aw, ah = armImage:getDimensions()
	local ww, wh = weaponImage:dimensions(self.weapon.name)

	local canvas = lg.newCanvas(aw + ww/2, ah + wh/2)
	local width, height = canvas:getDimensions()

	lg.setCanvas(canvas)
	--
	-- player arm
	lg.setColor(Config.color.white)
	lg.draw(armImage, 0, ah/2, 0, self.host.behavior.sx, self.host.behavior.sy)

	-- weapon
	weaponImage:draw(self.weapon.name, aw/2, -ah/4, 0, self.sx, self.sy, self.ox, self.oy)

	-- -- debug
	-- lg.setColor(Config.color.black)
	-- lg.rectangle('line', 0, 0, width, height)

	--
	lg.setCanvas()

	return canvas
end

-- Destroy weapon (...not really)
--
function Weapon:destroy()
	self.timer:clear()
end

-- Trigger weapon
--
function Weapon:trigger(dt, et)
	self.host.shooting = true
end

-- Holster weapon
--
function Weapon:holster()
	self.host.shooting = false
end

-- Update weapon
--
function Weapon:update(dt)
	self.timer:update(dt)
	self.sprite:update(dt)
end

-- Draw weapon
--
function Weapon:draw()
	if self.host.shooting then
	-- Draw arm starting from host center
		local cx, cy = self.host:getPosition()
		local w, h   = self.weaponSprite:getDimensions()
		local angle  = self.host.aimAngle
		local tx, ty = cx, cy - h/2
		local sx, sy = 1, 1
		local ox, oy = 0, h/4

		-- adjust arm placement for crouch animation
		--
		if self.host.behavior.name == 'Player_crouch' then
			ty = ty + ty * 0.05
		end

		-- adjust arm angle for shooting animation
		if self.host.isMirrored then
			sx    = -sx
			angle = angle + _.__pi
		end

		lg.draw(self.weaponSprite, tx, ty, angle, sx, sy, ox, oy)
	end
end

return Weapon