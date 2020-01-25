--=======================================
-- filename:    audio/soundtrack.lua
-- author:      Shane Krolikowski
-- created:     Jan, 2018
-- description: Play multiple songs.
--=======================================

local Soundtrack = {}
local delay      = 1.0

function Soundtrack:new(volume)
    self.sources = {}
    self.playing = false
    self.volume  = volume or 1
    self.index   = 1
    self.clock   = 0
end

function Soundtrack:add(source)
    table.insert(self.sources, source)
end

function Soundtrack:addFolder(dir)
    local files
    local ok, message = pcall(love.filesystem.getInfo, dir, "directory")

    if not ok then
        print("Could not access directory:", message)
    else
        files = love.filesystem.getDirectoryItems(dir)

        for _, file in pairs(files) do
            table.insert(self.sources, love.audio.newSource(dir .. '/' .. file, "static"))
        end
    end
end

function Soundtrack:remove(index)
    if self.sources[index] ~= nil then
        table.remove(self.sources, index)
    end
end

function Soundtrack:play(index, loop)
    self.playing = true

    if index ~= nil then
        self.index = index
    end

    if loop == true then
        self.sources[self.index]:setLooping(loop)
    end

    self.sources[self.index]:setVolume(self.volume)
    self.sources[self.index]:play()
end

function Soundtrack:shuffle()
    self.sources = Util:shuffle(self.sources)

    return self
end

function Soundtrack:stop()
    self.playing = false

    self.sources[self.index]:setLooping(false)
    self.sources[self.index]:stop()
end

function Soundtrack:pause()
    self.playing = false

    self.sources[self.index]:pause()
end

function Soundtrack:resume()
    self.playing = true

    self.sources[self.index]:resume()
end

function Soundtrack:next()
    -- stop current track
    self:stop()

    -- update track number
    self:skip(1)

    -- setup new track
    if isPaused then
        self:pause()
    else
        self:play()
    end
end

function Soundtrack:prev()
    local isPaused = self.sources[self.index]:isPaused()

    -- stop current track
    self:stop()

    -- update track number
    self:skip(-1)

    -- setup new track
    if isPaused then
        self:pause()
    else
        self:play()
    end
end

function Soundtrack:skip(dIndex)
    self.index = self.index + dIndex

    if dIndex == 1 and self.index > #self.sources then
        self.index = 1
    elseif dIndex == -1 and self.index <= 0 then
        self.index = #self.sources
    end
end

function Soundtrack:setVolume(volume)
    self.volume = volume
end

function Soundtrack:checkProgress()
    if not self.playing then
        return
    end

    if not self.sources[self.index]:isPlaying() then
        self:next()
    end
end

function Soundtrack:update(dt)
    self.clock = self.clock + dt

    if self.clock >= delay then
        self:checkProgress()
        self.clock = 0
    end
end

return Soundtrack