-- Dialogue System
-- _Dialogue:setScript('player', 'greeting'):play()

local Scripts = {
	player = require 'src.dialogue.player'
}
--

local Modern   = require 'modern'
local Dialogue = Modern:extend()

function Dialogue:new()
	self.script = nil

end

-- Set Script
--
function Dialogue:setScript(name, script)
	self.script = Scripts[name][script]
end

function Dialogue:play(index)
	index = index or 1

	if self.script[index] then
		if self:isQuestion() then
		-- Question
			Timer.after(self:calculateDelay(), function()
				self:play(index + 1)
			end)
		else
		-- 
			Timer.script(function(wait)

			end)
		end
	end
end

--
function Dialogue:isQuestion()
	return self.script.answers ~= nil
end

-- Skip to end of message.
function Dialogue:skip()

end

function Dialogue:calculateDelay(message)
	
end

function Dialogue:update(dt)
	self.timer:update(dt)
end

function Dialogue:draw()

end

return Dialogue