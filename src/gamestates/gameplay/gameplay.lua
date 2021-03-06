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

-- Enter Gameplay Screen
-- * Player Hud
-- * Spawn Player
--
function Gameplay:enter(from, ...)
	Base.enter(self, from, ...)
	--
	-- Keep pause status from previous screen
	pcall(function() self.isPaused = from.isPaused end)

	-- default controls
	self:setControl('none')

	-- start quest!
    if Config.world.hud.quest == 0 then
	    self:setQuest(1)
	end

	-- update hud
	self.hud:set({
		name  = 'location',
		value = self.name
	})

	-- Attempt Player Spawn
	if self.settings.from == 'beam' then
		self:playerEnterBeam(
			Config.tileSize * self.settings['col'],
			Config.tileSize * self.settings['row'],
			self.settings.respawn or false
		)
	else
		-- Continue to sub-class
		-- ...
	end
end

function Gameplay:leave()
	self:unregisterControls()
	--
	Base.leave(self)
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

-- Player has died :(
-- Reboot
--
function Gameplay:playerDeath()
	self:setControl('none')
	--
	Gamestate.push(Gamestates['death'])
end

-- Set Player Checkpoint
--
function Gameplay:setCheckpoint(data)
	Config.world.checkpoint.player = {
		map = self.id,
		id  = data.id,
		row = data.row,
		col = data.col,
	}
end

-- Set New Quest (if ~= 0)
--
function Gameplay:setQuest(questId)
	if questId then
		Config.world.hud.quest = questId

		-- set quest
		self.hud:set({
			name  = 'quest',
			value = questId
		})
	end
end

-- Teleport to Spaceship
--
function Gameplay:teleport()
	local cx, cy = self.player:getPosition()
	local w, h   = Config.spawn.width, Config.spawn.height
	local x, y   = (cx-w/2), (cy-h/2)
	local col    = _.__floor(x / Config.tileSize)
	local row    = _.__floor(y / Config.tileSize)
	local checkpoint

	if self.id == 'space01' then
		checkpoint = _:copy(Config.world.checkpoint.offship)

		Config.world.checkpoint.onship = {
			map = self.id,
			col = col,
			row = row,
		}
	else
		checkpoint = _:copy(Config.world.checkpoint.onship)

		Config.world.checkpoint.offship = {
			map = self.id,
			col = col,
			row = row,
		}
	end
	--
	--
	self:playerExitBeam(x, y, function()
		Gamestate.switch(Gamestates[checkpoint.map], {
			from = 'beam',
			col  = checkpoint.col,
			row  = checkpoint.row,
		})
	end)
end

-- Update HUD
--
function Gameplay:update(dt)
	Base.update(self, dt)
	--
	self.hud:update(dt)
end

-- Draw HUD
--
function Gameplay:draw()
	Base.draw(self)
	--
	self.hud:draw()
end

------------------------
--
-- Enter through Doorway
function Gameplay:playerEnterDoor(x, y, direction)
	self.timer:script(function(wait)
	    -- spawn double and film
	    Double = Entities['Double']({
	        x      = x,
	        y      = y,
	        width  = Config.spawn.width,
	        height = Config.spawn.height,
	        visible = true,
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
	    self.player.isMirrored = (direction == 'left')
	    self.filming           = self.player
	    --
	    -- give controls to player
	    self:setControl('gameplay')
	    Double:destroy()
	end)
end

-- Exit through Doorway
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
		    visible = true,
		})
		self.filming = Double
		--
		Double:move(direction, 350, 1)
		wait(1)
		Double:destroy()
		--
		if after then after() end
	end)
end

-- Beam In Player
--
function Gameplay:playerEnterBeam(x, y, respawn)
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

	-- respawn flag check..
	if respawn then
	-- Reset Health
		self.hud:set({
			category = 'stat',
			name     = 'health',
			value    = self.player.initHealth
		})
		self.player.health = self.player.initHealth
	end
	
	-- update player properties
	self.player.body:setAwake(false)
    self.player.behavior.color = { 1, 1, 1, 0 }

	-- phase in
	self.timer:tween(1, self.player.behavior.color, {1,1,1,1}, 'linear', function()
		self.player.body:setAwake(true)
		self:setControl('gameplay')
	end)
end

-- Beam Out Player
--
function Gameplay:playerExitBeam(x, y, after)
	-- remove player control
	self:setControl('none')

	-- update player properties
	self.player.body:setAwake(false)
	self.player.behavior.color = { 1, 1, 1, 1 }
	
    -- teleportation effect w/ adjustments
    Effects['warp']({
        x      = x - 15,
        y      = y - 25,
        width  = Config.spawn.width  * 1.25,
        height = Config.spawn.height * 1.25,
    })
    
    -- phase out
	self.timer:tween(1, self.player.behavior.color, {1,1,1,0}, 'linear', function()
		self.player:destroy()

		if after then after() end
	end)
end

--
------------------------

return Gameplay