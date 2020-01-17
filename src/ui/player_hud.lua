-- Player HUD
--

--local Base = require 'src.ui.ui'
local Modern = require 'modern'
local HUD    = Modern:extend()

function HUD:new()
	self.background = Config.world.hud.image
	self.dirty      = true
	--
	self.spriteUI        = Config.image.spritesheet.ui
	self.spriteItem      = Config.image.spritesheet.item
	self.spriteWeapon    = Config.image.spritesheet.item
	self.spriteObjective = Config.image.spritesheet.avatars

	-- dimensions
	self.width  = self.background:getWidth()
	self.height = self.background:getHeight()

	-- scaling
	self.sx = 0.8
	self.sy = 0.8

	-- translate
	self.tx = Config.padding
	self.ty = Config.height - self.height * self.sy

	--
	self:setCanvas()
end

-- Decrease value of player profile
-- and update display
--
function HUD:decrease(payload)
	return pcall(function()
		local currValue = Config.world.hud[payload.category][payload.name].now
		local minValue  = 0
		local newValue  = currValue - payload.value

		Config.world.hud[payload.category][payload.name].now = _.__max(minValue, newValue)

		self.dirty = true
	end)
end

-- Increase value of player profile
-- and update display
--
function HUD:increase(payload)
	return pcall(function()
		local currValue = Config.world.hud[payload.category][payload.name].now
		local maxValue  = Config.world.hud[payload.category][payload.name].max
		local newValue  = currValue + payload.value

		Config.world.hud[payload.category][payload.name].now = _.__min(newValue, maxValue)

		self.dirty = true
	end)
end

-- Set value of player stat
-- and update display
--
function HUD:set(payload)
	if payload.name == 'weapon' then
	-- Set Weapon
		-- update weapon properties
		Config.world.hud.weapon = payload.value

		self.spriteWeapon = Config.image.spritesheet[Config.world.weapon[payload.value].spritesheet]
		self.dirty        = true
	elseif payload.name == 'location' then
	-- Set Location
		Config.world.hud.location = payload.value
		self.dirty = true
	elseif payload.name == 'objective' then
	-- Set Objective
		Config.world.hud.objective = payload.value
		self.dirty = true
	else
	-- Set Stat/Ammo
		return pcall(function()
			local currValue = Config.world.hud[payload.category][payload.name].now
			local minValue  = 0
			local maxValue  = Config.world.hud[payload.category][payload.name].max
			local newValue  = currValue - payload.value

			Config.world.hud[payload.category][payload.name].now
				= Util:clamp(payload.value, minValue, maxValue)

			self.dirty = true
		end)
	end
end

-- Set canvas w/ latest stats
--
function HUD:setCanvas()
	-- prepare canvases
	local hpImage = lg.newCanvas(1, 32)
	local spImage = lg.newCanvas(1, 32)
	local apImage = lg.newCanvas(1, 32)

	-- max stat points
	local hpMax   = Config.tileSize * 6
	local spMax   = Config.tileSize * 10
	local apMax   = Config.tileSize * 14

	-- health
	local healthNow = Config.world.hud.stat.health.now
	local healthMax = Config.world.hud.stat.health.max
	local healthPct = (healthMax - healthNow) / healthMax
	local hpValue   = hpMax - hpMax * healthPct

	-- shield
	local shieldNow = Config.world.hud.stat.shield.now
	local shieldMax = Config.world.hud.stat.shield.max
	local shieldPct = (shieldMax - shieldNow) / shieldMax
	local spValue   = spMax - spMax * shieldPct

	-- weapon
	local weapon = Config.world.weapon[Config.world.hud.weapon]

	-- ammo
	local ammo = {
		bullets = Config.world.hud.ammo['bullets'],
		shells  = Config.world.hud.ammo['shells'],
	}
	local ammoNow = ammo[weapon.clip].now
	local ammoMax = ammo[weapon.clip].max
	local ammoPct = (ammoMax - ammoNow) / ammoMax
	local apValue = apMax - apMax * ammoPct
	--

	local hpQuad  = lg.newQuad(0, 0, hpValue or 0, Config.tileSize * 2, hpImage:getDimensions())
	local spQuad  = lg.newQuad(0, 0, spValue or 0, Config.tileSize * 2, spImage:getDimensions())
	local apQuad  = lg.newQuad(0, 0, apValue or 0, Config.tileSize * 2, apImage:getDimensions())
	local locationText, weaponText

	-- BEGIN SETUP -----------------
	-- health meter
	lg.setCanvas(hpImage)  -- 16x34
	self.spriteUI:drawQuad('progress_redBorder', { y = 4, h = 1 }, 1, 0, _.__pi/2, 2, 2)
	lg.setCanvas()
	-- shield meter
	lg.setCanvas(spImage)  -- 16x34
	self.spriteUI:drawQuad('progress_blueBorder', { y = 4, h = 1 }, 1, 0, _.__pi/2, 2, 2)
	lg.setCanvas()
	-- ammo meter
	lg.setCanvas(apImage)  -- 16x34
	self.spriteUI:drawQuad('progress_greenBorder', { y = 4, h = 1 }, 1, 0, _.__pi/2, 2, 2)
	lg.setCanvas()

	hpImage:setWrap('clamp')
	spImage:setWrap('clamp')
	apImage:setWrap('clamp')

	-- location
	locationText = lg.newText(Config.ui.font.md)
	locationText:setf(_.__upper(Config.world.hud.location), Config.tileSize*12, 'center')

	-- weapon
	weaponText = lg.newText(Config.ui.font.sm)
	weaponText:setf(_.__upper(weapon.name), Config.tileSize*7.5, 'left')

	-- ammo count
	ammoText = lg.newText(Config.ui.munitions.md)
	ammoText:setf(ammo[weapon.clip].now, Config.tileSize*3.5, 'center')

	-- munitions text
	bulletsText = lg.newText(Config.ui.munitions.sm)
	shellsText  = lg.newText(Config.ui.munitions.sm)

	bulletsText:setf(ammo['bullets'].now .. ' / ' .. ammo['bullets'].max, Config.tileSize*5.5, 'right')
	shellsText:setf(ammo['shells'].now   .. ' / ' .. ammo['shells'].max,  Config.tileSize*5.5, 'right')
	--
	-- END SETUP -----------------------

	-- BEGIN CANVAS ---------------
	self.canvas = lg.newCanvas(self.width, self.height)
	lg.setCanvas(self.canvas)

	-- font
	lg.setFont(Config.ui.font.md)

	-- background
	lg.setColor(Config.color.white)
	lg.draw(self.background)
	------------------------------------

	-- BEGIN DRAW ----------------------
	-- health meters
	lg.draw(hpImage, hpQuad, Config.tileSize * 16, Config.tileSize * 6)
	lg.draw(spImage, spQuad, Config.tileSize * 14, Config.tileSize * 10)
	lg.draw(apImage, apQuad, Config.tileSize * 12, Config.tileSize * 14)

	--TODO:
	-- -- shield active
	-- if Config.world.hud.stat.shield.now > 0 then
	-- 	self.spriteUI:draw('progress_blueBorderSmall', Config.tileSize*10+8, Config.tileSize*8+4, 0, 2, 2)
	-- end

	-- location
	lg.draw(locationText, Config.tileSize*26, Config.tileSize*2)

	-- weapon name
	lg.draw(weaponText, Config.tileSize*1.5, Config.tileSize*7.5)

	-- weapon image
	self.spriteWeapon:draw(weapon.name, Config.tileSize*1.5, Config.tileSize*8, 0, 2, 2)

	-- ammo count
	lg.draw(ammoText, Config.tileSize * 11.25, Config.tileSize * 12, _.__pi / 2)

	-- munitions
	lg.draw(bulletsText, Config.tileSize * 1, Config.tileSize * 13)
	lg.draw(shellsText,  Config.tileSize * 1, Config.tileSize * 14.5)

	self.spriteItem:draw('bullets_sm', Config.tileSize*6.5, Config.tileSize*12, 0, 1.5, 1.5)
	self.spriteItem:draw('shells_sm',  Config.tileSize*7, Config.tileSize*14)

	--TODO:
	-- -- objective
	-- if Config.world.hud.objective then
	-- 	self.spriteObjective:draw(Config.world.hud.objective, Config.tileSize*10, Config.tileSize*10, 0, 5, 5)
	-- end

	-- END DRAW ------------------------

	-- END CANVAS ----------------------
	lg.setCanvas()
	------------------------------------
	--
	self.dirty = false
end

-- Update
--
function HUD:update(dt)
	if self.dirty then
		self:setCanvas()
	end
end

-- Draw UI
--
function HUD:draw()
	local r, g, b = unpack(Config.color.white)

	lg.push("all")
	lg.translate(self.tx, self.ty)
	lg.scale(self.sx, self.sy)
	--

	lg.setColor(r, g, b, 0.95)
	lg.draw(self.canvas)

	--
	lg.pop()
end

return HUD