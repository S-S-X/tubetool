## What tubetool? And why?

Tubetool Minetest mod provides tool for cloning pipeworks node configurations like sorting tube configuration.

## How to use tubetool:wand

#### Copy configuration from pipeworks node

Hold wand in your hand and point node that you want to copy configuration from, hold special or sneak button and left click on node to copy settings.
Chat will display confirmation message when configuration is copied to wand.

#### Apply copied configuration to pipeworks node

Hold wand containing desired configuation in you hand and point node that you want apply settings to.
Left click with wand to apply new settings, chat will display confirmation message when settings are applied to pointed node.

## How to add supported nodes

Example to add node technic:injector for tubetool

```
local definition = {
	group = "technic injector",
	copy = function(node, pos, player)
		-- add code for copying data from pointed injector node
		-- for example get some metadata and store it in wand memory
		-- also set some nice description of wand
		local meta = minetest.get_meta(pos)
		return {
			description = "This wand has some injector data",
			myvalue = meta:get_string("owner")
		}
	end,
	paste = function(node, pos, player, data)
		local meta = minetest.get_meta(pos)
		meta:set_string("owner", data.myvalue)
	end,
}
tubetool:register_node("technic:injector", definition)
```

That's all, now you can use tubetool wand to copy/paste metadata owner value from one injector to another.

## Registered nodes included with tubetool

In nodes subdirectory there is few predefined pipeworks components.

## Minetest protection checks

Protection checks are done automatically for all wand uses, node registration does not need any protection checks.
Wand cannot be used to read settings from protected nodes and it cannot be used to write settings to protected nodes.
