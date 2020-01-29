-- Shane Krolikowski
--
la = love.audio
lp = love.physics
lm = love.mouse
lx = love.math
lg = love.graphics

-- pixels please..
lg.setDefaultFilter('nearest', 'nearest')


-- load gamepad mappings
love.joystick.loadGamepadMappings('vendor/gamecontrollerdb.txt')

-- Vendor packages
Inspect   = require 'vendor.inspect.inspect'
Camera    = require 'vendor.hump.camera'
Gamestate = require 'vendor.hump.gamestate'
Timer     = require 'vendor.hump.timer'

-- configurations
require 'src.config'
require 'src.dialogue'
require 'src.credits'
require 'src.control'

function love.load()
    -- Control setup
    _Keys    = {}
    _Axes    = {}
    _Buttons = {}
    _BtnTrns = { 'A', 'B', 'X', 'Y', 'L', 'R', 'Select', 'Start' }

    -- Here's where it all begins...
    Gamestate.registerEvents()
    Gamestate.switch(Gamestates['cut01'])
    --
    ---------------------------------------------
    -- local checkpoint = {
    --     map = 'mount03',
    --     col = 33,
    --     row = 54,
    -- }
    -- Gamestate.switch(Gamestates[checkpoint.map], {
    --     from = 'beam',
    --     col  = checkpoint.col,
    --     row  = checkpoint.row
    -- })
    -- Config.world.hud.quest=5
    -- Gamestate:current().hud:set({
    --     name  = 'quest',
    --     value = Config.world.hud.quest
    -- })
    ---------------------------------------------
    --
    --
    Soundtrack:new(0.33)
    Soundtrack:addFolder('res/music/DOS-88')
    Soundtrack:shuffle()
    Soundtrack:play()
end

-- Update
--
function love.update(dt)
    -- Soundtrack:update(dt)
    --
    -- Controls - Key Down
    for code, time in pairs(_Keys) do
        _Keys[code] = time + dt

        _:dispatch('key_' .. code .. '_down', dt, _Keys[code])
    end

    -- Controls - Axis Down
    for code, time in pairs(_Axes) do
        _Axes[code] = time + dt

        _:dispatch('axis_' .. code .. '_down', dt, _Axes[code])
    end

    -- Controls - Button Down
    for code, time in pairs(_Buttons) do
        _Buttons[code] = time + dt

        _:dispatch('button_' .. code .. '_down', dt, _Buttons[code])
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

-- Controls - Joystick Axis
function love.joystickaxis(joystick, axis, value)
    recordAxisControl(axis, value)
end

-- Controls - Joystick Axis
function love.gamepadaxis(joystick, axis, value)
    recordAxisControl(axis, value)
end

-- Controls - Button Pressed
function love.joystickpressed(joystick, button)
    -- rename
    button = _BtnTrns[button]   

    _:dispatch('button_' .. button .. '_on')
    _Buttons[button] = 0
end

-- Controls - Button Released
function love.joystickreleased(joystick, button)
    -- rename
    button = _BtnTrns[button]   

    _:dispatch('button_' .. button .. '_off')
    _Buttons[button] = nil
end

-- Controls - Button Pressed
function love.gamepadpressed(joystick, button)
    -- rename
    button = _BtnTrns[button]   

    _:dispatch('button_' .. button .. '_on')
    _Buttons[button] = 0
end

-- Controls - Button Released
function love.gamepadreleased(joystick, button)
    -- rename
    button = _BtnTrns[button]   

    _:dispatch('button_' .. button .. '_off')
    _Buttons[button] = nil
end

----
--
--
function recordAxisControl(axis, value)
    if axis == 1 and value == -1 then
    -- Left
        _Axes['left'] = 0
        _:dispatch('axis_left_on')
    elseif axis == 1 and value == 1 then
    -- Right
        _Axes['right'] = 0
        _:dispatch('axis_right_on')
    elseif axis == 2 and value == -1 then
    -- Up
        _Axes['up'] = 0
        _:dispatch('axis_up_on')
    elseif axis == 2 and value == 1 then
    -- Down
        _Axes['down'] = 0
        _:dispatch('axis_down_on')
    elseif value == 0 then
    -- Release
        if _Axes['left'] ~= nil then
            _Axes['left'] = nil
            _:dispatch('axis_left_off')
        elseif _Axes['right'] ~= nil then
            _Axes['right'] = nil
            _:dispatch('axis_right_off')
        elseif _Axes['up'] ~= nil then
            _Axes['up'] = nil
            _:dispatch('axis_up_off')
        elseif _Axes['down'] ~= nil then
            _Axes['down'] = nil
            _:dispatch('axis_down_off')
        end
    end
end