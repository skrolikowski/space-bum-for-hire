-- Cutscene 01
--

local Cutscene = require 'src.gamestates.cutscenes.cutscene'
local Scene01  = Cutscene:extend()

function Scene01:init()
	Cutscene.init(self, {
		name = 'Scene01',
		map  = Config.world.maps['space00'],
	})
	--
	
end

-- Enter Scene
--
function Scene01:enter(from, ...)
	Cutscene.enter(self, from, ...)
	--
	-- Casting Call ---------------
	local Player, Roger, Clarence
	
	-- Player = Entities['Double']({
	-- 	x       = Config.tileSize * 4,
	-- 	y       = Config.tileSize * 17,
	-- 	width   = 80,
	-- 	height  = 80,
	-- 	visible = false,
	-- })
	Roger = Entities['Doctor']({
		name    = 'Roger',
		x       = Config.tileSize * 17,
		y       = Config.tileSize * 17,
		width   = 80,
		height  = 80,
		visible = true,
	})
	Clarence = Entities['Doctor']({
		name    = 'Clarence',
		x       = Config.tileSize * 26,
		y       = Config.tileSize * 17,
		width   = 80,
		height  = 80,
		visible = true,
	})

	-- ACTION!!! ------------------
    self.timer:script(function(wait)
    	-- Roger & Clarence enter room together
		self.target = Roger
		-- Roger:move('left', 350, 5)
		-- Clarence:move('left', 350, 4)
		-- wait(5)
		-- --
		-- Roger:say('right', 'It\'s going to work this time! I just know it!', 6)
		-- wait(6)
		-- --
		-- self.target = Clarence
		-- Clarence:say('left', 'Last time you nearly blew out our warp core!', 6)
		-- wait(3)
		-- Roger:blame('right', 3)
		-- wait(3)
		
		-- Roger:say('right', 'That\'s because we didn\'t have enough power!.', 6)
		-- wait(2)
		-- Clarence:shock('left', 2)
		-- wait(4)
		-- --
		-- Roger:say('right', 'Th', 6)
		-- Clarence:worry('left', 4)
		-- wait(6)
		-- --
		-- Roger:say('right', 'This time', 6)
		-- Clarence:worry('left', 4)
		-- wait(6)
		--
		table.insert(self.effects, Effects['flame2']({
			x = Config.tileSize * 10,
			y = Config.tileSize * 10,
			width  = Config.tileSize * 10,
			height = Config.tileSize * 10,
		}))
		Roger:say('right', 'Here goes!!', 4)
		wait(4)
		Roger:fiddle('right', 2)
		wait(2)
		Roger:shock('right', 2)
		Clarence:shock('left', 2)
		wait(2)
		--TODO: more shock and suspense!!
		--


		-- ~ fin ~
		-- wait(3)
		-- self:leave()
	end)
	-- CUT!!! ---------------------
end

-- Leave Scene
--
function Scene01:leave()
	Base.leave(self)
	--
	Gamestate.switch(Gamestates['space01'])
end

return Scene01