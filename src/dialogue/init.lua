-- Dialogue System
--

local Scripts = {
	player = require 'src.dialogue.player'
}

local Modern   = require 'modern'
local Dialogue = Modern:extend()

function Dialogue:new(script, index)
	self.script = script
	self.index  = index
end

return Dialogue