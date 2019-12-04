require 'lua-lander'
--

-- Vendors
Inspect = require 'inspect'

-- Globals
Entities = require 'src.entities'
World    = require 'src.world'
Utils    = require 'src.utils'
--

function love.conf(t)
    io.stdout:setvbuf('no')

    t.identity = 'not-moe-jam-9'
    t.version  = '11.2'
    t.console  = false

    t.window.title      = 'Star Crusader'
    -- t.window.icon       = 'res/ui/crossair_black.png'
    t.window.x          = 125
    t.window.y          = 100
    t.window.width      = 600
    t.window.height     = 600
    t.window.fullscreen = false
    t.window.highdpi    = true
    t.window.vsync      = true

    t.modules.touch   = false
    t.modules.thread  = false
    t.modules.video   = false
end