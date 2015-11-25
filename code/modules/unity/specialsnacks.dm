/obj/item/weapon/reagent_containers/food/snacks/npaste/feedstock
	name = "nanite feedstock"
	icon_state = "fishfingers"
	attack(mob/M as mob, mob/user as mob, def_zone)
		var/datum/organ/internal/medichine/ORGAN
		if(istype(M, /mob/living/carbon/human))
			var/mob/living/carbon/human/N = M
			ORGAN = N.internal_organs_by_name["medichine"]
			if(ORGAN)
				if(ORGAN.uses < 4)
					ORGAN.uses++
		..()
	attackby(var/obj/I as obj, var/mob/user as mob)
		return


/datum/recipe/feedstock
	items = list(
		/obj/item/weapon/reagent_containers/food/snacks/npaste,
		/obj/item/stack/nanopaste
	)
	result = /obj/item/weapon/reagent_containers/food/snacks/npaste/feedstock

/obj/item/weapon/reagent_containers/food/snacks/npaste
	name = "nutrient paste"
	icon_state = "npaste"

	New()
		..()
		desc = "Tastes not quite entirely unlike " + pick( "coffee", "jerky.", "pizza.", "strawberries.", "tea.", "bacon.")
		reagents.add_reagent("nutriment", 15)
		bitesize = 5


	attack(mob/M as mob, mob/user as mob, def_zone)
		M << "\red Your body shudders in disgust as you take a bite of [src]."
		..()

/obj/machinery/vending/ndispenser
	name = "Nutrient Paste Dispenser"
	desc = "Synthesizes nutrient paste from organic feedstocks. It consumes less ingredients and time than any other meal production method - but nobody likes eating nutrient paste."
	icon_state = "nutri"
	product_ads = "I haven't eaten in a while.;The hunger pangs are clawing my insides. I need food or I'll starve soon.;I just want something - anything - to eat. I can feel my body wasting away. It hurts... ;It's claustrophobic in here. I have nowhere to move. I feel like a rat in a tiny cage.;I've been cooped up inside for days. I need to get outside.;I've been trapped like a rat in here for so long. I desperately need to get outside or I'll go crazy!"
	products = list(/obj/item/weapon/reagent_containers/food/snacks/npaste = 30)
	idle_power_usage = 211 //refrigerator - believe it or not, this is actually the average power consumption of a refrigerated vending machine according to NRCan.

/obj/machinery/vending/ndispenser/attackby(obj/item/weapon/W as obj, mob/user as mob)
	if(istype(W, /obj/item/weapon/reagent_containers/food/snacks))
		playsound(src.loc, 'sound/machines/ping.ogg', 100, 1)
		user << "\blue The [src] pings as you feed material into its hopper."
		for(var/datum/data/vending_product/R in product_records)
			R.amount++
		del(W)
	..()
