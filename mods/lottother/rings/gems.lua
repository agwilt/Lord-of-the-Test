--The three basic gem ore definitions

minetest.register_node("lottother:blue_gem_ore", {
	description = "Blue Gem Ore",
	tiles = {"default_stone.png^lottother_bluegem_ore.png"},
	is_ground_content = true,
	groups = {gems=1, creative=1},
	drop = {
		items = {
			{
				items = {'lottother:stony_blue_gem'},
				rarity = 5,
			},
			{
				items = {''},
			}
		}
	},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("lottother:white_gem_ore", {
	description = "White Gem Ore",
	tiles = {"default_stone.png^lottother_whitegem_ore.png"},
	is_ground_content = true,
	groups = {gems=1, creative=1},
	drop = {
		items = {
			{
				items = {'lottother:stony_white_gem'},
				rarity = 5,
			},
			{
				items = {''},
			}
		}
	},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("lottother:purple_gem_ore", {
	description = "Purple Gem Ore",
	tiles = {"default_stone.png^lottother_purplegem_ore.png"},
	is_ground_content = true,
	groups = {gems=1, creative=1},
	drop = {
		items = {
			{
				items = {'lottother:stony_purple_gem'},
				rarity = 5,
			},
			{
				items = {''},
			}
		}
	},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("lottother:red_gem_ore", {
	description = "Red Gem Ore",
	tiles = {"default_stone.png^lottother_redgem_ore.png"},
	is_ground_content = true,
	groups = {gems=1, creative=1},
	drop = {
		items = {
			{
				items = {'lottother:stony_red_gem'},
				rarity = 5,
			},
			{
				items = {''},
			}
		}
	},
	sounds = default.node_sound_stone_defaults(),
})

-- Mapgen stuff

local wl = minetest.get_mapgen_setting("water_level")

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "lottother:blue_gem_ore",
	wherein        = "default:stone",
	clust_scarcity = 14*14*14,
	clust_num_ores = 4,
	clust_size     = 2,
	y_min     = wl - 31000,
	y_max     = wl - 256,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "lottother:red_gem_ore",
	wherein        = "default:stone",
	clust_scarcity = 14*14*14,
	clust_num_ores = 4,
	clust_size     = 2,
	y_min     = wl - 31000,
	y_max     = wl - 256,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "lottother:purple_gem_ore",
	wherein        = "default:stone",
	clust_scarcity = 14*14*14,
	clust_num_ores = 4,
	clust_size     = 2,
	y_min     = wl - 31000,
	y_max     = wl - 256,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "lottother:white_gem_ore",
	wherein        = "default:stone",
	clust_scarcity = 14*14*14,
	clust_num_ores = 4,
	clust_size     = 2,
	y_min     = wl - 31000,
	y_max     = wl - 256,
})

-------------------------------------------
-- The long process of readying the gems --
-------------------------------------------

-- The inital drop from the ore

minetest.register_craftitem("lottother:stony_blue_gem", {
	description = "Stone Encrusted Blue Gem",
	inventory_image = "lottother_stony_bluegem.png",
})

minetest.register_craftitem("lottother:stony_red_gem", {
	description = "Stone Encrusted Red Gem",
	inventory_image = "lottother_stony_redgem.png",
})

minetest.register_craftitem("lottother:stony_purple_gem", {
	description = "Stone Encrusted Purple Gem",
	inventory_image = "lottother_stony_purplegem.png",
})

minetest.register_craftitem("lottother:stony_white_gem", {
	description = "Stone Encrusted White Gem",
	inventory_image = "lottother_stony_whitegem.png",
})

-- You cook the above to get uncut gems
-- (I'm using ^[colorize here so as to have these the same textures as the
-- cut, unpolished gems, without having to have separate textures for them!)

minetest.register_craftitem("lottother:uncut_blue_gem", {
	description = "Uncut Blue Gem",
	inventory_image = "lottother_uncut_bluegem.png^[colorize:#898985:100",
})

minetest.register_craftitem("lottother:uncut_red_gem", {
	description = "Uncut Red Gem",
	inventory_image = "lottother_uncut_redgem.png^[colorize:#898985:100",
})

minetest.register_craftitem("lottother:uncut_purple_gem", {
	description = "Uncut Purple Gem",
	inventory_image = "lottother_uncut_purplegem.png^[colorize:#898985:100",
})

minetest.register_craftitem("lottother:uncut_white_gem", {
	description = "Uncut White Gem",
	inventory_image = "lottother_uncut_whitegem.png^[colorize:#898985:100",
})

-- Crafts

minetest.register_craft({
	type = "cooking",
	output = "lottother:uncut_blue_gem",
	recipe = "lottother:stony_blue_gem",
	cooktime = 9,
})

minetest.register_craft({
	type = "cooking",
	output = "lottother:uncut_red_gem",
	recipe = "lottother:stony_red_gem",
	cooktime = 9,
})

minetest.register_craft({
	type = "cooking",
	output = "lottother:uncut_purple_gem",
	recipe = "lottother:stony_purple_gem",
	cooktime = 9,
})

minetest.register_craft({
	type = "cooking",
	output = "lottother:uncut_white_gem",
	recipe = "lottother:stony_white_gem",
	cooktime = 9,
})

-- You then craft them with a chisel to get unpolished gems

minetest.register_craftitem("lottother:unpolished_blue_gem", {
	description = "Unpolished Blue Gem",
	inventory_image = "lottother_bluegem.png^[colorize:#898985:120",
})

minetest.register_craftitem("lottother:unpolished_red_gem", {
	description = "Unpolished Red Gem",
	inventory_image = "lottother_redgem.png^[colorize:#898985:120",
})

minetest.register_craftitem("lottother:unpolished_purple_gem", {
	description = "Unpolished Purple Gem",
	inventory_image = "lottother_purplegem.png^[colorize:#898985:120",
})

minetest.register_craftitem("lottother:unpolished_white_gem", {
	description = "Unpolished White Gem",
	inventory_image = "lottother_whitegem.png^[colorize:#898985:120",
})

minetest.register_tool("lottother:chisel", {
	description = "Chisel",
	inventory_image = "lottother_chisel.png",
	max_stack = 1,
})

-- Crafts

minetest.register_craft({
	output = "lottother:chisel",
	recipe = {
		{"", "", "lottores:mithril_ingot"},
		{"", "default:steel_ingot", ""},
		{"group:stick", "", ""},
	},
})

minetest.register_craft({
	type = "shapeless",
	output = "lottother:unpolished_blue_gem",
	recipe = {"lottother:uncut_blue_gem", "lottother:chisel"},
})

minetest.register_craft({
	type = "shapeless",
	output = "lottother:unpolished_red_gem",
	recipe = {"lottother:uncut_red_gem", "lottother:chisel"},
})

minetest.register_craft({
	type = "shapeless",
	output = "lottother:unpolished_purple_gem",
	recipe = {"lottother:uncut_purple_gem", "lottother:chisel"},
})

minetest.register_craft({
	type = "shapeless",
	output = "lottother:unpolished_white_gem",
	recipe = {"lottother:uncut_white_gem", "lottother:chisel"},
})

minetest.register_on_craft(function(itemstack, player, old_craft_grid, craft_inv)
	if itemstack:get_name() == "lottother:unpolished_blue_gem"
	or itemstack:get_name() == "lottother:unpolished_red_gem"
	or itemstack:get_name() == "lottother:unpolished_purple_gem"
	or itemstack:get_name() == "lottother:unpolished_white_gem" then
		for i, stack in pairs(old_craft_grid) do
			if stack:get_name() == "lottother:chisel" then
				stack:add_wear(65535/34)
				craft_inv:set_stack("craft", i, stack)
				break
			end
		end
		if math.random(4) > 1 then
			itemstack:take_item()
			return itemstack
		end
	end
end)

-- Which you polish to get the final gem! What a lot of work!
-- And the ring still isn't ready to be made!
-- TODO: Make this more interesting than just crafting with sand.

minetest.register_craftitem("lottother:blue_gem", {
	description = "Blue Gem",
	inventory_image = "lottother_bluegem.png",
})

minetest.register_craftitem("lottother:red_gem", {
	description = "Red Gem",
	inventory_image = "lottother_redgem.png",
})

minetest.register_craftitem("lottother:purple_gem", {
	description = "Purple Gem",
	inventory_image = "lottother_purplegem.png",
})

minetest.register_craftitem("lottother:white_gem", {
	description = "White Gem",
	inventory_image = "lottother_whitegem.png",
})

-- Crafts

minetest.register_craft({
	output = "lottother:blue_gem",
	recipe = {
		{"group:sand", "group:sand", "group:sand"},
		{"group:sand", "lottother:unpolished_blue_gem", "group:sand"},
		{"group:sand", "group:sand", "group:sand"},
	},
})

minetest.register_craft({
	output = "lottother:red_gem",
	recipe = {
		{"group:sand", "group:sand", "group:sand"},
		{"group:sand", "lottother:unpolished_red_gem", "group:sand"},
		{"group:sand", "group:sand", "group:sand"},
	},
})

minetest.register_craft({
	output = "lottother:purple_gem",
	recipe = {
		{"group:sand", "group:sand", "group:sand"},
		{"group:sand", "lottother:unpolished_purple_gem", "group:sand"},
		{"group:sand", "group:sand", "group:sand"},
	},
})

minetest.register_craft({
	output = "lottother:white_gem",
	recipe = {
		{"group:sand", "group:sand", "group:sand"},
		{"group:sand", "lottother:unpolished_white_gem", "group:sand"},
		{"group:sand", "group:sand", "group:sand"},
	},
})

minetest.register_on_craft(function(itemstack, player, old_craft_grid, craft_inv)
	if itemstack:get_name() == "lottother:blue_gem"
	or itemstack:get_name() == "lottother:red_gem"
	or itemstack:get_name() == "lottother:purple_gem"
	or itemstack:get_name() == "lottother:white_gem" then
		if math.random(3) > 1 then
			itemstack:take_item()
			return itemstack
		end
	end
end)

-- The only pickaxe capable of mining gems!

minetest.register_tool("lottother:gem_pick", {
	description = "Gem Mining Pickaxe",
	inventory_image = "lottother_gempick.png",
	tool_capabilities = {
		full_punch_interval = 1.3,
		max_drop_level=3,
		groupcaps={
			gems = {times={[1]=7.5}, uses=60, maxlevel=3}
		},
		damage_groups = {fleshy=5},
	},
	groups = {forbidden = 1},
})

minetest.register_craft({
	output = 'lottother:gem_pick',
	recipe = {
		{"lottores:rough_rock_lump", "lottores:rough_rock_lump", "lottores:rough_rock_lump"},
		{"", "lottores:mithrilpick", ""},
	}
})

minetest.register_on_craft(function(itemstack, player, old_craft_grid, craft_inv)
	if itemstack:get_name() ~= "lottother:gem_pick" then
		return
	end
	local wear = 0
	for _, stack in pairs(old_craft_grid) do
		if stack:get_name() == "lottores:mithrilpick" then
			wear = stack:get_wear()
			break
		end
	end
	itemstack:add_wear(wear)
	return itemstack
end)
