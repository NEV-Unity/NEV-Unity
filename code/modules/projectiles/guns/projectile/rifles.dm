//Rifles and such. -Kerbal22
//Work in progress. Please excuse the mess.

/obj/item/weapon/gun/projectile/rifle/
	name = "Rifle"
	desc = "A basic rifle. Fires 9mm rounds."
	//All of this is copy-pasted from automatic.dm -Kerbal22
	icon_state = "saber"	//ugly
	w_class = 3.0
	max_shells = 24
	caliber = "9mm"
	origin_tech = "combat=3;materials=2"
	ammo_type = "/obj/item/ammo_casing/c9mm"
	automatic = 0
	fire_delay = 1
	fire_cooldown = 3
	projectiles_per_shot = 1
	//Taken from C20r code -Kerbal22
	fire_sound = 'sound/weapons/rifle.ogg'
	load_method = 2

	New()
		..()
		empty_mag = new /obj/item/ammo_magazine/mc9mm/empty
		update_icon()
		return


	afterattack(atom/target as mob|obj|turf|area, mob/living/user as mob|obj, flag)
		..()
		if(!loaded.len && empty_mag)
			empty_mag.loc = get_turf(src.loc)
			empty_mag = null
			playsound(user, 'sound/weapons/smg_empty_alarm.ogg', 40, 1)
			update_icon()
			return

/obj/item/weapon/gun/projectile/rifle/z4r
	name = "Z-4R Rifle"
	desc = "Made by Zytech Industries. Fires 9mm rounds."
	//All of this is copy-pasted from automatic.dm -Kerbal22
	icon_state = "saber"	//ugly
	w_class = 3.0
	max_shells = 24
	caliber = "9mm"
	origin_tech = "combat=3;materials=2"
	ammo_type = "/obj/item/ammo_casing/c9mm"
	automatic = 0
	fire_delay = 1
	fire_cooldown = 3
	projectiles_per_shot = 1
	//Taken from C20r code -Kerbal22
	fire_sound = 'sound/weapons/rifle.ogg'
	load_method = 2

	New()
		..()
		empty_mag = new /obj/item/ammo_magazine/mc9mm/empty
		update_icon()
		return


	afterattack(atom/target as mob|obj|turf|area, mob/living/user as mob|obj, flag)
		..()
		if(!loaded.len && empty_mag)
			empty_mag.loc = get_turf(src.loc)
			empty_mag = null
			playsound(user, 'sound/weapons/smg_empty_alarm.ogg', 40, 1)
			update_icon()
			return

/obj/item/weapon/gun/projectile/rifle/falcon
	name = "CR4 Falcon"
	desc = "A rifle that fires shotgun rounds. How curious. Fires a three round burst."
	icon_state = "saber"	//ugly
	w_class = 3.0
	max_shells = 16
	origin_tech = "combat=3;materials=5"
	ammo_type = "/obj/item/ammo_casing/shotgun"
	caliber = "shotgun"
	automatic = 0
	fire_delay = 2
	fire_cooldown = 3
	projectiles_per_shot = 3
	fire_sound = 'sound/weapons/rifle.ogg'
	load_method = 2

	New()
		..()
		empty_mag = new /obj/item/ammo_magazine/falcon/empty
		update_icon()
		return


	afterattack(atom/target as mob|obj|turf|area, mob/living/user as mob|obj, flag)
		..()
		if(!loaded.len && empty_mag)
			empty_mag.loc = get_turf(src.loc)
			empty_mag = null
			playsound(user, 'sound/weapons/smg_empty_alarm.ogg', 40, 1)
			update_icon()
			return


/obj/item/weapon/gun/projectile/rifle/zephyr
	name = "EM2 Zephyr"
	desc = "An electromagnetic rifle. Looks dangerous. Fires specialized projectiles. Fires a two round burst."
	icon_state = "saber"	//ugly
	w_class = 4.0
	max_shells = 24
	caliber = "em"
	origin_tech = "combat=3;materials=5"
	ammo_type = "/obj/item/ammo_casing/em"
	automatic = 0
	fire_delay = 2
	fire_cooldown = 3
	projectiles_per_shot = 2
	fire_sound = 'sound/weapons/rifle.ogg'
	load_method = 2

	New()
		..()
		empty_mag = new /obj/item/ammo_magazine/em/empty
		update_icon()
		return


	afterattack(atom/target as mob|obj|turf|area, mob/living/user as mob|obj, flag)
		..()
		if(!loaded.len && empty_mag)
			empty_mag.loc = get_turf(src.loc)
			empty_mag = null
			playsound(user, 'sound/weapons/smg_empty_alarm.ogg', 40, 1)
			update_icon()
			return

