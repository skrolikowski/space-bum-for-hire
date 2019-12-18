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
        },
        player = {
            rounds = {
                pistol = 100
            }
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
        font = {
            sm = lg.newFont('res/ui/fonts/Improbable.ttf', 10),
            md = lg.newFont('res/ui/fonts/Improbable.ttf', 16),
            lg = lg.newFont('res/ui/fonts/Improbable.ttf', 18),
        },
    },
    audio = {
        round = {
            pistol = la.newSource('res/sfx/pistol.ogg', 'static'),
        }
    },
    image = {
        spritesheet = {
            cyberpunk = {
                crouch     = lg.newImage('res/spritesheets/cyberpunk/cyberpunk_crouch.png'),
                crouchAim  = lg.newImage('res/spritesheets/cyberpunk/cyberpunk_crouchpistolaim.png'),
                death      = lg.newImage('res/spritesheets/cyberpunk/cyberpunk_death.png'),
                idle       = lg.newImage('res/spritesheets/cyberpunk/cyberpunk_idle.png'),
                jump       = lg.newImage('res/spritesheets/cyberpunk/cyberpunk_jump.png'),
                jumpAim    = lg.newImage('res/spritesheets/cyberpunk/cyberpunk_jumppistolaim.png'),
                aim        = lg.newImage('res/spritesheets/cyberpunk/cyberpunk_pistolaim.png'),
                run        = lg.newImage('res/spritesheets/cyberpunk/cyberpunk_run.png'),
                slide      = lg.newImage('res/spritesheets/cyberpunk/cyberpunk_guard.png'),
                runAim     = lg.newImage('res/spritesheets/cyberpunk/cyberpunk_pistolaimrun.png'),
                runAimUp   = lg.newImage('res/spritesheets/cyberpunk/cyberpunk_pistolaimrunup.png'),
                runAimDown = lg.newImage('res/spritesheets/cyberpunk/cyberpunk_pistolaimrundown.png'),
                talk       = lg.newImage('res/spritesheets/cyberpunk/cyberpunk_talking.png'),
                walk       = lg.newImage('res/spritesheets/cyberpunk/cyberpunk_walk.png'),
            },
            particles = {
                pistol = lg.newImage('res/spritesheets/particles/handgun_35x6.png'),
                warp   = lg.newImage('res/spritesheets/particles/level_up_102x135.png'),
            },
        },
        sprites = {
            platform = lg.newImage('res/sprites/platform.png'),
            spikes   = lg.newImage('res/sprites/spikes.png'),
        },
    }
}