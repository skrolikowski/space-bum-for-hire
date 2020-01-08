-- Base Cutscene
--

local Base     = require 'src.gamestates.base'
local Cutscene = Base:extend()

-- New cutscene
function Cutscene:init(data)
	Base.init(self, data)
	--
	self.target = nil
	
	-- flags
	self.comments = false

	-- default foreground canvas
	self.foreground = lg.newCanvas(self.width, self.height)
	lg.setCanvas(self.foreground)
		self.map:drawTileLayer('Foreground')
	lg.setCanvas()

	-- default background canvas
	self.background = lg.newCanvas(self.width, self.height)
	lg.setCanvas(self.background)
		self.map:drawTileLayer('Background')
		self.map:drawTileLayer('Decorative (BG)')
		self.map:drawTileLayer('Walls')
		self.map:drawTileLayer('Platforms')
		self.map:drawTileLayer('Decorative (FG)')
	lg.setCanvas()
end

-- Enter cutscene
--
function Cutscene:enter(from, ...)
	Base.enter(self, from, ...)
	--
	self.timer = Timer.new()

	-- default controls
	self:setControl('cutscene')
	self:lookAt(self.width/2, self.height/2)
end

-- Leave cutscene
function Cutscene:leave()
	Base.leave(self)
	--
	self.timer:clear()
end

-- Update timer
--
function Cutscene:update(dt)
	Base.update(self, dt)
	--
	if self.target then
		self:lookAt(self.target:getPosition())
	end

	self.timer:update(dt)
end

return Cutscene