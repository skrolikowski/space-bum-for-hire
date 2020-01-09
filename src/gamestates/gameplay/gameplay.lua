-- Base Gameplay Scene
--

local Base     = require 'src.gamestates.base'
local Gameplay = Base:extend()

-- New cutscene
function Gameplay:init(data)
	Base.init(self, data)
	--
	-- UI/HUD
    self.hud = UI['player_hud']()

    -- default foreground canvas
	self.foreground = lg.newCanvas(self.width, self.height)
	lg.setCanvas(self.foreground)
		self.map:drawTileLayer('Foreground')
	lg.setCanvas()
end

-- Enter cutscene
--
function Gameplay:enter(from, ...)
	-- register custom events handlers
	-- _:on('onNewPlayerEnter',   function(x, y)   self:onPlayerPreSpawn(x, y)    end)
	-- _:on('onReadyPlayerEnter', function(player) self:onPlayerPostSpawn(player) end)

	-- default controls
	self:setControl('none')
	--
	Base.enter(self, from, ...)
end

function Gameplay:leave()
	-- register custom events handlers
	-- _:off('onNewPlayerEnter')
	-- _:off('onReadyPlayerEnter')
	--
	Base.leave(self)
end

-- -- Player is spawning...
-- --
-- function Gameplay:onPlayerPreSpawn(x, y)
-- 	self:lookAt(x, y)
-- end

-- -- Player is ready to control
-- --
-- function Gameplay:onPlayerPostSpawn(player)
-- 	self.player = player
-- 	--
-- 	self:setControl('player')
-- end

-- Update HUD
--
function Gameplay:update(dt)
	Base.update(self, dt)
	--
	if self.player then
		self:lookAt(self.player:getPosition())
	end
	--
	self.hud:update(dt)
end

-- Draw HUD
function Gameplay:draw()
	Base.draw(self)
	--
	self.hud:draw()
end

return Gameplay