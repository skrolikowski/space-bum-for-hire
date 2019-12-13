-- Finite State Machine
-- Shane Krolikowski
--

local Modern = require 'modern'
local FSM    = Modern:extend()

function FSM:new(host, state)
    self.host   = host
    self.states = Stack()

    if state ~= nil then
        self:pushState(state)
    end
end

-- Start fresh stack w/ new state
--
function FSM:setState(state)
    if self:state() then
        if self:state().name == state then
            -- ignore request for same state push
            return
        end
        if self:state():can(state) then
            self.states:reset()
            self:pushState(state)
        end
    end
end

-- Push new state on top of stack
--
function FSM:pushState(state)
    if self:state() then
        if self:state().name == state then
            -- ignore request for same state push
            return
        end

        if self:state():can(state) then
            self.states:put(Behaviors[state](self.host))
        end
    else
        self.states:put(Behaviors[state](self.host))
    end
end

-- Pop current state
--
function FSM:popState()
    if self:state() then
        self.states:destroy()
    end
end

function FSM:state()
    return self.states:peek()
end

function FSM:update(dt)
    if self:state() then
        self:state():update(dt)
    end
end

function FSM:draw()
    if self:state() then
        self:state():draw()

        local cx, cy = self.host:getPosition()
        local w,h    = self.host.width, self.host.height
        local font   = love.graphics.newFont(10)

        love.graphics.setColor(Config.color.white)
        love.graphics.setFont(Config.ui.font.sm)
        love.graphics.printf(self:state().name, cx - w/2, cy - h/2, w, 'center')
    end
end

return FSM