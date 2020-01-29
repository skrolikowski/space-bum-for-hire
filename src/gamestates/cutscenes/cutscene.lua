-- Base Cutscene
--

local Base     = require 'src.gamestates.base'
local Cutscene = Base:extend()

-- New cutscene
function Cutscene:init(data)
	Base.init(self, data)
	--
end

-- Enter cutscene
--
function Cutscene:enter(from, ...)
	Base.enter(self, from, ...)
	pcall(function() from:unregisterControls() end)
	--
	-- default controls
	self:setControl('cutscene')
	self:lookAt(self.width/2, self.height/2)
end

-- Tear down
--
function Cutscene:leave()
	Base.leave(self)
	--
end

-- Skip cutscene
--
function Cutscene:skip()
	self:complete()
end

-- Complete cutscene
--
function Cutscene:complete()
	self:unregisterControls()
end

function Cutscene:draw()
	Base.draw(self)
	--
	lg.setColor(Config.color.white)
	lg.setFont(Config.ui.font.md)
	lg.printf('SPACE to Skip', 25, Config.height - 100, Config.width, 'center')
end

return Cutscene