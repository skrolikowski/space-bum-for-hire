-- Physics contact
--

local Modern  = require 'modern'
local Contact = Modern:extend()

function Contact:new(round, pos, normal)
	self.round    = round
	self.position = position
	self.normal   = normal
end

function Contact:isTouching()
	return true
end

function Contact:getNormal()
	return self.normal:unpack()
end

return Contact