-- Control Settings
-- Shane Krolikowski
--

Control_ = {
	none = {
		key_escape_on = function() Gamestate:current():quit() end,
	},
	cutscene = {
		key_escape_on = function() Gamestate:current():quit() end,
	},
	player = {
		key_1_on      = function()       Gamestate:current().player:setWeapon('pistol')    end,
		key_2_on      = function()       Gamestate:current().player:setWeapon('shotgun')   end,
		-- key_3_on      = function()       Gamestate:current().player:setWeapon('raygun')    end,
		key_escape_on = function()       Gamestate:current():quit()                        end,
		key_w_on      = function()       Gamestate:current().player:keyOn('w')             end,
		key_a_on      = function()       Gamestate:current().player:keyOn('a')             end,
		key_s_on      = function()       Gamestate:current().player:keyOn('s')             end,
		key_d_on      = function()       Gamestate:current().player:keyOn('d')             end,
		key_l_on      = function()       Gamestate:current().player:setLock()              end,
		key_space_on  = function()       Gamestate:current().player:keyOn('space_on')      end,
		key_a_down    = function(dt, et) Gamestate:current().player:move(dt, et)           end,
		key_d_down    = function(dt, et) Gamestate:current().player:move(dt, et)           end,
		key_k_down    = function(dt, et) Gamestate:current().player.weapon:trigger(dt, et) end,
		key_w_off     = function()       Gamestate:current().player:keyOff('w')            end,
		key_a_off     = function()       Gamestate:current().player:keyOff('a')            end,
		key_d_off     = function()       Gamestate:current().player:keyOff('d')            end,
		key_s_off     = function()       Gamestate:current().player:keyOff('s')            end,
		key_l_off     = function()       Gamestate:current().player:setLock()              end,
		key_k_off     = function()       Gamestate:current().player.weapon:holster()       end,
		key_space_off = function()       Gamestate:current().player:keyOff('space_off')    end,
	},
	pause = {

	},
}