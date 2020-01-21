-- Entity Behavior
-- Shane Krolikowski
--

local Modern   = require 'modern'
local Behavior = Modern:extend()

function Behavior:new(name, host)
	local x, y, w, h = unpack(host.shapeData)
	local sw, sh     = self.sprite:dimensions()

	self.name    = host.name .. '_' .. name
	self.host    = host
	self.sensors = {}
	self.color   = Config.color.white

	-- scale to fit bounds
	self.sx = w / sw
	self.sy = h / sh

	self:setBounds()
	self:setEntityShape()
	self:setSensors()
end

-- Tear Down
--
function Behavior:destroy()
	for i = #self.sensors, 1, -1 do
		self.sensors[i]:destroy()

		table.remove(self.sensors, i)
	end
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
	self.bounds = AABB:fromContainer(unpack(self.host.shapeData))
end

-- Set sensors for behavior
--
function Behavior:setSensors()
	--
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

	local ox = w/2 + (self.ox or 0)
	local oy = h/2 + (self.oy or 0)

	if isMirrored then sx = -sx end
	if isFlipped  then sy = -sy end

	lg.setColor(self.color)
	self.sprite:draw(cx, cy, 0, sx, sy, ox, oy)

	-- -- display state
	-- local stateName  = self.name .. '\n'
	-- if self.host.locking  then stateName = stateName .. 'L' end
	-- if self.host.shooting then stateName = stateName .. 'S' end

	-- lg.setColor(Config.color.white)
	-- lg.setFont(Config.ui.font.sm)
	-- lg.printf(stateName, cx - w/2, cy - h/2, w, 'center')
end

return Behavior