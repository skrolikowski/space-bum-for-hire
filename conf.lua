require 'lua-lander'
--

-- Vendor packages
Inspect = require 'inspect'
-- Camera  = require 'vendor.hump.camera'
Camera  = require 'vendor.STALKER-X.Camera'
-- Gamestate = require 'vendor.hump.gamestate'
-- Timer     = require 'vendor.hump.timer'

-- Globals
require 'src.entities'
require 'src.world'
require 'src.utils'
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
    t.window.width      = 1280
    t.window.height     = 800
    t.window.fullscreen = false
    t.window.highdpi    = true
    t.window.vsync      = true

    t.modules.touch   = false
    t.modules.thread  = false
    t.modules.video   = false
end