-- Tower Defense
-- Shane Krolikowski
--
la = love.audio
lp = love.physics
lm = love.mouse
lx = love.math
lg = love.graphics

--
require 'src.config'

lg.setBackgroundColor(_:color('gray-900'))

function love.load()
    local STI = require 'vendor.sti.sti'

    -- setup world/map
    -- _Map          = STI('res/maps/Mountains.lua')
    _Map          = STI('res/maps/Spikes.lua')
    _World        = World()
    _World.width  = _Map.width * _Map.tilewidth
    _World.height = _Map.height * _Map.tileheight

    -- setup camera
    _Camera = Camera()
    _Camera.scale = 2
    _Camera:setBounds(
        -- adjusting bounds for scale
        -Config.width  / _Camera.scale / 2,
        -Config.height / _Camera.scale / 2,
        _World.width  + Config.width / _Camera.scale,
        _World.height + Config.height / _Camera.scale
    )

    -- _Dialogue = Dialogue()

    -- spawn entities
    _Spawner = Spawner(_Map)

    -- keyboard events
    _Keys = {}
    _:on('key_escape_on', function() love.event.quit() end)
end

function love.update(dt)
    _Camera:update(dt)
	_World:update(dt)
    _Spawner:update(dt)

    -- Controls - Key Down
    for key, time in pairs(_Keys) do
        _Keys[key] = time + dt
        
        _:dispatch('key_' .. key .. '_down', dt, _Keys[key])
    end
end

-- Draw game world
--
function love.draw()
    _Camera:attach()
    --
    lg.setColor(Config.color.white)
    _Map:drawTileLayer('Platforms')

    -- _Map:drawTileLayer('Sharp Cliffs')
    -- _Map:drawTileLayer('Decoratives (BG)')
    -- _Map:drawTileLayer('Cliffs')
    -- _Map:drawTileLayer('Castle')
    -- _Map:drawTileLayer('Decoratives (MG)')
    -- _Map:drawTileLayer('Platforms')

	_World:draw()
    _Spawner:draw()

    -- lg.setColor(Config.color.white)
    -- _Map:drawTileLayer('Flora')
    
    _Camera:detach()
    -- _Camera:draw()
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