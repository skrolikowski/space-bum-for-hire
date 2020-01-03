-- Entity Behavior
-- Shane Krolikowski
--

local Modern   = require 'modern'
local Behavior = Modern:extend()

function Behavior:new(name, host)
	local x, y, w, h = unpack(host.shapeData)
	local sw, sh     = self.sprite:dimensions()

	self.name     = host.name .. '_' .. name
	self.host     = host
	self.hitboxes = {}

	-- scale to fit bounds
	self.sx = w / sw
	self.sy = h / sh

	self:setBounds()
	self:setEntityShape()
	self:setHitBoxes()
end

-- Tear Down
--
function Behavior:destroy()
	for i = #self.hitboxes, 1, -1 do
		self.hitboxes[i]:destroy()
	end

	self.hitboxes = {}
end

-- Create fixture/shape for entity around sprite
--
function Behavior:setEntityShape()
	if self.host.shape then
		local cw, ch = self.host.shape:dimensions()
		local nw, nh = self.bounds:dimensions()

		-- only update shape if dimension changes
		-- 
		if _.__abs(cw - nw) > 1 or _.__abs(ch - nh) > 1 then
			self.host:setFixture('rectangle', self.bounds:container())
		end
	else
		self.host:setFixture('rectangle', self.bounds:container())
	end
end

-- Set bounding box for behavior
--
function Behavior:setBounds()
	self.bounds = AABB:fromContainer(unpack(host.shapeData))
end

-- Set hit boxes for behavior
--
function Behavior:setHitBoxes()
	--
end

-- Add a Hit Box
--
function Behavior:addHitBox(name, shape, multiplier)
	if not self.hitboxes[name] then
		self.hitboxes[name] = Sensors['hitbox'](self.host)
		self.hitboxes[name]:setShape(shape)
		self.hitboxes[name]:setMultiplier(multiplier or 1)
	end
end

-- Remove a Hit Box
--
function Behavior:removeHitBox(name)
	if self.hitboxes[name] then
		self.hitboxes[name]:destroy()
		self.hitboxes[name] = nil
	end
end

-- Handle collision detection
--
function Behavior:beginContact(other, col)
	--
end

-- Handle separation
--
function Behavior:endContact(other, col)
	--
end

-- Update behavior
--
function Behavior:update(dt)
	self.sprite:update(dt)
end

-- Draw behavior
--
function Behavior:draw()
	local cx, cy     = self.host:getPosition()
	local w, h       = self.sprite:dimensions()
	local sx, sy     = (self.sx or 1), (self.sy or 1)
	local isMirrored = self.host.isMirrored
	local isFlipped  = self.host.isFlipped
	-- local stateName  = self.name .. '\n'

	local ox = w/2 + (self.ox or 0)
	local oy = h/2 + (self.oy or 0)

	if isMirrored then sx = -sx end
	if isFlipped  then sy = -sy end

	lg.setColor(Config.color.white)
	self.sprite:draw(cx, cy, 0, sx, sy, ox, oy)

	-- -- display state
	-- if self.host.locking  then stateName = stateName .. 'L' end
	-- if self.host.shooting then stateName = stateName .. 'S' end

	-- lg.setColor(Config.color.white)
	-- lg.setFont(Config.ui.font.sm)
	-- lg.printf(stateName, cx - w/2, cy - h/2, w, 'center')
	-- love.graphics.printf(self.host.axis:heading(), cx - w/2, cy - h, w, 'center')
end

return Behavior