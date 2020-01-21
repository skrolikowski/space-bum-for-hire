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
	-- default controls
	self:setControl('none')

	-- update hud
	self.hud:set('location', self.name)

	--
	Base.enter(self, from, ...)
end

-- Reward Player a payload
--
function Gameplay:rewardPlayer(payload)
	-- if payload.name == '' then
	-- 	-- TODO: key items?
	-- else
	-- Let HUD handle it
		self.hud:increase(payload)
	-- end
end

-- Player has died
--
function Gameplay:playerDeath()
	--TODO: reboot
	print('Player Death')
end

-- Update HUD
--
function Gameplay:update(dt)
	Base.update(self, dt)
	--
	self.hud:update(dt)
end

-- Draw HUD
function Gameplay:draw()
	Base.draw(self)
	--
	self.hud:draw()
end

--
--
function Gameplay:playerEnterDoor(x, y, direction)
	self.timer:script(function(wait)
	    -- spawn double and film
	    Double = Entities['Double']({
	        x      = x,
	        y      = y,
	        width  = Config.spawn.width,
	        height = Config.spawn.height,
	    })
	    self.filming = Double
	    --
	    Double:move(direction, 350, 1)
	    wait(1)
	    -- spawn player and film
	    self.player = Entities['Player']({
	        x      = Double:getX() - Config.spawn.width/2,
	        y      = Double:getY() - Config.spawn.height/2,
	        width  = Config.spawn.width,
	        height = Config.spawn.height,
	    })
	    self.filming = self.player
	    self.player.isMirrored = (direction == 'left')
	    -- give controls to player
	    self:setControl('player')
	    Double:destroy()
	end)
end

function Gameplay:playerExitDoor(x, y, direction, after)
	self.timer:script(function(wait)
		-- remove player & controls
		self.player:destroy()
		self:setControl('none')
		--
		-- enter cutscene double..
		Double = Entities['Double']({
		    x      = x - Config.spawn.width/2,
		    y      = y - Config.spawn.height/2,
		    width  = Config.spawn.width,
		    height = Config.spawn.height,
		})
		self.filming = Double
		--
		Double:move(direction, 350, 1)
		wait(1)
		--
		if after then after() end
	end)
end

-- Beam In Player
--
function Gameplay:playerEnterBeam(x, y)
    -- focus camera
    self:lookAt(
        x + Config.spawn.width  / 2,
        y + Config.spawn.height / 2
    )
    --
    -- teleportation effect w/ adjustments
    Effects['warp']({
        x      = x - 15,
        y      = y - 25,
        width  = Config.spawn.width  * 1.25,
        height = Config.spawn.height * 1.25,
    })
    --
	-- spawn player
	self.player = Entities['Player']({
		x       = x,
		y       = y,
		width   = Config.spawn.width,
		height  = Config.spawn.height,
	})
	self.filming = self.player
	--
    self.player.behavior.color = { 1, 1, 1, 0 }
	self.timer:tween(1, self.player.behavior.color, { 1,1,1,1}, 'linear', function()
		-- give controls to player
		self:setControl('player')
	end)
end

-- Beam Out Player
--
function Gameplay:playerExitBeam(x, y, after)
	-- remove player control
	self:setControl('none')
	--
    -- teleportation effect w/ adjustments
    Effects['warp']({
        x      = x - 15,
        y      = y - 25,
        width  = Config.spawn.width  * 1.25,
        height = Config.spawn.height * 1.25,
    })
    --
    -- effects
    self.player.behavior.color = { 1, 1, 1, 1 }
	self.timer:tween(1, self.player.behavior.color, {1,1,1,0}, 'linear', function()
		if after then after() end
	end)
end

----


return Gameplay