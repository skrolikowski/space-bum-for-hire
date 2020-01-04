-- Tower Defense
-- Shane Krolikowski
--
la = love.audio
lp = love.physics
lm = love.mouse
lx = love.math
lg = love.graphics

lg.setDefaultFilter('nearest', 'nearest')
--
require 'src.config'

-- Vendor packages
Inspect   = require 'inspect'
Camera    = require 'vendor.hump.camera'
Gamestate = require 'vendor.hump.gamestate'
Timer     = require 'vendor.hump.timer'

function love.load()
    _Camera = Camera(0, 0, 2)

    Gamestate.registerEvents()
    Gamestate.switch(Gamestates['spaceship'])

    -- keyboard events
    _Keys = {}
    _:on('key_escape_on', function() love.event.quit() end)
end

-- -- Update
-- --
function love.update(dt)
    Timer.update(dt)
    --
    -- Controls - Key Down
    for key, time in pairs(_Keys) do
        _Keys[key] = time + dt

        _:dispatch('key_' .. key .. '_down', dt, _Keys[key])
    end
end

-- Controls - Key Pressed
--
function love.keypressed(key)
    _:dispatch('key_' .. key .. '_on')
    
    _Keys[key] = 0
end

-- Controls - Key Released
--
function love.keyreleased(key)
    _:dispatch('key_' .. key .. '_off')
    _Keys[key] = nil
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