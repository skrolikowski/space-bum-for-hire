-- Animator util
-- Shane Krolikowski
--

local Modern   = require 'modern'
local Animator = Modern:extend()

-- Create new Animator instance
--
function Animator:new()
	self.current    = nil
	self.animations = {}
end

-- Add new animation
--
function Animator:addAnimation(name, options)
	local image  = options.image
	local width  = options.width  or image:getWidth()
	local height = options.height or image:getHeight()
	local frames = nil

	if options.frames then
		frames = self:parseFrames(options.frames, image, width, height)
	end

	self.animations[name] = {
		name   = name,
		image  = image,
		width  = width,
		height = height,
		frames = frames,
		fps    = options.fps   or 10,
		total  = options.total or nil,
		after  = options.after or function() end
	}

	if not self.current then
		self:switchTo(name)
	end
end

-- Parse frames requested for image
--
function Animator:parseFrames(segments, image, width, height)
	local frames = {}
	local row, col

	for __, segment in pairs(segments) do
		row     = segment[1]
		col     = segment[2]
		lastRow = segment[3] or row
		lastCol = segment[4] or col

		for r = row, lastRow do
			for c = col, lastCol do
				table.insert(
					frames,
					love.graphics.newQuad((c - 1) * width, (r - 1) * height, width, height, image:getDimensions())
				)
			end
		end
	end

	return frames
end

-- Get current animation frame's dimensions
--
function Animator:dimensions()
	if self.current then
		return self.current.width, self.current.height
	end

	return 0, 0
end

-- Switch to different animation
--
function Animator:switchTo(name)
	if self.animations[name] then
		self.current = self.animations[name]

		-- setup
		if self.current.frames then
			self.current.frame   = 1
			self.current.timer   = 1 / self.current.fps
			self.current.count   = 0
			self.current.playing = true
		else
			self.current.playing = false
		end
	end
end

-- Toggle next frame (if applicable)
--
function Animator:nextFrame()
	self.current.frame = self.current.frame + 1

	-- end of animation?
	if self.current.frame > #self.current.frames then
		self.current.frame = 1
		self.current.count = self.current.count + 1

		-- loop animation?
		if self.current.total == nil or self.current.count < self.current.total then
			self.current.playing = true
		else
			self.current.playing = false
		end

		-- trigger after animation callback
		self.current:after()
	end
end

-- Update animation
--
function Animator:update(dt)
	if self.current and self.current.playing then
		self.current.timer = self.current.timer - dt

		if self.current.timer <= 0 then
			self.current.timer = 1 / self.current.fps
			self:nextFrame()
		end
	end
end

-- Draw animation
--
function Animator:draw(...)
	if self.current and self.current.playing then
		if self.current.frames then
			love.graphics.draw(self.current.image, self.current.frames[self.current.frame], ...)
		else
			love.graphics.draw(image, ...)
		end
	end
end

return Animator