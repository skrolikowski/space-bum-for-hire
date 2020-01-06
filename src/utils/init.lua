-- Game Utils
-- Shane Krolikowski
--

Util = {}
--

Vec2        = require 'src.utils.vec2'
AABB        = require 'src.utils.aabb'
Stack       = require 'src.utils.containers.stack'
Animator    = require 'src.utils.graphics.animator'
Spritesheet = require 'src.utils.graphics.spritesheet'

--
Shapes = {
	rectangle = require 'src.utils.shapes.rectangle',
	polygon   = require 'src.utils.shapes.polygon',
	edge      = require 'src.utils.shapes.edge',
	circle    = require 'src.utils.shapes.circle',
}

Cameras = {
	custom   = require 'src.utils.cameras.custom',
	cutscene = require 'src.utils.cameras.cutscene',
	player   = require 'src.utils.cameras.player',
}

--

function Util:toBoolean(value)
	local t = {}

	for __, v in pairs(value) do
		t[v] = true
	end

	return t
end

-- quick lua implementation of "random" UUID
-- https://gist.github.com/jrus/3197011
--
function Util:uuid()
    local template ='xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'
    return _.__gsub(template, '[xy]', function (c)
        local v = (c == 'x') and _.__random(0, 0xf) or _.__random(8, 0xb)
        return _.__format('%x', v)
    end)
end

function Util:basename(source)
    return string.match(source, "([%a|%-_|%d]+)")
end

function Util:filenameSplit(source)
    return string.match(source, "(.+%/)([%a|%-_|%d]+)%.(%a+)")
end