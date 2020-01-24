-- UI Text
--

local Modern = require 'modern'
local Text   = Modern:extend()

function Text:new(data)
	self.x       = data.x
	self.y       = data.y
	self.width   = data.width
	self.height  = data.height
	self.visible = data.visible

	self.font = lg.newFont('res/ui/fonts/' .. data.fontfamily .. '.ttf', data.pixelsize)
	self.text = data.text
	-- self.canvas = lg.newCanvas(self.width, self.height)
	-- lg.setCanvas(self.canvas)
	-- --
	-- self.text = lg.newText(font)
	-- self.text:setf(data.text, self.width, data.valign)
	-- --
	-- lg.setCanvas()

	-- body
	self.body = lp.newBody(Gamestate:current():getWorld(), data.x, data.y, 'static')

	-- shape
	self.shape = Shapes['rectangle'](data.width/2, data.height/2, data.width, data.height)
	self.shape:setBody(self.body)

	-- fixture
	self.fixture = lp.newFixture(self.body, self.shape.shape, 1)
	self.fixture:setGroupIndex(Config.world.filter.group.text)
	self.fixture:setUserData(self)
	self.fixture:setSensor(true)
end

function Text:beginContact(other, col)
	--
end

function Text:endContact(other, col)
	--
end

function Text:update(dt)
	--
end

function Text:draw()
	if self.visible then
		-- lg.setColor(Config.color.sensor.event)
		-- self.shape:draw()

		lg.setColor(Config.color.white)
		lg.setFont(self.font)
		lg.printf(self.text, self.x, self.y, self.width, 'center')
	end
end

return Text