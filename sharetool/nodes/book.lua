--
-- Register books for sharetool
--

-- books
local nodes = {}

local bookcolors = {
	"red",
	"green",
	"blue",
	"violet",
	"grey",
	"brown"
}

for _, color in ipairs(bookcolors) do
	table.insert(nodes, string.format("homedecor:book_%s", color))
	table.insert(nodes, string.format("homedecor:book_open_%s", color))
end
table.insert(nodes, "homedecor:book")
table.insert(nodes, "homedecor:book_open")

-- get namespace defined at sharetool init.lua
local ns = metatool.ns('sharetool')

local nodedef = {
	group = 'shared book',
}

function nodedef:before_read(nodedef, pos, player)
	if ns:can_bypass(pos, player, 'owner') or metatool.before_read(nodedef, pos, player, true) then
		-- Player is allowed to bypass protections or operate in area
		return true
	end
	return false
end

function nodedef:before_write(nodedef, pos, player)
	if ns:can_bypass(pos, player, 'owner') or metatool.before_write(nodedef, pos, player, true) then
		-- Player is allowed to bypass protections or operate in area
		return true
	end
	return false
end

function nodedef:copy(node, pos, player)
	-- Copy function does not really copy anything here
	-- but instead it will claim ownership of pointed
	-- node and mark it as shared node
	local meta = minetest.get_meta(pos)
	local name = player:get_player_name()

	-- change ownership and mark as shared node
	ns.mark_shared(meta)
	meta:set_string("owner", name)

	-- return new description for tool
	return {
		description = string.format("Claimed ownership of %s at %s", node.name, minetest.pos_to_string(pos))
	}
end

function nodedef:paste(node, pos, player, data)
	-- Paste function does not really paste anything here
	-- but instead it will restore ownership of pointed
	-- node and mark it as shared node
	local meta = minetest.get_meta(pos)

	-- change ownership and mark as shared node
	ns.mark_shared(meta)
	meta:set_string("owner", ns.shared_account)
end

return {
	name = 'book',
	nodes = nodes,
	tooldef = nodedef,
}
