-- Base Cutscene
--

local Base     = require 'src.gamestates.base'
local Cutscene = Base:extend()

-- New cutscene
function Cutscene:init(data)
	Base.init(self, data)
	--
	-- callbacks
	self.onLeave = data.onLeave or function() end
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

	-- callback
	self.onLeave()
end

-- Update timer
--
function Cutscene:update(dt)
	Base.update(self, dt)
	--
	self.timer:update(dt)
end

return Cutscene