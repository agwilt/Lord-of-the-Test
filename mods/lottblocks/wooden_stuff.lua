function lottblocks.register_wooden_stuff(name, description, texture, wood_name)
	local wood_groups = minetest.registered_nodes[wood_name].groups
	local node_groups = {}
	for k,v in pairs(wood_groups) do
		if k ~= "wood" then
			node_groups[k] = v
		end
	end

	local groups_door = node_groups
	groups_door.door = 1

	if name ~= "wood" then
		doors:register_door("lottblocks:door_" .. name, {
			description =  description .. " Door",
			inventory_image = "lottblocks_door_" .. name .. ".png",
			groups = groups_door,
			tiles_bottom = {"lottblocks_door_" .. name .."_b.png", "lottblocks_edge_" .. name ..".png"},
			tiles_top = {"lottblocks_door_" .. name .. "_a.png", "lottblocks_edge_" .. name ..".png"},
			sounds = default.node_sound_wood_defaults(),
			sound_open = "doors_door_open",
			sound_close = "doors_door_close"
		})
		minetest.register_craft({
			output = "lottblocks:door_" .. name,
			recipe = {
				{wood_name, wood_name},
				{wood_name, wood_name},
				{wood_name, wood_name}
			}
		})
		node_groups.not_in_creative_inventory = 0
		doors.register_trapdoor("lottblocks:hatch_" .. name, {
			description = description .. " Trapdoor",
			wield_image = "lottblocks_hatch_" .. name ..".png",
			tile_open = "lottblocks_hatch_" .. name .. "_open.png",
			tile_closed = "lottblocks_hatch_" .. name .. ".png",
			tile_side = "door_trapdoor_side.png",
			groups = node_groups,
			sounds = default.node_sound_wood_defaults(),
			sound_open = "doors_door_open",
			sound_close = "doors_door_close"
		})
		minetest.register_craft({
			output = "lottblocks:hatch_" .. name,
			recipe = {
				{wood_name, wood_name},
				{wood_name, wood_name},
			}
		})
		minetest.register_craft({
			output = "lottblocks:fence_" .. name .." 6",
			recipe = {
				{wood_name, wood_name, wood_name,},
				{wood_name, wood_name, wood_name,},
			}
		})
	end
	node_groups.fence = 1
	minetest.register_node("lottblocks:fence_" .. name, {
		description = description .. " Fence",
		drawtype = "nodebox",
		node_box = {
			type = "connected",
			fixed = {{-1/8, -1/2, -1/8, 1/8, 1/2, 1/8}},
			-- connect_top =
			-- connect_bottom =
			connect_front = {{-1/16,3/16,-1/2,1/16,5/16,-1/8},
				{-1/16,-5/16,-1/2,1/16,-3/16,-1/8}},
			connect_left = {{-1/2,3/16,-1/16,-1/8,5/16,1/16},
				{-1/2,-5/16,-1/16,-1/8,-3/16,1/16}},
			connect_back = {{-1/16,3/16,1/8,1/16,5/16,1/2},
				{-1/16,-5/16,1/8,1/16,-3/16,1/2}},
			connect_right = {{1/8,3/16,-1/16,1/2,5/16,1/16},
				{1/8,-5/16,-1/16,1/2,-3/16,1/16}},
		},
		connects_to = {"group:fence", "group:wood", "group:tree"},
		tiles = {texture},
		inventory_image = "lottblocks_" .. name .. "_fence.png",
		wield_image = "lottblocks_" .. name .. "_fence.png",
		paramtype = "light",
		is_ground_content = false,
		selection_box = {
			type = "fixed",
			fixed = {-1/7, -1/2, -1/7, 1/7, 1/2, 1/7},
		},
		groups = node_groups
	})
	node_groups.fence = 0
	minetest.register_node("lottblocks:ladder_" .. name, {
		description = description .. " Ladder",
		drawtype = "nodebox",
		tiles = {texture},
		paramtype = "light",
		paramtype2 = "facedir",
		sunlight_propagates = true,
		walkable = true,
		climbable = true,
		is_ground_content = false,
		node_box = {
			type = "fixed",
			fixed = {
				{-0.375, -0.5, 0.4375, -0.25, 0.5, 0.5}, -- NodeBox1
				{0.25, -0.5, 0.4375, 0.375, 0.5, 0.5}, -- NodeBox2
				{-0.25, -0.4375, 0.4375, 0.25, -0.3125, 0.5}, -- NodeBox3
				{-0.25, -0.1875, 0.4375, 0.25, -0.0625, 0.5}, -- NodeBox5
				{-0.25, 0.0625, 0.4375, 0.25, 0.1875, 0.5}, -- NodeBox6
				{-0.25, 0.3125, 0.4375, 0.25, 0.4375, 0.5}, -- NodeBox7
			}
		},
		selection_box = {
			type = "fixed",
			fixed = {{-0.4375, -0.5, 0.4375, 0.4375, 0.5, 0.5}}
		},
		groups = {choppy=2,oddly_breakable_by_hand=3,flammable=2},
		legacy_wallmounted = true,
		sounds = default.node_sound_wood_defaults(),
		after_place_node = function(pos, placer, itemstack, pointed_thing)
			local dir = minetest.dir_to_facedir(placer:get_look_dir())
			local npos = pos
			if dir == 0 then
				npos = {x = pos.x, y = pos.y, z = pos.z + 1}
			elseif dir == 1 then
				npos = {x = pos.x + 1, y = pos.y, z = pos.z}
			elseif dir == 2 then
				npos = {x = pos.x, y = pos.y, z = pos.z - 1}
			elseif dir == 3 then
				npos = {x = pos.x - 1, y = pos.y, z = pos.z}
			end
			if minetest.registered_nodes[minetest.get_node(npos).name]["walkable"] == false then
				minetest.remove_node(pos)
				return true
			else
				minetest.set_node(pos, {name = "lottblocks:ladder_" .. name, param2 = dir})
			end
		end,
	})
	minetest.register_node("lottblocks:" .. name .. "_table", {
		description = description .. " Table",
		tiles = {texture},
		drawtype = "nodebox",
		sunlight_propagates = true,
		paramtype = 'light',
		paramtype2 = "facedir",
		node_box = {
			type = "fixed",
			fixed = {
				{-0.4,-0.5,-0.4, -0.3,0.4,-0.3},
				{0.3,-0.5,-0.4, 0.4,0.4,-0.3},
				{-0.4,-0.5,0.3, -0.3,0.4,0.4},
				{0.3,-0.5,0.3, 0.4,0.4,0.4},
				{-0.5,0.4,-0.5, 0.5,0.5,0.5},
				{-0.4,-0.2,-0.3, -0.3,-0.1,0.3},
				{0.3,-0.2,-0.4, 0.4,-0.1,0.3},
				{-0.3,-0.2,-0.4, 0.4,-0.1,-0.3},
				{-0.3,-0.2,0.3, 0.3,-0.1,0.4},
			},
		},
		groups = node_groups
	})
	minetest.register_node("lottblocks:" .. name .."_chair", {
		description = description .. " Chair",
		tiles = {texture},
		drawtype = "nodebox",
		sunlight_propagates = true,
		paramtype = 'light',
		paramtype2 = "facedir",
		node_box = {
			type = "fixed",
			fixed = {
				{-0.3,-0.5,0.2, -0.2,0.5,0.3},
				{0.2,-0.5,0.2, 0.3,0.5,0.3},
				{-0.3,-0.5,-0.3, -0.2,-0.1,-0.2},
				{0.2,-0.5,-0.3, 0.3,-0.1,-0.2},
				{-0.3,-0.1,-0.3, 0.3,0,0.2},
				{-0.2,0.1,0.25, 0.2,0.4,0.26}
			},
		},
		selection_box = {
			type = "fixed",
			fixed = {-0.3, -0.5, -0.3, 0.3, 0.5, 0.3},
		},
		groups = node_groups
	})
	minetest.register_craft({
		output = "lottblocks:" .. name .. "_table",
		recipe = {
			{wood_name, wood_name, wood_name},
			{'group:stick', 'group:stick', 'group:stick'},
			{'group:stick', '', 'group:stick'},
		}
	})
	minetest.register_craft({
		output = "lottblocks:" .. name .. "_chair",
		recipe = {
			{'group:stick', ''},
			{wood_name, wood_name},
			{'group:stick', 'group:stick'},
		}
	})
end

lottblocks.register_wooden_stuff("wood", "Wooden", "default_wood.png", "default:wood")
lottblocks.register_wooden_stuff("junglewood", "Junglewood", "default_junglewood.png", "default:junglewood")
lottblocks.register_wooden_stuff("alder", "Alder", "lottplants_alderwood.png", "lottplants:alderwood")
lottblocks.register_wooden_stuff("birch", "Birch", "lottplants_birchwood.png", "lottplants:birchwood")
lottblocks.register_wooden_stuff("pine", "Pine", "lottplants_pinewood.png", "lottplants:pinewood")
lottblocks.register_wooden_stuff("lebethron", "Lebethron", "lottplants_lebethronwood.png", "lottplants:lebethronwood")
lottblocks.register_wooden_stuff("mallorn", "Mallorn", "lottplants_mallornwood.png", "lottplants:mallornwood")
