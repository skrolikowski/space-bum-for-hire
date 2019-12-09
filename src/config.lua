-- Configurations
-- Shane Krolikowski
--

Config = {
    width  = lg.getWidth(),
    height = lg.getHeight(),
    map = {
        xOffset = 0,
        yOffset = 0,
    },
    world = {
        meter   = 32,
        gravity = { x = 0, y = 40 },
        categories = {
            civilians = 1,
            enemies   = 2,
            platforms = 3,
            walls     = 4,
        }
    },
    color = {
    	white   = { _:color('white') },
    	black   = { _:color('black') },
    	shape   = { _:color('green-300') },
    	heading = { _:color('red-600') },
    },
    ui = {
        -- cursor = lm.newCursor('res/ui/cursors/.png'),
        fonts = {
            sm = lg.newFont('res/ui/fonts/Improbable.ttf', 16),
            md = lg.newFont('res/ui/fonts/Improbable.ttf', 18),
            lg = lg.newFont('res/ui/fonts/Improbable.ttf', 24),
        },
    },
    image = {
        spritesheet = {
            cyberpunk = {
                idle = lg.newImage('res/spritesheets/CyberPunk/CyberPunk_Idle.png'),
                idle = lg.newImage('res/spritesheets/CyberPunk/CyberPunk_Idle.png'),
                idle = lg.newImage('res/spritesheets/CyberPunk/CyberPunk_Idle.png'),
                idle = lg.newImage('res/spritesheets/CyberPunk/CyberPunk_Idle.png'),
                idle = lg.newImage('res/spritesheets/CyberPunk/CyberPunk_Idle.png'),
                idle = lg.newImage('res/spritesheets/CyberPunk/CyberPunk_Idle.png'),
            }
        }
    }
}