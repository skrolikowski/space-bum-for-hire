-- Stack - Data Structure
-- Shane Krolikowski
--

local Modern = require 'modern'
local Stack  = Modern:extend()

function Stack:new(...)
    self.elements = {...}
end

function Stack:put(element)
    table.insert(self.elements, 1, element)
end

function Stack:peek()
    return self.elements[1]
end

function Stack:get()
    if self:isEmpty() then
        return false
    end

    return table.remove(self.elements, 1)
end

function Stack:size()
    return #self.elements
end

function Stack:isEmpty()
    return #self.elements == 0
end

return Stack