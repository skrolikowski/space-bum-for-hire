-- Configurations
-- Shane Krolikowski
--

Config = {
    width  = lg.getWidth(),
    height = lg.getHeight(),
    world  = {
    	meter   = 32,
    	gravity = { x = 0, y = 9.81 },
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
}