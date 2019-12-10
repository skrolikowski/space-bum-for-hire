-- Finite State Machine
-- Shane Krolikowski
--

local Modern = require 'modern'
local FSM    = Modern:extend()

function FSM:new(host, state)
    self.host   = host
    self.states = Stack()

    if state then
        self.states:put(state)
    end
end

function FSM:setState(state)
    self:popState()
    self:pushState(state)
end

function FSM:pushState(state)
    if self:state().name ~= state then
        self.states:put(
            Behaviors[state](self.host)
        )
    end
end

function FSM:popState()
    return self.states:get()
end

function FSM:state()
    return self.states:peek()
end

function FSM:update(dt)
    local state = self:state()

    if state then
        state:update(dt)
    end
end

function FSM:draw()
    -- local state = self:state()
    -- local x, y, w, h

    -- -- For debugging purposes..
    -- if state then
    --     x, y, w, h = self.host:container()

    --     love.graphics.setColor(Config.color.black)
    --     love.graphics.printf(state, x - 25, y + h + 5, w + 50, 'center')
    -- end
end

return FSM