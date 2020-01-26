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
	from:unregisterControls()
	--
	-- default controls
	self:setControl('cutscene')
	self:lookAt(self.width/2, self.height/2)
end

-- Skip cutscene
--
function Cutscene:skip()
	self:unregisterControls()
	Gamestate.pop()
end

return Cutscene