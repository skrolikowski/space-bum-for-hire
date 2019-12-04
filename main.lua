-- Tower Defense
-- Shane Krolikowski
--
lp = love.physics
lg = love.graphics

--
require 'src.config'

-- Vendor packages
-- Gamestate = require 'vendor.hump.gamestate'
-- Timer     = require 'vendor.hump.timer'

--
lg.setBackgroundColor(Config.color.white)

function love.load()
    _World  = World()
    _Player = Player(Config.width / 2, Config.height / 2)
    
    _:on('key_escape', function() love.event.quit() end)
end

function love.update(dt)
	_World:update(dt)
end

function love.draw()
	_World:draw()
end

-- Controls - Key Press
--
function love.keypressed(key)
    _:dispatch('key_' .. key)
end

-- Controls - Wheel Moved
--
function love.wheelmoved(x, y)
    if y > 0 then
        _:dispatch('wheel_up')
    elseif y < 0 then
        _:dispatch('wheel_down')
    end
end

-- Controls - Mouse Move
--
function love.mousemoved(x, y)
    -- _World:onHover(x, y)
end

-- Controls - Mouse Pressed
--
function love.mousepressed(x, y, button)
    -- _World:onClick(x, y, button)
end