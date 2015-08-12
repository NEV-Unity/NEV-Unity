//Reworked and refactored by Pixelnator on 20.3.2014 to support printing items directly into peoples hands provided they accept the give prompt.
//Updated by Pixelnator on 12.8.2015 to work with Unity2.0 code.

/*
CONTAINS:
RSF
*/
/obj/item/weapon/rsf
	name = "rapid-service-fabricator (RSF)"
	desc = "A device used to rapidly deploy service items."
	icon = 'icons/obj/items.dmi'
	icon_state = "rcd"
	opacity = 0
	density = 0
	anchored = 0.0
	flags = FPRINT | TABLEPASS| CONDUCT
	force = 10.0
	throwforce = 10.0
	throw_speed = 1
	throw_range = 5
	w_class = 3.0
	matter = list("metal" = 50000)
	origin_tech = "engineering=2;materials=1"
	var/stored_matter = 0
	var/working = 0
	var/mode = 1
	var/setting = "Dosh"
	var/disabled = 0

	New()
		desc = "An RSF. It currently holds [stored_matter]/30 fabrication-units."
		return

	attackby(obj/item/weapon/W, mob/user)
		..()
		if(istype(W, /obj/item/weapon/rcd_ammo))
			if((stored_matter + 10) > 30)
				user << "<span class='notice'>The RSF cant hold any more matter-units.</span>"
				return
			user.drop_item()
			del(W)
			stored_matter += 10
			playsound(src.loc, 'sound/machines/click.ogg', 10, 1)
			user << "<span class='notice'>The RSF now holds [stored_matter]/30 matter-units.</span>"
			desc = "An RSF. It currently holds [stored_matter]/30 matter-units."
			return

	attack_self(mob/user as mob)
		//Change the mode - I could probably add sparks here but I don't think the fabber is heavy duty enough
		playsound(src.loc, 'sound/effects/pop.ogg', 50, 0)
		switch(mode)
			if (1)
				mode = 2
				setting = "Drinking Glass"
				printsetting()
				return
			if (2)
				mode = 3
				setting = "Paper"
				printsetting()
				return
			if (3)
				mode = 4
				setting = "Pen"
				printsetting()
				return
			if (4)
				mode = 5
				setting = "Dice Pack"
				printsetting()
				return
			if (5)
				mode = 6
				setting = "Cigarette"
				printsetting()
				return
			if (6)
				mode = 1
				setting = "Dosh"
				printsetting()
				return

	proc/activate()
		playsound(src.loc, 'sound/machines/click.ogg', 10, 1)

	proc/printsetting()
		usr << "<span class='notice'>Changed dispensing mode to '[setting]'</span>"

	proc/printmessage()
		usr << "Dispensing [setting]..."


	afterattack(atom/A, mob/user as mob, proximity)
		if(!proximity) return
		if(disabled && !isrobot(user)) //Disabled RSFs don't work unless you're a borg
			return 0
		if (!(istype(A,/obj/structure/table) || istype(A,/turf/simulated/floor) || istype(A,/turf/unsimulated/floor))) //Unsimulated floors are supported if service borgs go on away missions
			return 0

		switch(mode)
			if(1)
				if(useResource(10, user))
					printmessage()
					activate()
					if(istype(A, /turf/simulated/floor))
						new /obj/item/weapon/spacecash/c10( A )
					if(istype(A, /obj/structure/table))
						new /obj/item/weapon/spacecash/c10( A.loc )
					return 1
				return 0

			if(2)
				if(useResource(2, user))
					printmessage()
					activate()
					if(istype(A, /turf/simulated/floor))
						new /obj/item/weapon/reagent_containers/food/drinks/drinkingglass( A )
					if(istype(A, /obj/structure/table))
						new /obj/item/weapon/reagent_containers/food/drinks/drinkingglass( A.loc )
					return 1
				return 0

			if(3)
				if(useResource(1, user))
					printmessage()
					activate()
					if(istype(A, /turf/simulated/floor))
						new /obj/item/weapon/paper( A )
					if(istype(A, /obj/structure/table))
						new /obj/item/weapon/paper( A.loc )
					return 1
				return 0

			if(4)
				if(useResource(2, user))
					printmessage()
					activate()
					if(istype(A, /turf/simulated/floor))
						new /obj/item/weapon/pen( A )
					if(istype(A,/obj/structure/table))
						new /obj/item/weapon/pen( A.loc )
					return 1
				return 0

			if(5)
				if(useResource(10, user))
					printmessage()
					activate()
					if(istype(A, /turf/simulated/floor))
						new /obj/item/weapon/storage/pill_bottle/dice( A )
					if(istype(A,/obj/structure/table))
						new /obj/item/weapon/storage/pill_bottle/dice( A.loc )
					return 1
				return 0

			if(6)
				if(useResource(1, user))
					printmessage()
					activate()
					if(istype(A, /turf/simulated/floor))
						new /obj/item/clothing/mask/cigarette( A )
					if(istype(A,/obj/structure/table))
						new /obj/item/clothing/mask/cigarette( A.loc )
					return 1
				return 0
			else
				user << "ERROR: RSF in MODE: [mode] attempted use by [user]. Send this text to an admin."
				return 0

	attack(mob/M as mob, mob/user as mob)
		if (istype(M, /mob/living/carbon/human) && M != usr) //Only give items to humanoid characters and only if you're giving it to someone else.
			if (checkResource(1, user)) //Only give the prompt if the RSF has ammo or the borg has battery
				switch(alert(M,"[usr] wants to print you \a [setting]?",,"Yes","No"))
					if("Yes")
						switch(mode)
							if (1)
								if(!Adjacent(usr))
									usr << "You need to keep in reaching distance."
									M << "[usr.name] moved too far away."
									return
								if(M.r_hand != null)
									if(M.l_hand == null)
										if (useResource(10, user))
											M.put_in_l_hand(new /obj/item/weapon/spacecash/c10(M))
											printmessage()
											activate()
											return 1
										return 0

									else
										M << "Your hands are full."
										usr << "Their hands are full."
										return
								else
									if (useResource(10, user))
										M.put_in_r_hand(new /obj/item/weapon/spacecash/c10(M))
										printmessage()
										activate()
										return 1
									return 0
								return 0
							if (2)
								if(!Adjacent(usr))
									usr << "You need to keep in reaching distance."
									M << "[usr.name] moved too far away."
									return
								if(M.r_hand != null)
									if(M.l_hand == null)
										if (useResource(10, user))
											M.put_in_l_hand(new /obj/item/weapon/reagent_containers/food/drinks/drinkingglass(M))
											printmessage()
											activate()
											return 1
										return 0

									else
										M << "Your hands are full."
										usr << "Their hands are full."
										return
								else
									if (useResource(10, user))
										M.put_in_r_hand(new /obj/item/weapon/reagent_containers/food/drinks/drinkingglass(M))
										printmessage()
										activate()
										return 1
									return 0
								return 0
							if (3)
								if(!Adjacent(usr))
									usr << "You need to keep in reaching distance."
									M << "[usr.name] moved too far away."
									return
								if(M.r_hand != null)
									if(M.l_hand == null)
										if (useResource(10, user))
											M.put_in_l_hand(new /obj/item/weapon/paper(M))
											printmessage()
											activate()
											return 1
										return 0

									else
										M << "Your hands are full."
										usr << "Their hands are full."
										return
								else
									if (useResource(10, user))
										M.put_in_r_hand(new /obj/item/weapon/paper(M))
										printmessage()
										activate()
										return 1
									return 0
								return 0
							if (4)
								if(!Adjacent(usr))
									usr << "You need to keep in reaching distance."
									M << "[usr.name] moved too far away."
									return
								if(M.r_hand != null)
									if(M.l_hand == null)
										if (useResource(10, user))
											M.put_in_l_hand(new /obj/item/weapon/pen(M))
											printmessage()
											activate()
											return 1
										return 0

									else
										M << "Your hands are full."
										usr << "Their hands are full."
										return
								else
									if (useResource(10, user))
										M.put_in_r_hand(new /obj/item/weapon/pen(M))
										printmessage()
										activate()
										return 1
									return 0
								return 0
							if (5)
								if(!Adjacent(usr))
									usr << "You need to keep in reaching distance."
									M << "[usr.name] moved too far away."
									return
								if(M.r_hand != null)
									if(M.l_hand == null)
										if (useResource(10, user))
											M.put_in_l_hand(new /obj/item/weapon/storage/pill_bottle/dice(M))
											printmessage()
											activate()
											return 1
										return 0

									else
										M << "Your hands are full."
										usr << "Their hands are full."
										return
								else
									if (useResource(10, user))
										M.put_in_r_hand(new /obj/item/weapon/storage/pill_bottle/dice(M))
										printmessage()
										activate()
										return 1
									return 0
								return 0
							if (6)
								if(!Adjacent(usr))
									usr << "You need to keep in reaching distance."
									M << "[usr.name] moved too far away."
									return
								if(M.r_hand != null)
									if(M.l_hand == null)
										if (useResource(10, user))
											M.put_in_l_hand(new /obj/item/clothing/mask/cigarette(M))
											printmessage()
											activate()
											return 1
										return 0

									else
										M << "Your hands are full."
										usr << "Their hands are full."
										return
								else
									if (useResource(10, user))
										M.put_in_r_hand(new /obj/item/clothing/mask/cigarette(M))
										printmessage()
										activate()
										return 1
									return 0
								return 0
							else
								user << "ERROR: RSF in MODE: [mode] attempted use by [user]. Send this text to an admin."
								return 0
						return

					if("No")
						M.visible_message("[usr.name] tried to print [setting] to [M.name] but [M.name] didn't want it.")
						return


			return

/obj/item/weapon/rsf/proc/useResource(var/amount, var/mob/user)
	if(stored_matter < amount)
		return 0
	stored_matter -= amount
	desc = "An RSF. It currently holds [stored_matter]/30 matter-units."
	return 1

/obj/item/weapon/rsf/proc/checkResource(var/amount, var/mob/user)
	return stored_matter >= amount

/obj/item/weapon/rsf/borg/useResource(var/amount, var/mob/user)
	if(!isrobot(user))
		return 0
	return user:cell:use(amount * 30)

/obj/item/weapon/rsf/borg/checkResource(var/amount, var/mob/user)
	if(!isrobot(user))
		return 0
	return user:cell:charge >= (amount * 30)

/obj/item/weapon/rsf/borg/New()
	..()
	desc = "A device used to rapidly deploy service items."