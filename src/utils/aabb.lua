-- Physics - AABB
-- Shane Krolikowski
--

local Modern = require 'modern'
local AABB   = Modern:extend()

function AABB:new(...)
    local args = {...}

    self.left   = args[1]
    self.top    = args[2]
    self.right  = args[3]
    self.bottom = args[4]
end

function AABB:area()
    return self:width() * self.height()
end

function AABB:center()
    return _.__floor(self:width() / 2),
           _.__floor(self:height() / 2)
end

function AABB:width()
    return self.right - self.left
end

function AABB:height()
    return self.bottom - self.top
end

function AABB:dimensions()
  return self:width(), self:height()
end

function AABB:container()
    return self.left,
           self.top,
           self:width(),
           self:height()
end

function AABB:contains(other)
    return self.left   <= other.left  and
           self.right  >= other.right and
           self.top    <= other.top   and
           self.bottom >= other.bottom
end

function AABB:containsVec2(other)
    return self.left   <= other.x and
           self.right  >= other.x and
           self.top    <= other.y and
           self.bottom >= other.y
end

function AABB:intersects(other)
    return self.left   <= other.right  and
           self.right  >= other.left   and
           self.top    <= other.bottom and
           self.bottom >= other.top
end

function AABB:clamp(other)
    aabb = other:copy()

    if aabb.left < self.left then
        aabb.right = aabb.right + (self.left - aabb.left)
        aabb.left  = self.left
    end

    if aabb.right > self.right then
        aabb.left  = aabb.left - (aabb.right - self.right)
        aabb.right = self.right
    end

    if aabb.top < self.top then
        aabb.bottom = aabb.bottom + (self.top - aabb.top)
        aabb.top    = self.top
    end

    if aabb.bottom > self.bottom then
        aabb.top    = aabb.top - (aabb.bottom - self.bottom)
        aabb.bottom = self.bottom
    end

    return aabb
end

function AABB:unpack()
    return self.left,
           self.top,
           self.right,
           self.bottom
end

function AABB:draw()
    -- used for debugging..
    love.graphics.setColor(Config.color.debug)
    love.graphics.setLineWidth(1)
    love.graphics.rectangle('line', self:container())
end

--

function AABB:translate(tx, ty)
    return AABB:fromContainer(
        self.left + tx,
        self.top + ty,
        self:width(),
        self:height()
    )
end

function AABB:scale(sx, sy)
    sy = sy or sx
    
    return AABB:fromContainer(
        self.left,
        self.top,
        self:width()  * sx,
        self:height() * sy
    )
end

--

function AABB:__eq(other)
    return self.left   == other.left  and
           self.top    == other.top   and
           self.right  == other.right and
           self.bottom == other.bottom
end

function AABB:__tostring()
    return 'AABB(' .. self.left .. ', ' .. self.top .. ', ' .. self.right .. ', ' .. self.bottom .. ')'
end

--

function AABB:copy()
    return AABB(self:unpack())
end

function AABB:compute(cx, cy, width, height, rotation)
    -- calculate rotated vertices of each corner
    local x1, y1 = Vec2(-width / 2, -height / 2):rotate(rotation):unpack()
    local x2, y2 = Vec2( width / 2, -height / 2):rotate(rotation):unpack()
    local x3, y3 = Vec2( width / 2,  height / 2):rotate(rotation):unpack()
    local x4, y4 = Vec2(-width / 2,  height / 2):rotate(rotation):unpack()

    -- extents of rotated AABB
    local ex = _.__max(x1, x2, x3, x4)
    local ey = _.__max(y1, y2, y3, y4)

    -- new top,left/right/bottom coordinates
    x1 = cx - ex
    x2 = cx + ex
    y1 = cy - ey
    y2 = cy + ey

    return AABB(x1, y1, x2, y2)
end

function AABB:fromContainer(x, y, width, height)
    -- x      = _:assertArgument('x', x, 'number')
    -- y      = _:assertArgument('y', y, 'number')
    -- width  = _:assertArgument('width', width, 'number')
    -- height = _:assertArgument('height', height, 'number')
    --
    return AABB(x, y, x + width, y + height)
end

return AABB