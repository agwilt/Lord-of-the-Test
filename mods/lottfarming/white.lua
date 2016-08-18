minetest.register_craftitem("lottfarming:white_mushroom_spore", {
	description = "White Mushroom Spores",
	inventory_image = "lottfarming_white_mushroom_spore.png",
	on_place = function(itemstack, placer, pointed_thing)
		return place_spore(itemstack, placer, pointed_thing, "lottfarming:white_mushroom_1")
	end,
})

minetest.register_node("lottfarming:white_mushroom", {
	description = "White Mushroom",
	paramtype = "light",
	light_source = 2,
	walkable = false,
	drawtype = "plantlike",
	drop = "",
	light_source = 2,
	tiles = {"lottfarming_white_mushroom_4.png"},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.5+3/16, 0.5}
		},
	},
	groups = {snappy=3, flammable=2, mushroom=1, flower=1, color_white=1},
	sounds = default.node_sound_leaves_defaults(),
	inventory_image = "lottfarming_white_mushroom.png",
	on_use = minetest.item_eat(2),
})
minetest.register_node("lottfarming:white_mushroom_1", {
	paramtype = "light",
	light_source = 2,
	walkable = false,
	drawtype = "plantlike",
	drop = "",
	tiles = {"lottfarming_white_mushroom_1.png"},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.5+3/16, 0.5}
		},
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1},
	sounds = default.node_sound_leaves_defaults(),
})
minetest.register_node("lottfarming:white_mushroom_2", {
	paramtype = "light",
	light_source = 2,
	walkable = false,
	drawtype = "plantlike",
	drop = "",
	tiles = {"lottfarming_white_mushroom_2.png"},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.5+3/16, 0.5}
		},
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1},
	sounds = default.node_sound_leaves_defaults(),
})
minetest.register_node("lottfarming:white_mushroom_3", {
	paramtype = "light",
	light_source = 2,
	walkable = false,
	drawtype = "plantlike",
	drop = "",
	tiles = {"lottfarming_white_mushroom_3.png"},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.5+3/16, 0.5}
		},
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1},
	sounds = default.node_sound_leaves_defaults(),
})
minetest.register_node("lottfarming:white_mushroom_4", {
	paramtype = "light",
	light_source = 2,
	walkable = false,
	drawtype = "plantlike",
	drop = "",
	tiles = {"lottfarming_white_mushroom_4.png"},
	after_dig_node = function(pos)
	end,
	drop = {
		max_items = 6,
		items = {
			{ items = {'lottfarming:white_mushroom'} },
			{ items = {'lottfarming:white_mushroom'}, rarity = 2},
			{ items = {'lottfarming:white_mushroom'}, rarity = 5},
			{ items = {'lottfarming:white_mushroom_spore'} },
			{ items = {'lottfarming:white_mushroom_spore'}, rarity = 2},
			{ items = {'lottfarming:white_mushroom_spore'}, rarity = 5},
		}
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1},
	sounds = default.node_sound_leaves_defaults(),
})
chance = 10
interval = 30
whereon = "lottfarming:decay_tree"
wherein = "air"

	minetest.register_abm({
		nodenames = "lottfarming:white_mushroom_1",
		interval = interval,
		chance = chance,
		action = function(pos, node)
			pos.y = pos.y-1
			if minetest.env:get_node(pos).name ~= "lottfarming:decay_tree" then
				return
			end
			pos.y = pos.y+1
			if not minetest.env:get_node_light(pos) then
				return
			end
			if minetest.env:get_node_light(pos) > 8 then
				return
			end
			minetest.env:set_node(pos, {name='lottfarming:white_mushroom_2'})
		end
}	)
	minetest.register_abm({
		nodenames = "lottfarming:white_mushroom_2",
		interval = 30,
		chance = 10,
		action = function(pos, node)
			pos.y = pos.y-1
			if minetest.env:get_node(pos).name ~= "lottfarming:decay_tree" then
				return
			end
			pos.y = pos.y+1
			if not minetest.env:get_node_light(pos) then
				return
			end
			if minetest.env:get_node_light(pos) > 8 then
				return
			end
			
			minetest.env:set_node(pos, {name='lottfarming:white_mushroom_3'})
			
		end
}	)

	minetest.register_abm({
		nodenames = "lottfarming:white_mushroom_3",
		interval = interval,
		chance = chance,
		action = function(pos, node)
			pos.y = pos.y-1
			if minetest.env:get_node(pos).name ~= "lottfarming:decay_tree" and minetest.env:get_node(pos).name ~= "default_tree" then
				return
			end
			pos.y = pos.y+1
			if not minetest.env:get_node_light(pos) then
				return
			end
			if minetest.env:get_node_light(pos) > 8 then
				return
			end
			minetest.env:set_node(pos, {name='lottfarming:white_mushroom_4'})
			
		end
}	)
num = PseudoRandom(111)
	minetest.register_abm({
		nodenames = "lottfarming:white_mushroom_3",
		interval = 30,
		chance = 10,
		action = function(pos, node)
			
			pos.x = pos.x-1
			x = num:next(1, 3)
			if x > 1 then
				pos.x = pos.x+1
				if x > 2 then	
					pos.x = pos.x+1
				end
			end
			pos.z=pos.z-1
			z = num:next(1, 3)
			if z > 1 then
				pos.z = pos.z+1
				if z > 2 then	
					pos.z = pos.z+1
				end
			end
			if minetest.env:get_node(pos).name=="air" then
				pos.y = pos.y-1
				name = minetest.env:get_node(pos).name
				if name=="default:tree" then								pos.y=pos.y+1
					minetest.env:set_node(pos, {name='lottfarming:white_mushroom_3'})
				end
				if name=="default:tree" then								pos.y=pos.y+1
					minetest.env:set_node(pos, {name='lottfarming:white_mushroom_3'})
				end
				if name=="air" then
					pos.y=pos.y-1
					name = minetest.env:get_node(pos).name
					if name=="default:tree" then								pos.y=pos.y+1
							minetest.env:set_node(pos, {name='lottfarming:white_mushroom_3'})
					end
					if name=="default:tree" then																		pos.y=pos.y+1
						minetest.env:set_node(pos, {name='lottfarming:white_mushroom_3'})
					end
				end
				
			end
			pos.y=pos.y+1
			if minetest.env:get_node(pos).name=="air" then
				pos.y = pos.y-1
				name = minetest.env:get_node(pos).name
				if name=="default:tree" then								pos.y=pos.y+1
					minetest.env:set_node(pos, {name='lottfarming:white_mushroom_3'})
				end
				if name=="default:tree" then								pos.y=pos.y+1
					minetest.env:set_node(pos, {name='lottfarming:white_mushroom_3'})
				end
			end
			
			
		end
}	)
