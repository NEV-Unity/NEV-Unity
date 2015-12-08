/obj/item/clothing/shoes/jackboots/tesau
	name = "tesau jackboots"
	desc = "catbat boots for catbat scenarios or catbat situations. All catbat, all the time."
	icon_state = "tesjackboots"
	item_state = "tesjackboots"
	item_color = "hosred"
	species_restricted = list("Tesau")

/obj/item/clothing/shoes/jackboots/unathi
	name = "unathi jackboots"
	desc = "combat boots for combat scenarios. Also useful for jamming up the arse of anyone who looks at you sideways."
	icon_state = "jackboots"
	item_state = "jackboots"
	item_color = "hosred"
	species_restricted = list("Unathi")

/obj/item/clothing/shoes/work_boots/tesau
	name = "Steel Toe Boots"
	desc = "Steel Toe cap working boots for engineers and miners. They are fitted for a digitigrade foot."
	icon_state = "tessteelboots"
	item_state = "tessteelboots"
	species_restricted = list("Tesau")

/obj/item/clothing/shoes/work_boots/unathi
	name = "Steel Toe Boots"
	desc = "Steel Toe cap working boots for engineers and miners. They have extra space to accomidate Unathi claws."
	icon_state = "steelboots"
	item_state = "steelboots"
	species_restricted = list("Unathi")

/obj/item/weapon/storage/belt/advanced
	name = "Custom Toolbelt"
	desc = "A large, well-worn toolbelt favored by career engineers."
	icon = 'icons/obj/custom_items/jace_belt.dmi'
	contained_sprite = 1
	icon_state = "jace_belt"

	can_hold = list(
		"/obj/item/weapon/crowbar",
		"/obj/item/weapon/screwdriver",
		"/obj/item/weapon/weldingtool",
		"/obj/item/weapon/wirecutters",
		"/obj/item/weapon/wrench",
		"/obj/item/device/multitool",
		"/obj/item/device/flashlight",
		"/obj/item/weapon/cable_coil",
		"/obj/item/device/t_scanner",
		"/obj/item/device/analyzer",
		"/obj/item/taperoll/engineering",
		"/obj/item/weapon/rcd",
		"/obj/item/weapon/rcd_ammo",
		"/obj/item/weapon/firealarm_electronics",
		"/obj/item/weapon/circuitboard",
		"/obj/item/weapon/airalarm_electronics",
		"/obj/item/weapon/airlock_electronics",
		"/obj/item/weapon/module/power_control",
		"/obj/item/weapon/cell",
		"/obj/item/weapon/hand_tele")
	storage_slots = 14
	max_combined_w_class = 42
	max_w_class = 3
