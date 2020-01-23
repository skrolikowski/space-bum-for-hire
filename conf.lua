require 'lua-lander'
--

-- Globals
require 'src.entities'
require 'src.world'
require 'src.ui'
require 'src.utils'
require 'src.gamestates'
--

function love.conf(t)
    io.stdout:setvbuf('no')

    t.identity = 'not-moe-jam-9'
    t.version  = '11.2'
    t.console  = false

    t.window.title      = 'Star Crusader'
    -- t.window.icon       = 'res/ui/crossair_black.png'
    t.window.x          = 25
    t.window.y          = 25
    t.window.width      = 1280
    t.window.height     = 800
    t.window.fullscreen = false
    t.window.highdpi    = true
    t.window.vsync      = true

    t.modules.touch   = false
    t.modules.thread  = false
    t.modules.video   = false
end