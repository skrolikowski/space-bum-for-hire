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

return Cutscene