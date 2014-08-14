dofile(minetest.get_modpath(minetest.get_current_modname()).."/lebethronwood.lua")
dofile(minetest.get_modpath(minetest.get_current_modname()).."/birchwood.lua")
dofile(minetest.get_modpath(minetest.get_current_modname()).."/alderwood.lua")
dofile(minetest.get_modpath(minetest.get_current_modname()).."/mallornwood.lua")

-- Local constants
-- This _has_ to be set to 2
local HATCH_OPENED = 2
-- This has to be != from HATCH_OPENED and is coded on 4 bits
local HATCH_CLOSED = 1

-- Local Functions
local on_hatch_punched = function(pos, node, puncher)
    if (node.name ~= 'hatches:hatch_wood')
        and (node.name ~= 'hatches:hatch_wood_opened') then
        return
    end
    local state = node.param2

    -- Switch the hatch state when hit
    if state == HATCH_OPENED then
        node.name = 'hatches:hatch_wood'
        node.param2 = HATCH_CLOSED
    else
        node.name = 'hatches:hatch_wood_opened'
        node.param2 = HATCH_OPENED
    end

    minetest.env:add_node(pos, {
        name = node.name,
        param2 = node.param2,
    })
end


-- Nodes
-- As long as param2 is set to 1 for open hatches, it doesn't matter to
-- use drawtype = 'signlike'
minetest.register_node('hatches:hatch_wood_opened', {
    drawtype = 'signlike',
    tile_images = {'hatches_wood_open.png'},
    inventory_image = 'hatches_wood_open.png',
    sunlight_propagates = true,
    paramtype = 'light',
    paramtype2 = "wallmounted",
    legacy_wallmounted = true,
    walkable = false,
    climbable = true,
    selection_box = {
        type = "wallmounted",
    },
    drop = 'hatches:hatch_wood',
    on_punch = on_hatch_punched,
    groups = { choppy=2, dig_immediate=2 },
})

minetest.register_node('hatches:hatch_wood', {
    description = "Hatch",
    drawtype = 'nodebox',
    tile_images = {'hatches_wood.png'},
    inventory_image = 'hatches_wood_open.png',
    wield_image = "hatch_original.png",
    paramtype = 'light',
    is_ground_content = true,
    walkable = true,
    node_box = {
        type = "fixed",
        fixed = {-1/2, 2/5, -1/2, 1/2, 1/2, 1/2},
    },
    selection_box = {
        type = "fixed",
        fixed = {-1/2, 2/5, -1/2, 1/2, 1/2, 1/2},
    },
    on_punch = on_hatch_punched,
    groups = { choppy=2, dig_immediate=2 },
})

-- Mesecon Stuff:
if minetest.get_modpath("mesecons") then
	mesecon:register_on_signal_on(on_hatch_punched)
	mesecon:register_on_signal_off(on_hatch_punched)
end


-- Crafts


minetest.register_craft({
    output = 'hatches:hatch_wood 2',
    recipe = {
        {'default:steel_ingot 1', 'default:wood 1', 'default:steel_ingot 1'},
        {'default:wood 1', 'default:wood 1', 'default:wood 1'},
    },
})

