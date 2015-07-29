var/global/list/gear_datums = list()

proc/populate_gear_list()
	for(var/type in typesof(/datum/gear)-/datum/gear)
		var/datum/gear/G = new type()
		gear_datums[G.display_name] = G

/datum/gear
	var/display_name       //Name/index.
	var/path               //Path to item.
	var/cost               //Number of points used.
	var/slot               //Slot to equip to.
	var/list/allowed_roles //Roles that can spawn with this item.
	var/whitelisted        //Term to check the whitelist for..

//Uncertain



//Standard gear datums.
//Small Items and simple visual accessories are 1 point

/datum/gear/armband
	display_name = "armband (red)"
	path = /obj/item/clothing/tie/armband
	cost = 1

/datum/gear/armband_cargo
	display_name = "armband (cargo)"
	path = /obj/item/clothing/tie/armband/cargo
	cost = 1

/datum/gear/armband_engineering
	display_name = "armband (engineering)"
	path = /obj/item/clothing/tie/armband/engine
	cost = 1

/datum/gear/armband_science
	display_name = "armband (science)"
	path = /obj/item/clothing/tie/armband/science
	cost = 1

/datum/gear/armband_hydroponics
	display_name = "armband (hydroponics)"
	path = /obj/item/clothing/tie/armband/hydro
	cost = 1

/datum/gear/armband_medical
	display_name = "armband (medical)"
	path = /obj/item/clothing/tie/armband/med
	cost = 1

/datum/gear/armband_emt
	display_name = "armband (EMT)"
	path = /obj/item/clothing/tie/armband/medgreen
	cost = 1

/datum/gear/cards
	display_name = "deck of cards"
	path = /obj/item/weapon/deck
	cost = 1

/datum/gear/clipboard
	display_name = "clipboard"
	path = /obj/item/weapon/clipboard
	cost = 1

/datum/gear/dice
	display_name = "d20"
	path = /obj/item/weapon/dice/d20
	cost = 1

/datum/gear/redpen
	display_name = "pen (red)"
	path = /obj/item/weapon/pen/red
	cost = 1

/datum/gear/bluepen
	display_name = "pen (blue)"
	path = /obj/item/weapon/pen/blue
	cost = 1

/datum/gear/comb
	display_name = "purple comb"
	path = /obj/item/weapon/fluff/cado_keppel_1
	cost = 1

/datum/gear/tie_blue
	display_name = "tie (blue)"
	path = /obj/item/clothing/tie/blue
	cost = 1

/datum/gear/sandal
	display_name = "sandals"
	path = /obj/item/clothing/shoes/sandal
	cost = 1

/datum/gear/black_shoes
	display_name = "shoes (black)"
	path = /obj/item/clothing/shoes/black
	cost = 1

/datum/gear/blue_shoes
	display_name = "shoes (blue)"
	path = /obj/item/clothing/shoes/blue
	cost = 1

/datum/gear/brown_shoes
	display_name = "shoes (brown)"
	path = /obj/item/clothing/shoes/brown
	cost = 1

/datum/gear/green_shoes
	display_name = "shoes (green)"
	path = /obj/item/clothing/shoes/green
	cost = 1

/datum/gear/orange_shoes
	display_name = "shoes (orange)"
	path = /obj/item/clothing/shoes/orange
	cost = 1

/datum/gear/purple_shoes
	display_name = "shoes (purple)"
	path = /obj/item/clothing/shoes/purple
	cost = 1

/datum/gear/red_shoes
	display_name = "shoes (red)"
	path = /obj/item/clothing/shoes/red
	cost = 1

/datum/gear/white_shoes
	display_name = "shoes (white)"
	path = /obj/item/clothing/shoes/white
	cost = 1

/datum/gear/yellow_shoes
	display_name = "shoes (yellow)"
	path = /obj/item/clothing/shoes/yellow
	cost = 1

/datum/gear/tie_horrible
	display_name = "tie (horrible)"
	path = /obj/item/clothing/tie/horrible
	cost = 1

/datum/gear/tie_red
	display_name = "tie (red)"
	path = /obj/item/clothing/tie/red
	cost = 1

/datum/gear/wallet
	display_name = "wallet"
	path = /obj/item/weapon/storage/wallet
	cost = 1

/datum/gear/watch
	display_name = "watch"
	path = /obj/item/clothing/gloves/watch
	cost = 1







//Items with an actual use are two points

/datum/gear/bandana
	display_name = "pirate bandana"
	path = /obj/item/clothing/head/bandana
	cost = 2

/datum/gear/hairflower
	display_name = "hair flower pin"
	path = /obj/item/clothing/head/hairflower
	cost = 2

/datum/gear/zippolighter
	display_name = "zippo lighter"
	path = /obj/item/weapon/lighter/zippo
	cost = 2

/datum/gear/camera
	display_name = "camera"
	path = /obj/item/device/camera
	cost = 2

/datum/gear/cane
	display_name = "cane"
	path = /obj/item/weapon/cane
	cost = 2

/datum/gear/briefcase
	display_name = "briefcase"
	path = /obj/item/weapon/storage/briefcase
	cost = 2

/datum/gear/recorder
	display_name = "universal recorder"
	path = /obj/item/device/taperecorder
	cost = 2

/datum/gear/flask
	display_name = "flask"
	path = /obj/item/weapon/reagent_containers/food/drinks/flask/barflask
	cost = 2

/datum/gear/overalls
	display_name = "overalls"
	path = /obj/item/clothing/suit/apron/overalls
	cost = 2

/datum/gear/wcoat
	display_name = "waistcoat"
	path = /obj/item/clothing/suit/wcoat
	cost = 2


/datum/gear/eyepatch
	display_name = "eyepatch"
	path = /obj/item/clothing/glasses/eyepatch
	cost = 2

/datum/gear/flatcap
	display_name = "flat cap"
	path = /obj/item/clothing/head/flatcap
	cost = 2


/datum/gear/redsoftcap
	display_name = "red softcap"
	path = /obj/item/clothing/head/soft/red
	cost = 2

/datum/gear/bluesoftcap
	display_name = "blue softcap"
	path = /obj/item/clothing/head/soft/blue
	cost = 2

/datum/gear/greensoftcap
	display_name = "green softcap"
	path = /obj/item/clothing/head/soft/green
	cost = 2

/datum/gear/greysoftcap
	display_name = "grey softcap"
	path = /obj/item/clothing/head/soft/grey
	cost = 2

/datum/gear/purplesoftcap
	display_name = "purple softcap"
	path = /obj/item/clothing/head/soft/purple
	cost = 2

/datum/gear/work_boots
	display_name = "work boots"
	path = /obj/item/clothing/shoes/work_boots
	cost = 2

/datum/gear/jackboots
	display_name = "jackboots"
	path = /obj/item/clothing/shoes/jackboots
	cost = 2

/datum/gear/leather
	display_name = "leather shoes"
	path = /obj/item/clothing/shoes/leather
	cost = 2

/datum/gear/dress_shoes
	display_name = "dress shoes"
	path = /obj/item/clothing/shoes/centcom
	cost = 2

/datum/gear/black_gloves
	display_name = "black gloves"
	path = /obj/item/clothing/gloves/black
	cost = 2

/datum/gear/red_gloves
	display_name = "red gloves"
	path = /obj/item/clothing/gloves/red
	cost = 2

/datum/gear/blue_gloves
	display_name = "blue gloves"
	path = /obj/item/clothing/gloves/blue
	cost = 2

/datum/gear/orange_gloves
	display_name = "orange gloves"
	path = /obj/item/clothing/gloves/orange
	cost = 2

/datum/gear/purple_gloves
	display_name = "purple gloves"
	path = /obj/item/clothing/gloves/purple
	cost = 2

/datum/gear/brown_gloves
	display_name = "brown gloves"
	path = /obj/item/clothing/gloves/brown
	cost = 2

/datum/gear/green_gloves
	display_name = "green gloves"
	path = /obj/item/clothing/gloves/green
	cost = 2

/datum/gear/normal_beret
	display_name = "beret"
	path = /obj/item/clothing/head/beret
	cost = 2

/datum/gear/sec_beret
	display_name = "security beret"
	path = /obj/item/clothing/head/beret/sec
	cost = 2

/datum/gear/eng_beret
	display_name = "engineering beret"
	path = /obj/item/clothing/head/beret/eng
	cost = 2

/datum/gear/engineer_bandana
	display_name = "engineering bandana"
	path = /obj/item/clothing/head/helmet/greenbandana/fluff/taryn_kifer_1
	cost = 2

/datum/gear/scanning_goggles
	display_name = "scanning goggles"
	path = /obj/item/clothing/glasses/fluff/uzenwa_sissra_1
	cost = 2

//Edge case department gear

/datum/gear/cigar_case
	display_name = "cigar case"
	path = /obj/item/weapon/storage/fancy/cigars
	cost = 3

/datum/gear/white_gloves
	display_name = "white gloves"
	path = /obj/item/clothing/gloves/white
	cost = 3

/datum/gear/armpit
	display_name = "shoulder holster"
	path = /obj/item/clothing/tie/holster/armpit
	cost = 3

/datum/gear/waist
	display_name = "waist holster"
	path = /obj/item/clothing/tie/holster/waist
	cost = 3

/datum/gear/webbing
	display_name = "webbing"
	path = /obj/item/clothing/tie/storage/webbing
	cost = 3

/datum/gear/securebriefcase
	display_name = "secure briefcase"
	path = /obj/item/weapon/storage/secure/briefcase
	cost = 3

//"Department locked" gear. (No actual department locks) and uniforms

/datum/gear/skirt_blue
	display_name = "blue plaid skirt"
	path = /obj/item/clothing/under/dress/plaid_blue
	cost = 4

/datum/gear/skirt_red
	display_name = "red plaid skirt"
	path = /obj/item/clothing/under/dress/plaid_red
	cost = 4

/datum/gear/skirt_purple
	display_name = "purple plaid skirt"
	path = /obj/item/clothing/under/dress/plaid_purple
	cost = 4

/datum/gear/skirt_green
	display_name = "green plaid skirt"
	path = /obj/item/clothing/under/dress/plaid_green
	cost = 4

/datum/gear/skirt_black
	display_name = "black skirt"
	path = /obj/item/clothing/under/blackskirt
	cost = 4

/datum/gear/kilt
	display_name = "kilt"
	path = /obj/item/clothing/under/kilt
	cost = 4

/datum/gear/sundress
	display_name = "sundress"
	path = /obj/item/clothing/under/sundress
	cost = 4

/datum/gear/exec_suit
	display_name = "executive suit"
	path = /obj/item/clothing/under/suit_jacket/really_black
	cost = 4

/datum/gear/oldmansuit
	display_name = "old man suit"
	path = /obj/item/clothing/under/lawyer/oldman
	cost = 4

/datum/gear/prescription
	display_name = "prescription sunglasses"
	path = /obj/item/clothing/glasses/sunglasses/prescription
	cost = 4

/datum/gear/labcoat
	display_name = "labcoat"
	path = /obj/item/clothing/suit/storage/labcoat
	cost = 4

/datum/gear/bluescrubs
	display_name = "blue scrubs"
	path = /obj/item/clothing/under/rank/medical/blue
	cost = 4

/datum/gear/purplescrubs
	display_name = "purple scrubs"
	path = /obj/item/clothing/under/rank/medical/purple
	cost = 4

/datum/gear/greenscrubs
	display_name = "green scrubs"
	path = /obj/item/clothing/under/rank/medical/green
	cost = 4

/datum/gear/surgeryapron
	display_name = "surgical apron"
	path = /obj/item/clothing/suit/apron/surgery
	cost = 4

/datum/gear/unathi_robe
	display_name = "roughspun robe"
	path = /obj/item/clothing/suit/unathi/robe
	cost = 4

/datum/gear/unathi_mantle
	display_name = "hide mantle"
	path = /obj/item/clothing/suit/unathi/mantle
	cost = 4

//REALLY GOOD department gear

/datum/gear/yellow_gloves
	display_name = "yellow gloves"
	path = /obj/item/clothing/gloves/yellow
	cost = 5

/datum/gear/black_vest
	display_name = "black webbing vest"
	path = /obj/item/clothing/tie/storage/black_vest
	cost = 5

/datum/gear/brown_vest
	display_name = "brown webbing vest"
	path = /obj/item/clothing/tie/storage/brown_vest
	cost = 5