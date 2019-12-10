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
                crouch     = lg.newImage('res/spritesheets/CyberPunk/CyberPunk_Crouch.png'),
                crouchAim  = lg.newImage('res/spritesheets/CyberPunk/CyberPunk_CrouchPistolAim.png'),
                death      = lg.newImage('res/spritesheets/CyberPunk/CyberPunk_Death.png'),
                idle       = lg.newImage('res/spritesheets/CyberPunk/CyberPunk_Idle.png'),
                jump       = lg.newImage('res/spritesheets/CyberPunk/CyberPunk_Jump.png'),
                jumpAim    = lg.newImage('res/spritesheets/CyberPunk/CyberPunk_JumpPistolAim.png'),
                aim        = lg.newImage('res/spritesheets/CyberPunk/CyberPunk_PistolAim.png'),
                run        = lg.newImage('res/spritesheets/CyberPunk/CyberPunk_Run.png'),
                stop       = lg.newImage('res/spritesheets/CyberPunk/CyberPunk_Guard.png'),
                runAim     = lg.newImage('res/spritesheets/CyberPunk/CyberPunk_PistolAimRun.png'),
                runAimUp   = lg.newImage('res/spritesheets/CyberPunk/CyberPunk_PistolAimRunDown.png'),
                runAimDown = lg.newImage('res/spritesheets/CyberPunk/CyberPunk_PistolAimRunUp.png'),
                talk       = lg.newImage('res/spritesheets/CyberPunk/CyberPunk_Talking.png'),
                walk       = lg.newImage('res/spritesheets/CyberPunk/CyberPunk_Walk.png'),
            }
        }
    }
}