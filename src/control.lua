-- Control Settings
-- Shane Krolikowski
--

Control_ = {
	none   = {},
	player = {
		key_escape_on = function() Gamestate:current():quit() end,
		key_w_on      = function() _Player:keyOn('w')         end,
		key_a_on      = function() _Player:keyOn('a')         end,
		key_s_on      = function() _Player:keyOn('s')         end,
		key_d_on      = function() _Player:keyOn('d')         end,
		key_l_on      = function() _Player:setLock()          end,
		key_space_on  = function() _Player:keyOn('space_on')  end,
		key_a_down    = function(dt, et) _Player:move(dt, et)           end,
		key_d_down    = function(dt, et) _Player:move(dt, et)           end,
		key_k_down    = function(dt, et) _Player.weapon:trigger(dt, et) end,
		key_w_off     = function() _Player:keyOff('w')         end,
		key_a_off     = function() _Player:keyOff('a')         end,
		key_d_off     = function() _Player:keyOff('d')         end,
		key_s_off     = function() _Player:keyOff('s')         end,
		key_l_off     = function() _Player:setLock()           end,
		key_k_off     = function() _Player.weapon:holster()    end,
		key_space_off = function() _Player:keyOff('space_off') end,
	},
	pause = {

	},
}