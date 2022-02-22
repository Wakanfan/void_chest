-- support for MT game translation.
local S = minetest.get_translator("sfinv_home")


local get_formspec = function(name)

	local formspec = "size[6,2]"
		.. "button_exit[2,3;4,1;home_gui_set;" .. S("Set Home") .. "]"
		.. "button_exit[2,1.5;4,1;home_gui_go;" .. S("Go Home") .. "]"
    
	local home = sethome.get(name)
	return formspec
end
	
	
-- register homegui page
sfinv.register_page("sfinv_home:homegui", {

	title = S("More"),

	get = function(self, player, context)

		local name = player:get_player_name()

		return sfinv.make_formspec(player, context, get_formspec(name))
	end,

	is_in_nav = function(self, player, context)

		local name = player:get_player_name()

		return minetest.get_player_privs(name).home
	end,

	on_enter = function(self, player, context) end,

	on_leave = function(self, player, context) end,

	on_player_receive_fields = function(self, player, context, fields)

		local name = player:get_player_name()

		if not minetest.get_player_privs(name).home then
			return
		end

		if fields.home_gui_set then

			sethome.set(name, player:get_pos())

                   minetest.chat_send_player(player:get_player_name(), S"Home set !")

			sfinv.set_player_inventory_formspec(player)

		elseif fields.home_gui_go then

			sethome.go(name)
                  
                  minetest.chat_send_player(player:get_player_name(), S"Teleported to your home !")
		end
	end
})