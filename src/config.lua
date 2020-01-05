-- Configurations
-- Shane Krolikowski
--

Config = {
    width   = lg.getWidth(),
    height  = lg.getHeight(),
    padding = 15,
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
        weapon = {
            pistol = {
                animation = lg.newImage('res/spritesheets/particles/handgun_35x6.png'),
                maxRounds = 100,
                cooldown  = 0.5,
                damage    = 10,
                speed     = 1000,
                audio = {
                    fire = la.newSource('res/sfx/pistol.ogg', 'static'),
                    -- empty = la.newSource('res/sfx/.ogg', 'static')
                }
            },
        },
        player = {
            location = 'Spaceship',
            health = 100,
            shield = 35,
            weapon = {
                name   = 'pistol',
                rounds = 24,
            },
        },
        filter = {
            group = {
                environment = 1,
                unit        = -1,
                sensor      = 0,
                event       = 0,
            },
            category = {
                default     = 1,
                environment = 2,
                unit        = 3,
                sensor      = 4,
                event       = 5,
            },
            mask = {
                environment = { },
                unit        = { },
                sensor      = { 5 },
                event       = { },
            }
        }
    },
    color = {
        debug  = { _:color('red-800') },
    	white  = { _:color('white') },
    	black  = { _:color('black') },
    	shape  = { _:color('green-300') },
        sensor = {
            event  = { _:color('blue-400') },
            hitbox = { _:color('red-400') },
            sight  = { _:color('yellow-300') },
            strike = { _:color('purple-300') },
            projectile = { _:color('yellow-400') },
            dispatcher = { _:color('orange-400') },
        }
    },
    ui = {
        -- cursor = lm.newCursor('res/ui/cursors/.png'),
        font = {
            xs = lg.newFont('res/ui/fonts/Marksman.ttf', 16),
            sm = lg.newFont('res/ui/fonts/Marksman.ttf', 18),
            md = lg.newFont('res/ui/fonts/Marksman.ttf', 24),
            lg = lg.newFont('res/ui/fonts/Marksman.ttf', 32),
        },
        hud = {
            player   = lg.newImage('res/ui/HUD_health.png'),
            dialogue = lg.newImage('res/ui/Dialogue.png'),
        }
    },
    image = {
        spritesheet = {
            player = {
                aim       = lg.newImage('res/spritesheets/player/idleaim.png'),
                crouchAim = lg.newImage('res/spritesheets/player/crouchaim.png'),
                crouch    = lg.newImage('res/spritesheets/player/crouch.png'),
                death     = lg.newImage('res/spritesheets/player/death.png'),
                idle      = lg.newImage('res/spritesheets/player/idle.png'),
                jump      = lg.newImage('res/spritesheets/player/jump.png'),
                jumpAim   = lg.newImage('res/spritesheets/player/jumpaim.png'),
                run       = lg.newImage('res/spritesheets/player/run.png'),
                slide     = lg.newImage('res/spritesheets/player/guard.png'),
                runAim    = lg.newImage('res/spritesheets/player/aimrun.png'),
                talk      = lg.newImage('res/spritesheets/player/talking.png'),
                walk      = lg.newImage('res/spritesheets/player/walk.png'),
            },
            doctor = {
                death = lg.newImage('res/spritesheets/doctor/death.png'),
                idle  = lg.newImage('res/spritesheets/doctor/idle.png'),
                jump  = lg.newImage('res/spritesheets/doctor/jump.png'),
                run   = lg.newImage('res/spritesheets/doctor/run.png'),
                talk  = lg.newImage('res/spritesheets/doctor/talking.png'),
                walk  = lg.newImage('res/spritesheets/doctor/walk.png'),
            },
            enemies = {
                executioner    = lg.newImage('res/spritesheets/enemies/executioner.png'),
                fire_golem     = lg.newImage('res/spritesheets/enemies/fire-golem.png'),
                ghoul          = lg.newImage('res/spritesheets/enemies/ghoul.png'),
                ice_golem      = lg.newImage('res/spritesheets/enemies/ice-golem.png'),
                imp            = lg.newImage('res/spritesheets/enemies/imp.png'),
                necromancer    = lg.newImage('res/spritesheets/enemies/necromancer.png'),
                phantom_knight = lg.newImage('res/spritesheets/enemies/phantom-knight.png'),
                reaper         = lg.newImage('res/spritesheets/enemies/reaper.png'),
                slug           = lg.newImage('res/spritesheets/enemies/slug.png'),
                undead_warrior = lg.newImage('res/spritesheets/enemies/undead-warrior.png'),
            },
            particles = {
                warp                   = lg.newImage('res/spritesheets/particles/level_up_102x135.png'),
                imp_projectile         = lg.newImage('res/spritesheets/enemies/imp-projectile.png'),
                necromancer_projectile = lg.newImage('res/spritesheets/enemies/necromancer-projectile.png'),
            },
            emote = {
                speech  = Spritesheet('res/spritesheets/emotes/vector_style3.json'),
                thought = Spritesheet('res/spritesheets/emotes/vector_style5.json'),
                free    = Spritesheet('res/spritesheets/emotes/vector_style8.json'),
            },
            ui = Spritesheet('res/spritesheets/ui/sheet.json')
        },
        sprites = {
            arm = {
                player_aim = lg.newImage('res/sprites/arms/player_aim.png'),
            },
            comment  = lg.newImage('res/sprites/comment.png'),
            spikes   = lg.newImage('res/sprites/spikes.png'),
            platform = {
                mountains = lg.newImage('res/sprites/platforms/mountains.png'),
                spaceship = lg.newImage('res/sprites/platforms/spaceship.png'),
            }
        },
    }
}