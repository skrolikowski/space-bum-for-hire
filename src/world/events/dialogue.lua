-- Dialogue Event
-- Shane Krolikowski
--

local Event    = require 'src.world.events.event'
local Dialogue = Event:extend()

-- New Dialogue Event
--
function Dialogue:new(data)
	Event.new(self, 'Dialogue', data)
	--
	assert(data.properties.script ~= nil, 'Dialogue Event requires `data.properties.script`')

	-- animation settings
	self.timer  = Timer.new()
	self.index  = data.properties.index or 1
	self.delay  = data.properties.delay or 3
	
	-- dialogue
	self.script  = Dialogue_.script[data.properties.script]
	self.reading = nil
end

-- Check for contacts
--
function Dialogue:beginContact(other, col)
	if col:isTouching() and not self.reading then
		self:trigger()
	end
end

-- Start dialogue animation
--
function Dialogue:trigger()
	if self.index > #self.script then
	-- End of dialogue
		self.reading = nil
		self:destroy()
	else
	-- Start next section of dialogue
		self.reading = UI['script'](self, self.script[self.index])
		self.index   = self.index + 1

		-- animation tween
		-- move target to goal location
		self.timer:after(self.delay, function()
			self:trigger()
		end)
	end
end

-- Update dialogue
--
function Dialogue:update(dt)
	self.timer:update(dt)
	--
	if self.reading then
		self.reading:update(dt)
	end
end

-- Draw dialogue
--
function Dialogue:draw()
	if self.reading then
		self.reading:draw()
	end
	--
	Event.draw(self)
end

return Dialogue