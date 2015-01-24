local horse = {
	physical = true,
	collisionbox = {-0.4, -0.01, -0.4, 0.4, 1, 0.4},
	visual = "mesh",
	stepheight = 1.1,
	visual_size = {x=1,y=1},
	mesh = "horseh1_model.x",
	textures = {"lottmobs_horse.png"},
	driver = nil,
	v = 0,
}


local function is_ground(pos)
	local nn = minetest.get_node(pos).name
	return minetest.get_item_group(nn, "crumbly") ~= 0 or
	minetest.get_item_group(nn, "cracky") ~= 0 or
	minetest.get_item_group(nn, "choppy") ~= 0 or
	minetest.get_item_group(nn, "snappy") ~= 0
end

local function get_sign(i)
	if i == 0 then
		return 0
	else
		return i/math.abs(i)
	end
end

local function get_velocity(v, yaw, y)
	local x = math.cos(yaw)*v
	local z = math.sin(yaw)*v
	return {x=x, y=y, z=z}
end

local function get_v(v)
	return math.sqrt(v.x^2+v.z^2)
end

function horse:on_rightclick(clicker)
	if not clicker or not clicker:is_player() then
		return
	end
	if self.driver and clicker == self.driver then
		self.driver = nil
		clicker:set_detach()
	elseif not self.driver then
		self.driver = clicker
		clicker:set_attach(self.object, "", {x=0,y=5,z=0}, {x=0,y=0,z=0})
		self.object:setyaw(clicker:get_look_yaw())
	end
end


function horse:on_activate(staticdata, dtime_s)
	self.object:set_armor_groups({immortal=1})
	if staticdata then
		self.v = tonumber(staticdata)
	end
end

function horse:get_staticdata()
	return tostring(v)
end

function horse:on_punch(puncher, time_from_last_punch, tool_capabilities, direction)
	self.object:remove()
	if puncher and puncher:is_player() then
		puncher:get_inventory():add_item("main", "kelvar:horseh1")
	end
end


function horse:on_step(dtime)

	self.v = get_v(self.object:getvelocity())*get_sign(self.v)
	if self.driver then
		local ctrl = self.driver:get_player_control()
		if ctrl.up then
			self.v = self.v+2.33
		end
		if ctrl.down then
			self.v = self.v-0.3
		end
		if ctrl.left then
			self.object:setyaw(self.object:getyaw()+math.pi/60+dtime*math.pi/60)
		end
		if ctrl.right then
			self.object:setyaw(self.object:getyaw()-math.pi/60-dtime*math.pi/60)
		end
		if ctrl.jump then
		local p = self.object:getpos()
		p.y = p.y-0.5
			if is_ground(p) then
				local v = self.object:getvelocity()
				v.y = 6
				self.object:setvelocity(v)
			end
		end
	end
	local s = get_sign(self.v)
	self.v = self.v - 0.02*s
	if s ~= get_sign(self.v) then
		self.object:setvelocity({x=0, y=0, z=0})
		self.v = 0
		return
	end
	if math.abs(self.v) > 7 then
		self.v = 7*get_sign(self.v)
	end
	
	local p = self.object:getpos()
	p.y = p.y-0.5
	if not is_ground(p) then
		if minetest.registered_nodes[minetest.get_node(p).name].walkable then
			self.v = 0
		end
		self.object:setacceleration({x=0, y=-10, z=0})
		self.object:setvelocity(get_velocity(self.v, self.object:getyaw(), self.object:getvelocity().y))
	else
		p.y = p.y+1
		if is_ground(p) then
			self.object:setacceleration({x=0, y=3, z=0})
			local y = self.object:getvelocity().y
			if y > 2 then
				y = 2
			end
			if y < 0 then
				self.object:setacceleration({x=0, y=10, z=0})
			end
			self.object:setvelocity(get_velocity(self.v, self.object:getyaw(), y))
		else
			self.object:setacceleration({x=0, y=0, z=0})
			if math.abs(self.object:getvelocity().y) < 1 then
				local pos = self.object:getpos()
				pos.y = math.floor(pos.y)+0.5
				self.object:setpos(pos)
				self.object:setvelocity(get_velocity(self.v, self.object:getyaw(), 0))
			else
				self.object:setvelocity(get_velocity(self.v, self.object:getyaw(), self.object:getvelocity().y))
			end
		end
	end

	if self.object:getvelocity().y > 0.1 then
		local yaw = self.object:getyaw()
		if self.drawtype == "side" then
			yaw = yaw+(math.pi/2)
		end
		local x = math.sin(yaw) * -2
		local z = math.cos(yaw) * 2
		if minetest.get_item_group(minetest.get_node(self.object:getpos()).name, "water") ~= 0 then
			self.object:setacceleration({x = x, y = 2, z = z})
		else
			self.object:setacceleration({x = x, y = -5, z = z})
        end
	else
		if minetest.get_item_group(minetest.get_node(self.object:getpos()).name, "water") ~= 0 then
			self.object:setacceleration({x = 0, y = 2, z = 0})
		else
			self.object:setacceleration({x = 0, y = -5, z = 0})
		end
	end
end

--horse white

local horsepeg = {
    
	
	physical = true,
	collisionbox = {-0.4, -0.01, -0.4, 0.4, 1, 0.4},
	visual = "mesh",
	stepheight = 1.1,
	visual_size = {x=1,y=1},
	mesh = "horseh1_model.x",
	textures = {"kelvar_horsepeg.png"},
		
	driver = nil,
	v = 0,
}


local function is_ground(pos)
	local nn = minetest.get_node(pos).name
	return minetest.get_item_group(nn, "crumbly") ~= 0 or
	minetest.get_item_group(nn, "cracky") ~= 0 or
	minetest.get_item_group(nn, "choppy") ~= 0 or
	minetest.get_item_group(nn, "snappy") ~= 0
end

local function get_sign(i)
	if i == 0 then
		return 0
	else
		return i/math.abs(i)
	end
end

local function get_velocity(v, yaw, y)
	local x = math.cos(yaw)*v
	local z = math.sin(yaw)*v
	return {x=x, y=y, z=z}
end

local function get_v(v)
	return math.sqrt(v.x^2+v.z^2)
end

function horsepeg:on_rightclick(clicker)
	if not clicker or not clicker:is_player() then
		return
	end
	if self.driver and clicker == self.driver then
		self.driver = nil
		clicker:set_detach()
	elseif not self.driver then
		self.driver = clicker
		clicker:set_attach(self.object, "", {x=0,y=5,z=0}, {x=0,y=0,z=0})
		self.object:setyaw(clicker:get_look_yaw())
	end
end


function horsepeg:on_activate(staticdata, dtime_s)
	self.object:set_armor_groups({immortal=1})
	if staticdata then
		self.v = tonumber(staticdata)
	end
end

function horsepeg:get_staticdata()
	return tostring(v)
end

function horsepeg:on_punch(puncher, time_from_last_punch, tool_capabilities, direction)
	self.object:remove()
	if puncher and puncher:is_player() then
		puncher:get_inventory():add_item("main", "kelvar:horsepegh1")
	end
end


function horsepeg:on_step(dtime)

	self.v = get_v(self.object:getvelocity())*get_sign(self.v)
	if self.driver then
		local ctrl = self.driver:get_player_control()
		if ctrl.up then
			self.v = self.v+233
		end
		if ctrl.down then
			self.v = self.v-0.3
		end
		if ctrl.left then
			self.object:setyaw(self.object:getyaw()+math.pi/60+dtime*math.pi/60)
		end
		if ctrl.right then
			self.object:setyaw(self.object:getyaw()-math.pi/60-dtime*math.pi/60)
		end
		if ctrl.jump then
		local p = self.object:getpos()
		p.y = p.y-0.5
			if is_ground(p) then
				local v = self.object:getvelocity()
				v.y = 6
				self.object:setvelocity(v)
			end
		end
	end
	local s = get_sign(self.v)
	self.v = self.v - 0.02*s
	if s ~= get_sign(self.v) then
		self.object:setvelocity({x=0, y=0, z=0})
		self.v = 0
		return
	end
	if math.abs(self.v) > 7 then
		self.v = 7*get_sign(self.v)
	end
	
	local p = self.object:getpos()
	p.y = p.y-0.5
	if not is_ground(p) then
		if minetest.registered_nodes[minetest.get_node(p).name].walkable then
			self.v = 0
		end
		self.object:setacceleration({x=0, y=-10, z=0})
		self.object:setvelocity(get_velocity(self.v, self.object:getyaw(), self.object:getvelocity().y))
	else
		p.y = p.y+1
		if is_ground(p) then
			self.object:setacceleration({x=0, y=3, z=0})
			local y = self.object:getvelocity().y
			if y > 2 then
				y = 2
			end
			if y < 0 then
				self.object:setacceleration({x=0, y=10, z=0})
			end
			self.object:setvelocity(get_velocity(self.v, self.object:getyaw(), y))
		else
			self.object:setacceleration({x=0, y=0, z=0})
			if math.abs(self.object:getvelocity().y) < 1 then
				local pos = self.object:getpos()
				pos.y = math.floor(pos.y)+0.5
				self.object:setpos(pos)
				self.object:setvelocity(get_velocity(self.v, self.object:getyaw(), 0))
			else
				self.object:setvelocity(get_velocity(self.v, self.object:getyaw(), self.object:getvelocity().y))
			end
		end
	end

	if self.object:getvelocity().y > 0.1 then
		local yaw = self.object:getyaw()
		if self.drawtype == "side" then
			yaw = yaw+(math.pi/2)
		end
		local x = math.sin(yaw) * -2
		local z = math.cos(yaw) * 2
		if minetest.get_item_group(minetest.get_node(self.object:getpos()).name, "water") ~= 0 then
			self.object:setacceleration({x = x, y = 2, z = z})
		else
			self.object:setacceleration({x = x, y = -5, z = z})
        end
	else
		if minetest.get_item_group(minetest.get_node(self.object:getpos()).name, "water") ~= 0 then
			self.object:setacceleration({x = 0, y = 2, z = 0})
		else
			self.object:setacceleration({x = 0, y = -5, z = 0})
		end
	end
end

--horse arabik
local horseara = {
	physical = true,
	collisionbox = {-0.4, -0.01, -0.4, 0.4, 1, 0.4},
	visual = "mesh",
	stepheight = 1.1,
	visual_size = {x=1,y=1},
	mesh = "horseh1_model.x",
	textures = {"kelvar_horseara.png"},
	driver = nil,
	v = 0,
}


local function is_ground(pos)
	local nn = minetest.get_node(pos).name
	return minetest.get_item_group(nn, "crumbly") ~= 0 or
	minetest.get_item_group(nn, "cracky") ~= 0 or
	minetest.get_item_group(nn, "choppy") ~= 0 or
	minetest.get_item_group(nn, "snappy") ~= 0
end

local function get_sign(i)
	if i == 0 then
		return 0
	else
		return i/math.abs(i)
	end
end

local function get_velocity(v, yaw, y)
	local x = math.cos(yaw)*v
	local z = math.sin(yaw)*v
	return {x=x, y=y, z=z}
end

local function get_v(v)
	return math.sqrt(v.x^2+v.z^2)
end

function horseara:on_rightclick(clicker)
	if not clicker or not clicker:is_player() then
		return
	end
	if self.driver and clicker == self.driver then
		self.driver = nil
		clicker:set_detach()
	elseif not self.driver then
		self.driver = clicker
		clicker:set_attach(self.object, "", {x=0,y=5,z=0}, {x=0,y=0,z=0})
		self.object:setyaw(clicker:get_look_yaw())
	end
end


function horseara:on_activate(staticdata, dtime_s)
	self.object:set_armor_groups({immortal=1})
	if staticdata then
		self.v = tonumber(staticdata)
	end
end

function horseara:get_staticdata()
	return tostring(v)
end

function horseara:on_punch(puncher, time_from_last_punch, tool_capabilities, direction)
	self.object:remove()
	if puncher and puncher:is_player() then
		puncher:get_inventory():add_item("main", "kelvar:horsearah1")
	end
end


function horseara:on_step(dtime)

	self.v = get_v(self.object:getvelocity())*get_sign(self.v)
	if self.driver then
		local ctrl = self.driver:get_player_control()
		if ctrl.up then
			self.v = self.v+3
		end
		if ctrl.down then
			self.v = self.v-0.1
		end
		if ctrl.left then
			self.object:setyaw(self.object:getyaw()+math.pi/60+dtime*math.pi/60)
		end
		if ctrl.right then
			self.object:setyaw(self.object:getyaw()-math.pi/60-dtime*math.pi/60)
		end
		if ctrl.jump then
		local p = self.object:getpos()
		p.y = p.y-0.5
			if is_ground(p) then
				local v = self.object:getvelocity()
				v.y = 6
				self.object:setvelocity(v)
			end
		end
	end
	local s = get_sign(self.v)
	self.v = self.v - 0.02*s
	if s ~= get_sign(self.v) then
		self.object:setvelocity({x=0, y=0, z=0})
		self.v = 0
		return
	end
	if math.abs(self.v) > 7 then
		self.v = 7*get_sign(self.v)
	end
	
	local p = self.object:getpos()
	p.y = p.y-0.5
	if not is_ground(p) then
		if minetest.registered_nodes[minetest.get_node(p).name].walkable then
			self.v = 0
		end
		self.object:setacceleration({x=0, y=-10, z=0})
		self.object:setvelocity(get_velocity(self.v, self.object:getyaw(), self.object:getvelocity().y))
	else
		p.y = p.y+1
		if is_ground(p) then
			self.object:setacceleration({x=0, y=3, z=0})
			local y = self.object:getvelocity().y
			if y > 2 then
				y = 2
			end
			if y < 0 then
				self.object:setacceleration({x=0, y=10, z=0})
			end
			self.object:setvelocity(get_velocity(self.v, self.object:getyaw(), y))
		else
			self.object:setacceleration({x=0, y=0, z=0})
			if math.abs(self.object:getvelocity().y) < 1 then
				local pos = self.object:getpos()
				pos.y = math.floor(pos.y)+0.5
				self.object:setpos(pos)
				self.object:setvelocity(get_velocity(self.v, self.object:getyaw(), 0))
			else
				self.object:setvelocity(get_velocity(self.v, self.object:getyaw(), self.object:getvelocity().y))
			end
		end
	end

	if self.object:getvelocity().y > 0.1 then
		local yaw = self.object:getyaw()
		if self.drawtype == "side" then
			yaw = yaw+(math.pi/2)
		end
		local x = math.sin(yaw) * -2
		local z = math.cos(yaw) * 2
		if minetest.get_item_group(minetest.get_node(self.object:getpos()).name, "water") ~= 0 then
			self.object:setacceleration({x = x, y = 2, z = z})
		else
			self.object:setacceleration({x = x, y = -5, z = z})
        end
	else
		if minetest.get_item_group(minetest.get_node(self.object:getpos()).name, "water") ~= 0 then
			self.object:setacceleration({x = 0, y = 2, z = 0})
		else
			self.object:setacceleration({x = 0, y = -5, z = 0})
		end
	end
end

local shireponyblack = {
	physical = true,
	collisionbox = {-0.4, -0.01, -0.4, 0.4, 1, 0.4},
	visual = "mesh",
	stepheight = 1.1,
	visual_size = {x=1.3,y=1.3},
	mesh = "shireponyh1_model.x",
	textures = {"kelvar_shireponyblack.png"},
	driver = nil,
	v = 0,
}


local function is_ground(pos)
	local nn = minetest.get_node(pos).name
	return minetest.get_item_group(nn, "crumbly") ~= 0 or
	minetest.get_item_group(nn, "cracky") ~= 0 or
	minetest.get_item_group(nn, "choppy") ~= 0 or
	minetest.get_item_group(nn, "snappy") ~= 0
end

local function get_sign(i)
	if i == 0 then
		return 0
	else
		return i/math.abs(i)
	end
end

local function get_velocity(v, yaw, y)
	local x = math.cos(yaw)*v
	local z = math.sin(yaw)*v
	return {x=x, y=y, z=z}
end

local function get_v(v)
	return math.sqrt(v.x^2+v.z^2)
end

function shireponyblack:on_rightclick(clicker)
	if not clicker or not clicker:is_player() then
		return
	end
	if self.driver and clicker == self.driver then
		self.driver = nil
		clicker:set_detach()
	elseif not self.driver then
		self.driver = clicker
		clicker:set_attach(self.object, "", {x=0,y=5,z=0}, {x=0,y=0,z=0})
		self.object:setyaw(clicker:get_look_yaw())
	end
end


function shireponyblack:on_activate(staticdata, dtime_s)
	self.object:set_armor_groups({immortal=1})
	if staticdata then
		self.v = tonumber(staticdata)
	end
end

function shireponyblack:get_staticdata()
	return tostring(v)
end

function shireponyblack:on_punch(puncher, time_from_last_punch, tool_capabilities, direction)
	self.object:remove()
	if puncher and puncher:is_player() then
		puncher:get_inventory():add_item("main", "kelvar:shireponyblackh1")
	end
end


function shireponyblack:on_step(dtime)

	self.v = get_v(self.object:getvelocity())*get_sign(self.v)
	if self.driver then
		local ctrl = self.driver:get_player_control()
		if ctrl.up then
			self.v = self.v+1.67
		end
		if ctrl.down then
			self.v = self.v-0.2
		end
		if ctrl.left then
			self.object:setyaw(self.object:getyaw()+math.pi/90+dtime*math.pi/90)
		end
		if ctrl.right then
			self.object:setyaw(self.object:getyaw()-math.pi/90-dtime*math.pi/90)
		end
		if ctrl.jump then
		local p = self.object:getpos()
		p.y = p.y-0.5
			if is_ground(p) then
				local v = self.object:getvelocity()
				v.y = 4
				self.object:setvelocity(v)
			end
		end
	end
	local s = get_sign(self.v)
	self.v = self.v - 0.02*s
	if s ~= get_sign(self.v) then
		self.object:setvelocity({x=0, y=0, z=0})
		self.v = 0
		return
	end
	if math.abs(self.v) > 5 then
		self.v = 5*get_sign(self.v)
	end
	
	local p = self.object:getpos()
	p.y = p.y-0.5
	if not is_ground(p) then
		if minetest.registered_nodes[minetest.get_node(p).name].walkable then
			self.v = 0
		end
		self.object:setacceleration({x=0, y=-10, z=0})
		self.object:setvelocity(get_velocity(self.v, self.object:getyaw(), self.object:getvelocity().y))
	else
		p.y = p.y+1
		if is_ground(p) then
			self.object:setacceleration({x=0, y=3, z=0})
			local y = self.object:getvelocity().y
			if y > 2 then
				y = 2
			end
			if y < 0 then
				self.object:setacceleration({x=0, y=10, z=0})
			end
			self.object:setvelocity(get_velocity(self.v, self.object:getyaw(), y))
		else
			self.object:setacceleration({x=0, y=0, z=0})
			if math.abs(self.object:getvelocity().y) < 1 then
				local pos = self.object:getpos()
				pos.y = math.floor(pos.y)+0.5
				self.object:setpos(pos)
				self.object:setvelocity(get_velocity(self.v, self.object:getyaw(), 0))
			else
				self.object:setvelocity(get_velocity(self.v, self.object:getyaw(), self.object:getvelocity().y))
			end
		end
	end

	if self.object:getvelocity().y > 0.1 then
		local yaw = self.object:getyaw()
		if self.drawtype == "side" then
			yaw = yaw+(math.pi/2)
		end
		local x = math.sin(yaw) * -2
		local z = math.cos(yaw) * 2
		if minetest.get_item_group(minetest.get_node(self.object:getpos()).name, "water") ~= 0 then
			self.object:setacceleration({x = x, y = 2, z = z})
		else
			self.object:setacceleration({x = x, y = -5, z = z})
        end
	else
		if minetest.get_item_group(minetest.get_node(self.object:getpos()).name, "water") ~= 0 then
			self.object:setacceleration({x = 0, y = 2, z = 0})
		else
			self.object:setacceleration({x = 0, y = -5, z = 0})
		end
	end
end

local shirepony = {
	physical = true,
	collisionbox = {-0.4, -0.01, -0.4, 0.4, 1, 0.4},
	visual = "mesh",
	stepheight = 1.1,
	visual_size = {x=1.3,y=1.3},
	mesh = "shireponyh1_model.x",
	textures = {"kelvar_shirepony.png"},
	driver = nil,
	v = 0,
}


local function is_ground(pos)
	local nn = minetest.get_node(pos).name
	return minetest.get_item_group(nn, "crumbly") ~= 0 or
	minetest.get_item_group(nn, "cracky") ~= 0 or
	minetest.get_item_group(nn, "choppy") ~= 0 or
	minetest.get_item_group(nn, "snappy") ~= 0
end

local function get_sign(i)
	if i == 0 then
		return 0
	else
		return i/math.abs(i)
	end
end

local function get_velocity(v, yaw, y)
	local x = math.cos(yaw)*v
	local z = math.sin(yaw)*v
	return {x=x, y=y, z=z}
end

local function get_v(v)
	return math.sqrt(v.x^2+v.z^2)
end

function shirepony:on_rightclick(clicker)
	if not clicker or not clicker:is_player() then
		return
	end
	if self.driver and clicker == self.driver then
		self.driver = nil
		clicker:set_detach()
	elseif not self.driver then
		self.driver = clicker
		clicker:set_attach(self.object, "", {x=0,y=5,z=0}, {x=0,y=0,z=0})
		self.object:setyaw(clicker:get_look_yaw())
	end
end


function shirepony:on_activate(staticdata, dtime_s)
	self.object:set_armor_groups({immortal=1})
	if staticdata then
		self.v = tonumber(staticdata)
	end
end

function shirepony:get_staticdata()
	return tostring(v)
end

function shirepony:on_punch(puncher, time_from_last_punch, tool_capabilities, direction)
	self.object:remove()
	if puncher and puncher:is_player() then
		puncher:get_inventory():add_item("main", "kelvar:shireponyh1")
	end
end


function shirepony:on_step(dtime)

	self.v = get_v(self.object:getvelocity())*get_sign(self.v)
	if self.driver then
		local ctrl = self.driver:get_player_control()
		if ctrl.up then
			self.v = self.v+1.67
		end
		if ctrl.down then
			self.v = self.v-0.2
		end
		if ctrl.left then
			self.object:setyaw(self.object:getyaw()+math.pi/90+dtime*math.pi/90)
		end
		if ctrl.right then
			self.object:setyaw(self.object:getyaw()-math.pi/90-dtime*math.pi/90)
		end
		if ctrl.jump then
		local p = self.object:getpos()
		p.y = p.y-0.5
			if is_ground(p) then
				local v = self.object:getvelocity()
				v.y = 4
				self.object:setvelocity(v)
			end
		end
	end
	local s = get_sign(self.v)
	self.v = self.v - 0.02*s
	if s ~= get_sign(self.v) then
		self.object:setvelocity({x=0, y=0, z=0})
		self.v = 0
		return
	end
	if math.abs(self.v) > 5 then
		self.v = 5*get_sign(self.v)
	end
	
	local p = self.object:getpos()
	p.y = p.y-0.5
	if not is_ground(p) then
		if minetest.registered_nodes[minetest.get_node(p).name].walkable then
			self.v = 0
		end
		self.object:setacceleration({x=0, y=-10, z=0})
		self.object:setvelocity(get_velocity(self.v, self.object:getyaw(), self.object:getvelocity().y))
	else
		p.y = p.y+1
		if is_ground(p) then
			self.object:setacceleration({x=0, y=3, z=0})
			local y = self.object:getvelocity().y
			if y > 2 then
				y = 2
			end
			if y < 0 then
				self.object:setacceleration({x=0, y=10, z=0})
			end
			self.object:setvelocity(get_velocity(self.v, self.object:getyaw(), y))
		else
			self.object:setacceleration({x=0, y=0, z=0})
			if math.abs(self.object:getvelocity().y) < 1 then
				local pos = self.object:getpos()
				pos.y = math.floor(pos.y)+0.5
				self.object:setpos(pos)
				self.object:setvelocity(get_velocity(self.v, self.object:getyaw(), 0))
			else
				self.object:setvelocity(get_velocity(self.v, self.object:getyaw(), self.object:getvelocity().y))
			end
		end
	end

	if self.object:getvelocity().y > 0.1 then
		local yaw = self.object:getyaw()
		if self.drawtype == "side" then
			yaw = yaw+(math.pi/2)
		end
		local x = math.sin(yaw) * -2
		local z = math.cos(yaw) * 2
		if minetest.get_item_group(minetest.get_node(self.object:getpos()).name, "water") ~= 0 then
			self.object:setacceleration({x = x, y = 2, z = z})
		else
			self.object:setacceleration({x = x, y = -5, z = z})
        end
	else
		if minetest.get_item_group(minetest.get_node(self.object:getpos()).name, "water") ~= 0 then
			self.object:setacceleration({x = 0, y = 2, z = 0})
		else
			self.object:setacceleration({x = 0, y = -5, z = 0})
		end
	end
end

minetest.register_craftitem("kelvar:horseh1", {
	description = "Brown Horse",
	inventory_image = "kelvar_horse_inventory.png",
	
	on_place = function(itemstack, placer, pointed_thing)
		if pointed_thing.above then
			minetest.env:add_entity(pointed_thing.above, "kelvar:horseh1")
			if not minetest.setting_getbool("creative_mode") then
				itemstack:take_item()
			end
		end
		return itemstack
	end,
})
minetest.register_entity("kelvar:horseh1", horse)

minetest.register_craftitem("kelvar:horsepegh1", {
	description = "White Horse",
	inventory_image = "kelvar_horsepeg_inventory.png",
	
	on_place = function(itemstack, placer, pointed_thing)
		if pointed_thing.above then
			minetest.env:add_entity(pointed_thing.above, "kelvar:horsepegh1")
			if not minetest.setting_getbool("creative_mode") then
				itemstack:take_item()
			end
		end
		return itemstack
	end,
})
minetest.register_entity("kelvar:horsepegh1", horsepeg)

minetest.register_craftitem("kelvar:horsearah1", {
	description = "Black Horse",
	inventory_image = "kelvar_horseara_inventory.png",
	
	on_place = function(itemstack, placer, pointed_thing)
		if pointed_thing.above then
			minetest.env:add_entity(pointed_thing.above, "kelvar:horsearah1")
			if not minetest.setting_getbool("creative_mode") then
				itemstack:take_item()
			end
		end
		return itemstack
	end,
})
minetest.register_entity("kelvar:horsearah1", horseara)

minetest.register_craftitem("kelvar:shireponyh1", {
	description = "Shire Pony",
	inventory_image = "kelvar_shirepony_inventory.png",
	
	on_place = function(itemstack, placer, pointed_thing)
		if pointed_thing.above then
			minetest.env:add_entity(pointed_thing.above, "kelvar:shireponyh1")
			if not minetest.setting_getbool("creative_mode") then
				itemstack:take_item()
			end
		end
		return itemstack
	end,
})
minetest.register_entity("kelvar:shireponyh1", shirepony)

minetest.register_craftitem("kelvar:shireponyblackh1", {
	description = "Shire Pony",
	inventory_image = "kelvar_shireponyblack_inventory.png",
	
	on_place = function(itemstack, placer, pointed_thing)
		if pointed_thing.above then
			minetest.env:add_entity(pointed_thing.above, "kelvar:shireponyblackh1")
			if not minetest.setting_getbool("creative_mode") then
				itemstack:take_item()
			end
		end
		return itemstack
	end,
})
minetest.register_entity("kelvar:shireponyblackh1", shireponyblack)

kelvar:register_mob("kelvar:horse", {
	type = "animal",
	hp_min = 5,
     hp_max = 7,
	collisionbox = {-0.4, -0.01, -0.4, 0.4, 1, 0.4},
	available_textures = {
		total = 1,
		texture_1 = {"kelvar_horse.png"},
	},
	visual = "mesh",
	mesh = "horse_model.x",
	makes_footstep_sound = true,
	walk_velocity = 1,
	armor = 200,
	drops = {
		{name = "kelvar:meat_raw",
		chance = 1,
		min = 2,
		max = 3,},
	},
	drawtype = "front",
	water_damage = 1,
	lava_damage = 5,
	light_damage = 0,
     sounds = {
		random = "",
     },
	animation = {
		speed_normal = 15,
		stand_start = 25,
		stand_= 75,
		walk_start = 75,
		walk_end = 100,
	},
	follow = "farming:wheat",
	view_range = 5,
	on_rightclick = function(self, clicker)
		local item = clicker:get_wielded_item()
		if item:get_name() == "farming:wheat" then
               clicker:get_inventory():add_item("main", "kelvar:horseh1")
               if not minetest.setting_getbool("creative_mode") then
			     item:take_item()
                    clicker:set_wielded_item(item)
               end
			self.object:remove()
		end
	end,
     jump = true,
	step=1,
	passive = true,
})
kelvar:register_spawn("kelvar:horse", {"cemen:rohan_grass"}, 20, -1, 6000, 3, 31000)

kelvar:register_mob("kelvar:horsepeg", {
	type = "animal",
	hp_min = 5,
     hp_max = 7,
	collisionbox = {-0.4, -0.01, -0.4, 0.4, 1, 0.4},
	available_textures = {
		total = 1,
		texture_1 = {"kelvar_horsepeg.png"},
	},
	visual = "mesh",
	mesh = "horse_model.x",
	makes_footstep_sound = true,
	walk_velocity = 1,
	armor = 200,
	drops = {
		{name = "kelvar:meat_raw",
		chance = 1,
		min = 2,
		max = 3,},
	},
	drawtype = "front",
	water_damage = 1,
	lava_damage = 5,
	light_damage = 0,
     sounds = {
		random = "",
     },
	animation = {
		speed_normal = 15,
		stand_start = 25,
		stand_end = 75,
		walk_start = 75,
		walk_end = 100,
	},
	follow = "farming:wheat",
	view_range = 5,
	on_rightclick = function(self, clicker)
		local item = clicker:get_wielded_item()
		if item:get_name() == "farming:wheat" then
               clicker:get_inventory():add_item("main", "kelvar:horsepegh1")
               if not minetest.setting_getbool("creative_mode") then
			     item:take_item()
                    clicker:set_wielded_item(item)
               end
			self.object:remove()
		end
	end,
     jump = true,
	step=1,
	passive = true,
})
kelvar:register_spawn("kelvar:horsepeg", {"cemen:rohan_grass"}, 20, -1, 7000, 3, 31000)


kelvar:register_mob("kelvar:horseara", {
	type = "animal",
	hp_min = 5,
     hp_max = 7,
	collisionbox = {-0.4, -0.01, -0.4, 0.4, 1, 0.4},
	available_textures = {
		total = 1,
		texture_1 = {"kelvar_horseara.png"},
	},
	visual = "mesh",
	mesh = "horse_model.x",
	makes_footstep_sound = true,
	walk_velocity = 1,
	armor = 200,
	drops = {
		{name = "kelvar:meat_raw",
		chance = 1,
		min = 2,
		max = 3,},
	},
	drawtype = "front",
	water_damage = 1,
	lava_damage = 5,
	light_damage = 0,
     sounds = {
		random = "",
     },
	animation = {
		speed_normal = 15,
		stand_start = 25,
		stand_end = 75,
		walk_start = 75,
		walk_end = 100,
	},
	follow = "farming:wheat",
	view_range = 5,
	on_rightclick = function(self, clicker)
		local item = clicker:get_wielded_item()
		if item:get_name() == "farming:wheat" then
               clicker:get_inventory():add_item("main", "kelvar:horsearah1")
               if not minetest.setting_getbool("creative_mode") then
			     item:take_item()
                    clicker:set_wielded_item(item)
               end
			self.object:remove()
		end
	end,
     jump = true,
	step=1,
	passive = true,
})
kelvar:register_spawn("kelvar:horseara", {"cemen:rohan_grass"}, 20, -1, 7000, 3, 31000)

kelvar:register_mob("kelvar:shirepony", {
	type = "animal",
	hp_min = 5,
     hp_max = 7,
	collisionbox = {-0.4, -0.01, -0.4, 0.4, 1, 0.4},
	available_textures = {
		total = 1,
		texture_1 = {"kelvar_shirepony.png"},
	},
	visual = "mesh",
	mesh = "shirepony_model.x",
	makes_footstep_sound = true,
	walk_velocity = 1,
	armor = 200,
     visual_size = {x=1.3,y=1.3},
	drops = {
		{name = "kelvar:meat_raw",
		chance = 1,
		min = 2,
		max = 3,},
	},
	drawtype = "front",
	water_damage = 1,
	lava_damage = 5,
	light_damage = 0,
     sounds = {
		random = "",
     },
	animation = {
		speed_normal = 15,
		stand_start = 0,
		stand_end = 40,
		walk_start = 45,
		walk_end = 85,
	},
	follow = "farming:wheat",
	view_range = 5,
	on_rightclick = function(self, clicker)
		local item = clicker:get_wielded_item()
		if item:get_name() == "farming:wheat" then
               clicker:get_inventory():add_item("main", "kelvar:shireponyh1")
               if not minetest.setting_getbool("creative_mode") then
			     item:take_item()
                    clicker:set_wielded_item(item)
               end
			self.object:remove()
		end
	end,
     jump = true,
	step=1,
	passive = true,
})
kelvar:register_spawn("kelvar:shirepony", {"cemen:shire_grass"}, 20, -1, 6000, 3, 31000)

kelvar:register_mob("kelvar:shireponyblack", {
	type = "animal",
	hp_min = 5,
     hp_max = 7,
	collisionbox = {-0.4, -0.01, -0.4, 0.4, 1, 0.4},
	available_textures = {
		total = 1,
		texture_1 = {"kelvar_shireponyblack.png"},
	},
	visual = "mesh",
	mesh = "shirepony_model.x",
	makes_footstep_sound = true,
	walk_velocity = 1,
	armor = 200,
     visual_size = {x=1.3,y=1.3},
	drops = {
		{name = "kelvar:meat_raw",
		chance = 1,
		min = 2,
		max = 3,},
	},
	drawtype = "front",
	water_damage = 1,
	lava_damage = 5,
	light_damage = 0,
     sounds = {
		random = "",
     },
	animation = {
		speed_normal = 15,
		stand_start = 0,
		stand_end = 40,
		walk_start = 45,
		walk_end = 85,
	},
	follow = "farming:wheat",
	view_range = 5,
	on_rightclick = function(self, clicker)
		local item = clicker:get_wielded_item()
		if item:get_name() == "farming:wheat" then
               clicker:get_inventory():add_item("main", "kelvar:shireponyblackh1")
               if not minetest.setting_getbool("creative_mode") then
			     item:take_item()
                    clicker:set_wielded_item(item)
               end
			self.object:remove()
		end
	end,
     jump = true,
	step=1,
	passive = true,
})
kelvar:register_spawn("kelvar:shireponyblack", {"cemen:shire_grass"}, 20, -1, 9000, 3, 31000)
