-- Configurations
-- Shane Krolikowski
--

Config = {
    width    = lg.getWidth(),
    height   = lg.getHeight(),
    scale    = 2,
    tileSize = 16,
    padding  = 15,
    map = {
        xOffset = 0,
        yOffset = 0,
    },
    spawn = {
        width  = 80,
        height = 80,
    },
    world = {
        meter   = 32,  -- Config.tileSize * Config.scale
        gravity = { x = 0, y = 40 },
        categories = {
            civilians = 1,
            enemies   = 2,
            platforms = 3,
            walls     = 4,
        },
        maps = {
            space00 = 'res/maps/WarpRoom.lua',
            space01 = 'res/maps/Spaceship.lua',
            mount01 = 'res/maps/Mountains.lua',
        },
        pickup = {
            health  = { sm = 10 },
            shield  = {},
            bullets = { sm = 12, md = 24, lg = 50 },
        },
        -- Player HUD
        --
        hud = {
            image     = lg.newImage('res/ui/HUD_health.png'),
            location  = 'Warp Room',
            objective = false,
            weapon    = 'pistol',
            stat      = {
                health = { now = 100, max = 100 },
                shield = { now = 0,   max = 35  },
            },
            ammo = {
                bullets = { now = 100, max = 100 },
                shells  = { now = 24,  max = 24  },
                plasma  = { now = 6,   max = 6 },
            },
        },
        weapon = {
            pistol = {
                name        = 'pistol',
                clip        = 'bullets',
                cooldown    = 0.35,
                attack      = 10,
                decay       = 1,
                speed       = 1000,
                spritesheet = 'item',
            },
            shotgun = {
                name        = 'shotgun',
                clip        = 'shells',
                cooldown    = 1.25,
                attack      = 30,
                decay       = 10,
                speed       = 800,
                spritesheet = 'weapon',
            },
            raygun = {
                name        = 'raygun',
                clip        = 'plasma',
                cooldown    = 2,
                radius      = 8,
                attack      = 50,
                decay       = 10,
                speed       = 300,
                spritesheet = 'weapon',
            },
        },
        filter = {
            group    = { effect = -2, unit = -1, environment = 1, event = 0, sensor = 0 },
            category = { default = 1, environment = 2, unit = 3, sensor = 4, event = 5 },
            mask     = {
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
            xs = lg.newFont('res/ui/fonts/Marksman.ttf', 18),
            sm = lg.newFont('res/ui/fonts/Marksman.ttf', 24),
            md = lg.newFont('res/ui/fonts/Marksman.ttf', 32),
            lg = lg.newFont('res/ui/fonts/Marksman.ttf', 48),
            xl = lg.newFont('res/ui/fonts/Marksman.ttf', 64),
        },
        munitions = {
            sm = lg.newFont('res/ui/fonts/Improbable.ttf', 16),
            md = lg.newFont('res/ui/fonts/Improbable.ttf', 24),
        }
    },
    audio = {
        pistol     = la.newSource('res/sfx/GUN_FIRE-GoodSoundForYou-820112263.wav', 'static'),
        shotgun    = la.newSource('res/sfx/shotgun-mossberg590-RA_The_Sun_God-451502290.wav', 'static'),
        raygun     = la.newSource('res/sfx/ray_gun-Mike_Koenig-1169060422.wav', 'static'),
        warp       = la.newSource('res/sfx/shooting_star-Mike_Koenig-1132888100.wav', 'static'),
        dryfire    = la.newSource('res/sfx/Dry Fire Gun-SoundBible.com-2053652037.wav', 'static'),
        ammoPickup = la.newSource('res/sfx/Pump Shotgun-SoundBible.com-1653268682.wav', 'static'),
        itemPickup = la.newSource('res/sfx/Pop Clip In-SoundBible.com-583746573.wav', 'static'),
    },
    image = {
        cast = {
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
            double = {
                {
                    crouch = lg.newImage('res/spritesheets/player/crouch.png'),
                    death  = lg.newImage('res/spritesheets/player/death.png'),
                    guard  = lg.newImage('res/spritesheets/player/guard.png'),
                    idle   = lg.newImage('res/spritesheets/player/idle.png'),
                    melee  = lg.newImage('res/spritesheets/player/melee.png'),
                    jump   = lg.newImage('res/spritesheets/player/jump.png'),
                    run    = lg.newImage('res/spritesheets/player/run.png'),
                    talk   = lg.newImage('res/spritesheets/player/talking.png'),
                    walk   = lg.newImage('res/spritesheets/player/walk.png'),
                }
            },
            doctor = {
                {
                    crouch = lg.newImage('res/spritesheets/doctor/crouch.png'),
                    death  = lg.newImage('res/spritesheets/doctor/death.png'),
                    guard  = lg.newImage('res/spritesheets/doctor/guard.png'),
                    idle   = lg.newImage('res/spritesheets/doctor/idle.png'),
                    melee  = lg.newImage('res/spritesheets/doctor/melee.png'),
                    jump   = lg.newImage('res/spritesheets/doctor/jump.png'),
                    run    = lg.newImage('res/spritesheets/doctor/run.png'),
                    talk   = lg.newImage('res/spritesheets/doctor/talking.png'),
                    walk   = lg.newImage('res/spritesheets/doctor/walk.png'),
                },
                {
                    crouch = lg.newImage('res/spritesheets/doctor/crouchB.png'),
                    death  = lg.newImage('res/spritesheets/doctor/deathB.png'),
                    guard  = lg.newImage('res/spritesheets/doctor/guardB.png'),
                    idle   = lg.newImage('res/spritesheets/doctor/idleB.png'),
                    melee  = lg.newImage('res/spritesheets/doctor/meleeB.png'),
                    jump   = lg.newImage('res/spritesheets/doctor/jumpB.png'),
                    run    = lg.newImage('res/spritesheets/doctor/runB.png'),
                    talk   = lg.newImage('res/spritesheets/doctor/talkingB.png'),
                    walk   = lg.newImage('res/spritesheets/doctor/walkB.png'),
                },
            },
            executioner = lg.newImage('res/spritesheets/enemies/executioner.png'),
            -- fire_golem     = lg.newImage('res/spritesheets/enemies/fire-golem.png'),
            -- ghoul          = lg.newImage('res/spritesheets/enemies/ghoul.png'),
            -- ice_golem      = lg.newImage('res/spritesheets/enemies/ice-golem.png'),
            -- imp            = lg.newImage('res/spritesheets/enemies/imp.png'),
            -- necromancer    = lg.newImage('res/spritesheets/enemies/necromancer.png'),
            -- phantom_knight = lg.newImage('res/spritesheets/enemies/phantom-knight.png'),
            -- reaper         = lg.newImage('res/spritesheets/enemies/reaper.png'),
            -- slug           = lg.newImage('res/spritesheets/enemies/slug.png'),
            -- undead_warrior = lg.newImage('res/spritesheets/enemies/undead-warrior.png'),
        },
        spritesheet = {
            effect = {
                attack      = lg.newImage('res/spritesheets/effects/attack100x100.png'),
                explosion1  = lg.newImage('res/spritesheets/effects/explosion_47x57.png'),
                explosion2  = lg.newImage('res/spritesheets/effects/explosion_short_57x56.png'),
                fireball    = lg.newImage('res/spritesheets/effects/fireball_42x89.png'),
                flame1      = lg.newImage('res/spritesheets/effects/flame_continously_66x47.png'),
                flame2      = lg.newImage('res/spritesheets/effects/flames_pulse_65x43.png'),
                flame3      = lg.newImage('res/spritesheets/effects/flame_small_blue14x54.png'),
                flame4      = lg.newImage('res/spritesheets/effects/flame_small_16x58.png'),
                imp_proj    = lg.newImage('res/spritesheets/effects/imp-projectile.png'),
                pistol      = lg.newImage('res/spritesheets/effects/handgun_35x6.png'),
                shotgun     = lg.newImage('res/spritesheets/effects/gunshot_60x8.png'),
                rifle       = lg.newImage('res/spritesheets/effects/gunshot_rifle_46x26.png'),
                laser       = lg.newImage('res/spritesheets/effects/laser_charge_129x38.png'),
                scratch     = lg.newImage('res/spritesheets/effects/scratch_79x64.png'),
                necro_proj  = lg.newImage('res/spritesheets/effects/necromancer-projectile.png'),
                warp        = lg.newImage('res/spritesheets/effects/level_up_102x135.png'),
            },
            emote = {
                speech  = Spritesheet('res/spritesheets/emotes/vector_style3.json'),
                thought = Spritesheet('res/spritesheets/emotes/vector_style5.json'),
                free    = Spritesheet('res/spritesheets/emotes/vector_style8.json'),
            },
            avatars = Spritesheet('res/spritesheets/ui/avatars.json'),
            ui      = Spritesheet('res/spritesheets/ui/sheet.json'),
            item    = Spritesheet('res/spritesheets/items/items.json'),
            weapon  = Spritesheet('res/spritesheets/items/weapons.json'),
        },
        sprites = {
            arm = {
                player = lg.newImage('res/sprites/arms/player_aim.png'),
            },
            comment  = lg.newImage('res/sprites/comment.png'),
            spikes   = lg.newImage('res/sprites/spikes.png'),
            platform = {
                mountains = lg.newImage('res/sprites/platforms/mountains.png'),
                spaceship = lg.newImage('res/sprites/platforms/spaceship.png'),
            },
            dialogue = {
                speech = lg.newImage('res/sprites/speech.png'),
            },
            spacedoor = lg.newImage('res/sprites/spacedoor.png'),
            narration = lg.newImage('res/sprites/narration.png'),
        },
    }
}