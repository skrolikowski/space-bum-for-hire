-- Player HUD
--

local Modern = require 'modern'
local HUD    = Modern:extend()

function HUD:new()
	self.spritesheet = Config.image.spritesheet.ui
	self.background  = Config.ui.hud.player
	self.dirty       = true

	-- scaling
	self.sx = 0.75
	self.sy = 0.75

	-- bootstrap
	self:setTransform()
	self:resetCanvas()
end

-- HUD dimensions
--
function HUD:dimensions()
	return self.background:getDimensions()
end

-- Set HUD transform
--
function HUD:setTransform()
	local w, h = self:dimensions()
	local tx   = Config.padding
	local ty   = Config.height - h * self.sy - Config.padding

	self.transform = lx.newTransform()
	self.transform:translate(tx, ty)
	self.transform:scale(self.sx, self.sy)
end

-- (Re)set canvas w/ latest stats
--
function HUD:resetCanvas()
	local w, h    = self:dimensions()
	local hpImage = lg.newCanvas(1, 32)
	local spImage = lg.newCanvas(1, 32)
	local apImage = lg.newCanvas(1, 32)
	local hpQuad  = lg.newQuad(0, 0, Config.world.meter * 3, Config.world.meter, hpImage:getDimensions())
	local spQuad  = lg.newQuad(0, 0, Config.world.meter * 5, Config.world.meter, spImage:getDimensions())
	local apQuad  = lg.newQuad(0, 0, Config.world.meter * 7, Config.world.meter, apImage:getDimensions())
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
	location = lg.newText(Config.ui.font.lg)
	location:setf(Config.world.player.location, w, 'center')
	-- END SETUP -----------------------

	-- BEGIN CANVAS ---------------
	self.canvas = lg.newCanvas(w, h)
	lg.setCanvas(self.canvas)
	
	-- background
	lg.setColor(Config.color.white)
	lg.draw(self.background)
	------------------------------------

	-- BEGIN DRAW ----------------------
	-- health meters
	lg.draw(hpImage, hpQuad, Config.world.meter * 8, Config.world.meter * 3)
	lg.draw(spImage, spQuad, Config.world.meter * 7, Config.world.meter * 5)
	lg.draw(apImage, apQuad, Config.world.meter * 6, Config.world.meter * 7)

	-- shield active
	if Config.world.player.shield > 0 then
		self.spritesheet:draw('progress_blueBorderSmall', Config.world.meter * 5+8, Config.world.meter * 4+4, 0, 2, 2)
	end

	-- location
	lg.draw(location, Config.world.meter * 6 + Config.padding/2, Config.world.meter/2 + Config.padding/2)

	-- weapon
	-- TODO:

	-- objective
	-- TODO:

	-- END DRAW ------------------------


	-- END CANVAS ----------------------
	lg.setCanvas()
	------------------------------------
	--
	self.dirty = false
end

-- Update w/ Player stats
--
function HUD:update(dt)
	if self.dirty then
		self:resetCanvas()
	end
end

-- Draw HUD
--
function HUD:draw()
	local r, g, b = unpack(Config.color.white)

	lg.setColor(r, g, b, 0.95)
	lg.draw(self.canvas, self.transform)
end

return HUD