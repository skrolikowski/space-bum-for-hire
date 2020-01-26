-- Shane Krolikowski
--
la = love.audio
lp = love.physics
lm = love.mouse
lx = love.math
lg = love.graphics

-- pixels please..
lg.setDefaultFilter('nearest', 'nearest')

-- Vendor packages
Inspect   = require 'vendor.inspect.inspect'
Camera    = require 'vendor.hump.camera'
Gamestate = require 'vendor.hump.gamestate'
Timer     = require 'vendor.hump.timer'

-- configurations
require 'src.config'
require 'src.dialogue'
require 'src.control'

function love.load()
    _Keys = {}

    -- Here's where it begins...
    Gamestate.registerEvents()
    -- Gamestate.switch(Gamestates['cut01'])

    --
    -- local checkpoint = Config.world.checkpoint.player
    local checkpoint = {
        map = 'mount03',
        col = 32,
        row = 52,
    }

    Gamestate.switch(Gamestates[checkpoint.map], {
        from = 'beam',
        col  = checkpoint.col,
        row  = checkpoint.row
    })
    --
    Soundtrack:new(0.5)
    Soundtrack:addFolder('res/music/DOS-88')
    Soundtrack:shuffle():play()
end

-- Update
--
function love.update(dt)
    Soundtrack:update(dt)
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