-- Parallax Layer
-- Shane Krolikowski
--

local Modern = require 'modern'
local Layer  = Modern:extend()

function Layer:new(level, name, sx, sy, ox, oy)
    local image  = Config.image.layers[level][name]
    
    self.quad   = lg.newQuad(0, 0, _World.width, _World.height, image:getDimensions())
    self.canvas = lg.newCanvas(image:getDimensions())

    lg.setCanvas(self.canvas)
    lg.draw(image, self.quad)
    lg.setCanvas()

    self.canvas:setWrap('mirroredrepeat', 'clamp')
    --

    --
    self.sx = sx or 1
    self.sy = sy or 1
    self.ox = ox or 0
    self.oy = oy or 0
end

function Layer:update(dt, pX, pY)
    self.quad = love.graphics.newQuad(
        pX + self.ox,
        pY + self.oy,
        _World.width  * (1 / self.sx),
        _World.height * (1 / self.sy),
        self.canvas:getDimensions()
    )
end

function Layer:draw()
    love.graphics.setColor(Config.color.white)
    love.graphics.draw(self.canvas, self.quad, 0, 0, 0, self.sx, self.sy)
end

return Layer