minetest.register_craftitem("olvar:melon_seed", {
	description = "Melon Seed",
	inventory_image = "olvar_melon_seed.png",
	on_place = function(itemstack, placer, pointed_thing)
		return place_seed(itemstack, placer, pointed_thing, "olvar:melon_1")
	end,
})

minetest.register_node("olvar:melon_1", {
	paramtype = "light",
	sunlight_propagates = true,
	drawtype = "nodebox",
	drop = "",
	tiles = {"olvar_melon_top.png", "olvar_melon_top.png", "olvar_melon_side.png", "olvar_melon_side.png", "olvar_melon_side.png", "olvar_melon_side.png"},
	node_box = {
		type = "fixed",
		fixed = {
			{-0.2, -0.5, -0.2, 0.2, -0.1, 0.2}
		},
	},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.2, -0.5, -0.2, 0.2, -0.1, 0.2}
		},
	},
	groups = {choppy=2, oddly_breakable_by_hand=2, flammable=2, not_in_creative_inventory=1, plant=1},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("olvar:melon_2", {
	paramtype = "light",
	sunlight_propagates = true,
	drawtype = "nodebox",
	drop = "",
	tiles = {"olvar_melon_top.png", "olvar_melon_top.png", "olvar_melon_side.png", "olvar_melon_side.png", "olvar_melon_side.png", "olvar_melon_side.png"},
	node_box = {
		type = "fixed",
		fixed = {
			{-0.35, -0.5, -0.35, 0.35, 0.2, 0.35}
		},
	},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.35, -0.5, -0.35, 0.35, 0.2, 0.35}
		},
	},
	groups = {choppy=2, oddly_breakable_by_hand=2, flammable=2, not_in_creative_inventory=1, plant=1},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("olvar:melon_3", {
	description = "Melon",
	paramtype2 = "facedir",
	tiles = {"olvar_melon_top.png", "olvar_melon_top.png", "olvar_melon_side.png", "olvar_melon_side.png", "olvar_melon_side.png", "olvar_melon_side.png"},
		drop = {
		max_items = 6,
		items = {
			{ items = {'olvar:melon_seed'} },
			{ items = {'olvar:melon_seed'}, rarity = 20},
			{ items = {'olvar:melon 8'} },
		}
	},
	groups = {choppy=2, oddly_breakable_by_hand=1, flammable=2, plant=1},
	sounds = default.node_sound_wood_defaults(),
     on_punch = function(pos, node, puncher)
		local tool = puncher:get_wielded_item():get_name()
		if tool and string.match(tool, "sword") then
			node.name = "misc:jackomelon"
			minetest.set_node(pos, node)
		end
	end
})

minetest.register_craftitem("olvar:melon", {
	description = "Melon",
	inventory_image = "olvar_melon.png",
	on_use = minetest.item_eat(2),
})

farming:add_plant("olvar:melon_3", {"olvar:melon_1", "olvar:melon_2"}, 80, 20)