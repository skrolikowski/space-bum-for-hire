-- Configurations
-- Shane Krolikowski
--

Config = {
    width    = lg.getWidth(),
    height   = lg.getHeight(),
    scale    = 2,
    tileSize = 16,
    padding  = 15,
    spawn = { width = 80, height = 80 },
    world = {
        meter = 32,
        gravity = { x = 0, y = 40 },
        maps = {
            -- cutscenes
            cut01  = 'res/maps/space00.lua',
            cut02  = 'res/maps/cut02.lua',
            cut03  = 'res/maps/cut03.lua',
            cut04  = 'res/maps/cut04.lua',
            -- gameplay
            space00 = 'res/maps/space00.lua',
            space01 = 'res/maps/space01.lua',
            mount01 = 'res/maps/mount01.lua',
            mount02 = 'res/maps/mount02.lua',
            mount03 = 'res/maps/mount03.lua',
        },
        pickup = {
            health  = { sm = 35, md = 50 },
            shield  = {},
            bullets = { sm = 12, md = 24, lg = 50 },
            shells  = { sm = 4, md  = 8,  lg = 20 },
        },
        -- Enemy Settings
        --
        enemy = {
            Executioner = {
                health     = { min = 100, max = 125 },
                speed      = 475,
                jumpHeight = 3000,
                timing = { unrest = 1 },
                attack = { damage = { min = 30, max = 45 }, sx = 0.5, sy = 0.8 },
                sight  = { distance = 250, periphery = _.__pi / 16 },
                sprite = {
                    width  = 87,
                    height = 59,
                    frames = {
                        attack = { { 3, 1, 3, 5 }, { 4, 1, 4, 1 } },
                        die    = { { 5, 1, 5, 5 }, { 6, 1, 6, 3 } },
                        fall   = { { 7, 3, 7, 4 } },
                        hurt   = { { 4, 2, 4, 5 } },
                        jump   = { { 7, 1, 7, 2 }, { 6, 4, 6, 5 } },
                        idle   = { { 1, 1, 1, 4 } },
                        run    = { { 1, 5, 1, 5 }, { 2, 1, 2, 5 } },
                        slide  = { { 4, 2, 4, 5 } },
                    },
                },
            },
            Ghoul = {
                health     = { min = 30, max = 40 },
                speed      = 600,
                jumpHeight = 3000,
                timing = { unrest = 0.5 },
                attack = {
                    damage   = { min = 10, max = 15 },
                    distance = 100,
                    sx       = 0.3,
                    sy       = 0.5,
                },
                sight = {distance = 350, periphery = _.__pi / 20 },
                sprite = {
                    width  = 51,
                    height = 20,
                    frames = {
                        attack = { { 3, 3, 3, 4 }, { 4, 1, 4, 3 } },
                        die    = { { 5, 3, 5, 4 }, { 6, 1, 6, 2 } },
                        fall   = { { 8, 3, 8, 4 } },
                        hurt   = { { 4, 4, 4, 4 }, { 5, 1, 5, 2 } },
                        jump   = { { 7, 3, 7, 4 }, { 8, 1, 8, 2 } },
                        idle   = { { 1, 1, 1, 4 } },
                        run    = { { 2, 1, 2, 4 }, { 3, 1, 3, 2 } },
                        slide  = { { 4, 4, 4, 4 }, { 5, 1, 5, 2 } },
                    },
                },
            },
            DarkMage = {
                health = { min = 75, max = 100 },
                speed  = 500,
                timing = { unrest = 1.5, cooldown = 0.75 },
                attack = {
                    damage   = { min = 25, max = 50 },
                    distance = 350,
                    decay    = 1,
                    speed    = 150,
                    radius   = 5,
                },
                sight  = { distance = 400, periphery = _.__pi / 4 },
                sprite = {
                    width  = 60,
                    height = 61,
                    frames = {
                        attack = { { 2, 5, 2, 6 }, { 3, 1, 3, 3 } },
                        die    = { { 5, 1, 5, 6 }, { 6, 1, 6, 4 } },
                        fall   = { { 7, 3, 7, 4 } },
                        hurt   = { { 4, 4, 4, 6 } },
                        jump   = { { 6, 5, 6, 6 }, { 7, 1, 7, 2 } },
                        idle   = { { 1, 1, 1, 4 } },
                        run    = { { 1, 5, 1, 6 }, { 2, 1, 2, 4 } },
                        slide  = { { 4, 4, 4, 6 } },
                        summon = { { 3, 4, 3, 6 }, { 4, 1, 4, 3 } },
                    },
                },
            },
            Boss = {
                health = 300,
                speed  = 500,
                timing = { cooldown = 0.65 },
                attack = {
                    damage   = 25,
                    distance = 300,
                    decay    = 1,
                    speed    = 250,
                    radius   = 10,
                },
                sight  = { distance = 275, periphery = _.__pi / 2 },
                sprite = {
                    width  = 60,
                    height = 61,
                    frames = {
                        attack = { { 2, 5, 2, 6 }, { 3, 1, 3, 3 } },
                        die    = { { 5, 1, 5, 6 }, { 6, 1, 6, 4 } },
                        fall   = { { 7, 3, 7, 4 } },
                        hurt   = { { 4, 4, 4, 6 } },
                        jump   = { { 6, 5, 6, 6 }, { 7, 1, 7, 2 } },
                        idle   = { { 1, 1, 1, 4 } },
                        run    = { { 1, 5, 1, 6 }, { 2, 1, 2, 4 } },
                        slide  = { { 4, 4, 4, 6 } },
                        summon = { { 3, 4, 3, 6 }, { 4, 1, 4, 3 } },
                    },
                },
            },
        },
        -- Player Checkpoint
        --
        checkpoint = {
            player = { id = 171, map = 'mount01', col = 10, row = 69 },
            pause  = {           map = 'space00', col = 5,  row = 17 },
        },
        quest = {
            {
                text   = 'Talk to Commander Scott.',
                sheet  = 'avatars',
                sprite = 'ensign',
                sx = 5, sy = 5,
            },
            {
                text   = 'Locate Ensign Victor on the Eastside.',
                sheet  = 'avatars',
                sprite = 'ensign',
                sx = 5, sy = 5,
            },
            {
                text   = 'Find Captain Jenny in West End.',
                sheet  = 'avatars',
                sprite = 'captain',
                sx = 5, sy = 5,
            },
            {
                text   = 'Find the dilithium crystals.',
                sheet  = 'item',
                sprite = 'mine03',
                sx = 3, sy = 3,
            }
        },
        -- Player HUD
        --
        hud = {
            image    = lg.newImage('res/ui/HUD_health.png'),
            location = 'Warp Room',
            quest    = 2,
            weapon   = 'pistol',
            stat     = {
                health = { now = 100, max = 100 },
                shield = { now = 0,   max = 35  },
            },
            ammo = {
                bullets = { now = 24, max = 50 },
                shells  = { now = 8,  max = 20 },
            },
        },
        weapon = {
            pistol = {
                name        = 'pistol',
                clip        = 'bullets',
                cooldown    = 0.35,
                damage      = { min = 25, max = 30 },
                radius      = 1,
                decay       = 1,
                speed       = 1000,
                spritesheet = 'item',
            },
            shotgun = {
                name        = 'shotgun',
                clip        = 'shells',
                cooldown    = 1.25,
                damage      = { min = 15, max = 18 },
                radius      = 3,
                decay       = 3,
                speed       = 800,
                spritesheet = 'weapon',
            },
        },
        filter = {
            group    = { text = -3, effect = -2, unit = -1, environment = 1, event = 0, sensor = 0 },
            category = {
                default = 1,
                environment = 2,
                unit = 3,
                sensor = 4,
                event = 5,
            },
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
        health = { _:color('red-600') },
    	white  = { _:color('white') },
    	black  = { _:color('black') },
        overlay = { 0, 0, 0, 0.65 },
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
            lg = lg.newFont('res/ui/fonts/Marksman.ttf', 44),
            xl = lg.newFont('res/ui/fonts/Marksman.ttf', 64),
        },
        munitions = {
            sm = lg.newFont('res/ui/fonts/Improbable.ttf', 16),
            md = lg.newFont('res/ui/fonts/Improbable.ttf', 24),
        }
    },
    audio = {
        -- player = {
        --     die = la.newSource('res/sfx/player/', 'static'),
        -- },
        enemy = {
            executioner = {
                hunt   = la.newSource('res/sfx/enemies/OGSoundFX/Monster_Raw Growl 5.wav', 'static'),
                attack = la.newSource('res/sfx/enemies/OGSoundFX/Monster Hit 4.wav', 'static'),
                die    = la.newSource('res/sfx/enemies/OGSoundFX/Monster In Pain_3.wav', 'static'),
            },
            ghoul = {
                hunt   = la.newSource('res/sfx/enemies/OGSoundFX/Cute Creature_8.wav', 'static'),
                attack = la.newSource('res/sfx/enemies/OGSoundFX/Cute Creature_11 - Growl.wav', 'static'),
                die    = la.newSource('res/sfx/enemies/OGSoundFX/Cute Creature_9 - Dying.wav', 'static'),
            },
            boss = {
                hunt   = la.newSource('res/sfx/enemies/OGSoundFX/Zombie_6.wav', 'static'),
                attack = la.newSource('res/sfx/enemies/OGSoundFX/Flare gun 4.wav', 'static'),
                die    = la.newSource('res/sfx/enemies/OGSoundFX/Zombie_5.wav', 'static'),
            },
            darkmage = {
                hunt   = la.newSource('res/sfx/enemies/OGSoundFX/Zombie_6.wav', 'static'),
                attack = la.newSource('res/sfx/enemies/OGSoundFX/Flare gun 4.wav', 'static'),
                die    = la.newSource('res/sfx/enemies/OGSoundFX/Zombie_5.wav', 'static'),
            }
        },
        weapon = {
            pistol  = la.newSource('res/sfx/weapon/SoundBible/GUN_FIRE-GoodSoundForYou-820112263.wav', 'static'),
            shotgun = la.newSource('res/sfx/weapon/SoundBible/shotgun-mossberg590-RA_The_Sun_God-451502290.wav', 'static'),
            dryfire = la.newSource('res/sfx/weapon/SoundBible/Dry Fire Gun-SoundBible.com-2053652037.wav', 'static'),
            shelldrop = la.newSource('res/sfx/weapon/OGSoundFX/Bullet Shell drop 3.wav', 'static'),
            impact  = {
                la.newSource('res/sfx/effects/OGSoundFX/Bullet rock Impact 1.wav', 'static'),
                la.newSource('res/sfx/effects/OGSoundFX/Bullet rock Impact 2.wav', 'static'),
                la.newSource('res/sfx/effects/OGSoundFX/Bullet rock Impact 3.wav', 'static'),
                la.newSource('res/sfx/effects/OGSoundFX/Bullet rock Impact 4.wav', 'static'),
            },
            pierce = {
                la.newSource('res/sfx/effects/OGSoundFX/Punch in the face 2.wav', 'static'),
                la.newSource('res/sfx/effects/OGSoundFX/Punch in the face 12 - Bloody Punch.wav', 'static'),
                la.newSource('res/sfx/effects/OGSoundFX/Punch in the face 20 - Bloody Impact.wav', 'static'),
            }
        },
        warp          = la.newSource('res/sfx/effects/SoundBible/shooting_star-Mike_Koenig-1132888100.wav', 'static'),
        shotgunPickup = la.newSource('res/sfx/effects/SoundBible/Pump Shotgun-SoundBible.com-1653268682.wav', 'static'),
        ammoPickup    = la.newSource('res/sfx/effects/SoundBible/Pump Shotgun-SoundBible.com-1653268682.wav', 'static'),
        itemPickup    = la.newSource('res/sfx/effects/SoundBible/Pop Clip In-SoundBible.com-583746573.wav', 'static'),
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
            captain = {
                {
                    crouch = lg.newImage('res/spritesheets/captain/crouch.png'),
                    death  = lg.newImage('res/spritesheets/captain/death.png'),
                    guard  = lg.newImage('res/spritesheets/captain/guard.png'),
                    idle   = lg.newImage('res/spritesheets/captain/idle.png'),
                    melee  = lg.newImage('res/spritesheets/captain/melee.png'),
                    jump   = lg.newImage('res/spritesheets/captain/jump.png'),
                    run    = lg.newImage('res/spritesheets/captain/run.png'),
                    talk   = lg.newImage('res/spritesheets/captain/talking.png'),
                    walk   = lg.newImage('res/spritesheets/captain/walk.png'),
                }
            },
            ensign = {
                {
                    crouch = lg.newImage('res/spritesheets/ensign/crouch.png'),
                    death  = lg.newImage('res/spritesheets/ensign/death.png'),
                    guard  = lg.newImage('res/spritesheets/ensign/guard.png'),
                    idle   = lg.newImage('res/spritesheets/ensign/idle.png'),
                    melee  = lg.newImage('res/spritesheets/ensign/melee.png'),
                    jump   = lg.newImage('res/spritesheets/ensign/jump.png'),
                    run    = lg.newImage('res/spritesheets/ensign/run.png'),
                    talk   = lg.newImage('res/spritesheets/ensign/talking.png'),
                    walk   = lg.newImage('res/spritesheets/ensign/walk.png'),
                }
            },
            engineer = {
                {
                    crouch = lg.newImage('res/spritesheets/engineer/crouch.png'),
                    death  = lg.newImage('res/spritesheets/engineer/death.png'),
                    guard  = lg.newImage('res/spritesheets/engineer/guard.png'),
                    idle   = lg.newImage('res/spritesheets/engineer/idle.png'),
                    melee  = lg.newImage('res/spritesheets/engineer/melee.png'),
                    jump   = lg.newImage('res/spritesheets/engineer/jump.png'),
                    run    = lg.newImage('res/spritesheets/engineer/run.png'),
                    talk   = lg.newImage('res/spritesheets/engineer/talking.png'),
                    walk   = lg.newImage('res/spritesheets/engineer/walk.png'),
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
            ghoul       = lg.newImage('res/spritesheets/enemies/ghoul.png'),
            darkmage    = lg.newImage('res/spritesheets/enemies/necromancer.png'),
            boss        = lg.newImage('res/spritesheets/enemies/necromancer.png'),
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
                slash1      = lg.newImage('res/spritesheets/effects/slash_83x81.png'),
                slash2      = lg.newImage('res/spritesheets/effects/slash2_83x81.png'),
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
                castle    = lg.newImage('res/sprites/platforms/castle.png'),
                spaceship = lg.newImage('res/sprites/platforms/spaceship.png'),
                boss      = lg.newImage('res/sprites/platforms/boss.png'),
            },
            pillar = {
                castle = lg.newImage('res/sprites/pillars/castle.png'),
            },
            dialogue = {
                speech = lg.newImage('res/sprites/speech.png'),
            },
            spacedoor = lg.newImage('res/sprites/spacedoor.png'),
            narration = lg.newImage('res/sprites/narration.png'),
        },
    }
}