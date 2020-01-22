-- Checkpoint
--

local Environment = require 'src.entities.environments.environment'
local Checkpoint  = Environment:extend()

function Checkpoint:new(data)
	Environment.new(self, _:merge(data, {
		--@overrides
		name     = 'Checkpoint',
		isSensor = true
	}))
	--
	-- properties
	self.state = 'inactive'
	self.col   = _.__floor(data.x / Config.tileSize)
	self.row   = _.__floor(data.y / Config.tileSize)

	--
	self.sprite = Animator()
	-- inactive state
	self.sprite:addAnimation('inactive', {
		image  = Config.image.spritesheet.effect.flame3,
		width  = 14,
		height = 54,
		frames = {{ 1, 1, 6, 5 }}
	})
	-- active state
	self.sprite:addAnimation('active', {
		image  = Config.image.spritesheet.effect.flame4,
		width  = 16,
		height = 58,
		frames = {{ 1, 1, 6, 5 }}
	})

	-- scaling
	self.sx = 1
	self.sy = 1
end

-- Set Player Checkpoint
--
function Checkpoint:beginContact(other, col)
	if col:isTouching() then
		if other.name == 'Player' then
			Gamestate:current():setCheckpoint(self)
		end
	end
end

-- Attempt to change state
--
function Checkpoint:setState(name)
	if self.state ~= name then
	-- Change in states
		self.state = name
		self.sprite:switchTo(name)
	end
end

-- Update
--
function Checkpoint:update(dt)
	self:setState(Config.world.checkpoint.id == self.id and 'active' or 'inactive')
	--
	self.sprite:update(dt)
end

-- Draw
--
function Checkpoint:draw()
	local cx, cy  = self:getPosition()
	local w, h    = self.sprite:dimensions()
	local sx, sy  = self.sx, self.sy
	local r, g, b = unpack(Config.color.white)

	lg.setColor(r, g, b, 0.8)
	self.sprite:draw(cx, cy, 0, sx, sy, w/2, h/2)
	--
	Environment.draw(self)
end

return Checkpoint