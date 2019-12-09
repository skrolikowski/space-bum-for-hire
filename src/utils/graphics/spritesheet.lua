--=======================================
-- filename:    tools/graphics/spritesheet.lua
-- author:      Shane Krolikowski
-- created:     Sept, 2018
-- description: Sprite sheet helpler.
-- usage:
--  ss = SpriteSheet(../res/spritesheets/sheet.json)
--  ss:drawQuad("quad_name", 25, 25)
--=======================================

local JSON        = require 'vendor.json4lua.json'
local Modern      = require 'modern'
local SpriteSheet = Modern:extend()

function SpriteSheet:new(filePath)
    local path, name, extn = Utils:filenameSplit(filePath)
    local ok, message = pcall(love.filesystem.getInfo, filePath, "file")

    if not ok then
        print("Could not process spritesheet:", message)
    else
        contents = love.filesystem.read(filePath)
        json     = JSON.decode(contents)

        self.image = love.graphics.newImage(path .. "/" .. json["TextureAtlas"]["imagePath"])
        self.quads = {}

        for _, texture in ipairs(json["TextureAtlas"]["SubTexture"]) do
            self:quad(Utils:basename(texture.name), texture)
        end
    end
end

function SpriteSheet:quad(name, texture)
    if texture ~= nil then
        self.quads[name] = love.graphics.newQuad(texture.x, texture.y, texture.width, texture.height, self.image:getDimensions())
    end

    return self.quads[name]
end

function SpriteSheet:subquad(name, coords)
    local parent = { self:container(name) }
    local w      = coords['w'] or parent[3]
    local h      = coords['h'] or parent[4]
    local x      = coords['x'] or 0
    local y      = coords['y'] or 0

    w = (w < 0 and (parent[3] + w) or w)
    h = (h < 0 and (parent[4] + h) or h)
    x = (x < 0 and (parent[3] + x) or x) + parent[1]
    y = (y < 0 and (parent[4] + y) or y) + parent[2]

    return love.graphics.newQuad(x, y, w, h, self.image:getDimensions())
end

function SpriteSheet:getImage()
    return self.image
end

function SpriteSheet:dimensions(name)
    local x, y, w, h = self:container(name)

    return w, h
end

function SpriteSheet:width(name)
    local w, h = self:dimensions(name)

    return w
end

function SpriteSheet:height(name)
    local w, h = self:dimensions(name)

    return h
end

function SpriteSheet:container(name)
    return self.quads[name]:getViewport()
end

function SpriteSheet:draw(name, ...)
    love.graphics.draw(self.image, self.quads[name], ...)
end

function SpriteSheet:drawQuad(name, coords, ...)
    love.graphics.draw(self.image, self:subquad(name, coords), ...)
end

return SpriteSheet