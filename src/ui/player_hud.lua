-- Player HUD
--

--local Base = require 'src.ui.ui'
local Modern = require 'modern'
local HUD    = Modern:extend()

function HUD:new()
	self.spritesheet = Config.image.spritesheet.ui
	self.background  = Config.world.hud.image
	self.dirty       = true

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
	local health    = Config.world.hud.stat.health
	local healthMax = Config.world.hud.stat.healthMax
	local healthPct = (healthMax - health) / healthMax
	local hpValue   = hpMax - hpMax * healthPct

	-- shield
	-- local shield    = Config.world.hud.stat.shield
	-- local shieldMax = Config.world.hud.stat.shieldMax
	-- local shieldPct = (shieldMax - shield) / shieldMax
	-- local spValue   = spMax - spMax * shieldPct

	-- weapon
	local weapon  = Config.world.hud.weapon
	local ammoMax = Config.world.weapon[weapon.name].ammoMax
	local ammoPct = (ammoMax - weapon.ammo) / ammoMax
	local apValue = apMax - apMax * ammoPct
	-- 

	local hpQuad  = lg.newQuad(0, 0, hpValue or 0, Config.tileSize * 2, hpImage:getDimensions())
	local spQuad  = lg.newQuad(0, 0, spValue or 0, Config.tileSize * 2, spImage:getDimensions())
	local apQuad  = lg.newQuad(0, 0, apValue or 0, Config.tileSize * 2, apImage:getDimensions())
	local location

	-- BEGIN SETUP -----------------
	-- health meter
	lg.setCanvas(hpImage)  -- 16x34
	self.spritesheet:drawQuad('progress_redBorder', { y = 4, h = 1 }, 1, 0, _.__pi/2, 2, 2)
	lg.setCanvas()
	-- shield meter
	lg.setCanvas(spImage)  -- 16x34
	self.spritesheet:drawQuad('progress_blueBorder', { y = 4, h = 1 }, 1, 0, _.__pi/2, 2, 2)
	lg.setCanvas()
	-- ammo meter
	lg.setCanvas(apImage)  -- 16x34
	self.spritesheet:drawQuad('progress_greenBorder', { y = 4, h = 1 }, 1, 0, _.__pi/2, 2, 2)
	lg.setCanvas()

	hpImage:setWrap('clamp')
	spImage:setWrap('clamp')
	apImage:setWrap('clamp')
	-- location
	location = lg.newText(Config.ui.font.md)
	location:setf(Config.world.hud.location, self.width, 'center')
	-- END SETUP -----------------------

	-- BEGIN CANVAS ---------------
	self.canvas = lg.newCanvas(self.width, self.height)
	lg.setCanvas(self.canvas)
	
	-- background
	lg.setColor(Config.color.white)
	lg.draw(self.background)
	------------------------------------

	-- BEGIN DRAW ----------------------
	-- health meters
	lg.draw(hpImage, hpQuad, Config.tileSize * 16, Config.tileSize * 6)
	lg.draw(spImage, spQuad, Config.tileSize * 14, Config.tileSize * 10)
	lg.draw(apImage, apQuad, Config.tileSize * 12, Config.tileSize * 14)

	-- shield active
	if Config.world.hud.stat.shield > 0 then
		self.spritesheet:draw('progress_blueBorderSmall', Config.tileSize*10+8, Config.tileSize*8+4, 0, 2, 2)
	end

	-- location
	lg.draw(location, Config.tileSize*12 + Config.padding/2, Config.world.meter/2 + Config.padding/2)

	-- weapon
	-- TODO:

	-- ammo count
	lg.setFont(Config.ui.font.md)
	lg.printf(
		Config.world.hud.weapon.ammo,
		Config.tileSize * 11.5,
		Config.tileSize * 12,
		Config.tileSize * 3.5,
		'center',
		_.__pi / 2
	)

	-- objective
	-- TODO:

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