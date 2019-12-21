local Modern   = require 'modern'
local Passport = Modern:extend()

-- quick lua implementation of "random" UUID
-- https://gist.github.com/jrus/3197011
--
local random = math.random
local function uuid()
    local template ='xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'
    return string.gsub(template, '[xy]', function (c)
        local v = (c == 'x') and random(0, 0xf) or random(8, 0xb)
        return string.format('%x', v)
    end)
end
--

function Passport:new()
	self.passports = {}

end

-- Add visitor to host
--
function Passport:add(visitor, host)
	local passport = self:getPassport(visitor)
	local hostID   = self:getHostID(host)

	passport[hostID] = host
end

-- Remove visitor from host
--
function Passport:remove(visitor, host)
	local passport = self:getPassport(visitor)
	local hostID   = self:getHostID(host)

	passport[hostID] = nil
end

-- Get passport for visitor
--
function Passport:getPassport(v)
	-- check for passport
	if not v.__pass then
		-- passport id
		v.__pass = uuid()

		-- register new passport
		self.passports[v.__pass] = {}
	end

	return self.passports[v.__pass]
end

-- Get/assign Host ID for requested host
--
function Passport:getHostID(host)
	-- check for registration
	if not host.__host then
		-- register
		host.__host = uuid()
	end

	return host.__host
end

-- Attempt to get requesting Host
--
function Passport:get(visitor, host)
	local passport = self:getPassport(visitor)
	local hostID   = self:getHostID(host)

	return passport[hostID] or false
end

return Passport