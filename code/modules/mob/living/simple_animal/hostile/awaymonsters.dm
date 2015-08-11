//Giant Wasps

/mob/living/simple_animal/hostile/giantwasp
	name = "giant wasp"
	desc = "A giant wasp native to many habitable planets. Beware of its deadly stinger!"
	icon_state = "critter"
	icon_living = "critter"
	icon_dead = "critter_dead"
	speak_chance = 0
	turns_per_move = 3
	meat_type = /obj/item/weapon/reagent_containers/food/snacks/meat
	response_help = "pets the"
	response_disarm = "gently pushes aside the"
	response_harm = "hits the"
	speed = 4
	maxHealth = 15
	health = 15

	harm_intent_damage = 8
	melee_damage_lower = 10
	melee_damage_upper = 15
	attacktext = "stings"
	attack_sound = 'sound/weapons/bite.ogg'

	min_oxy = 5
	max_oxy = 0
	min_tox = 0
	max_tox = 1
	min_co2 = 0
	max_co2 = 1
	min_n2 = 0
	max_n2 = 0
	minbodytemp = 0
	unsuitable_atoms_damage = 15

	faction = "carp"
	var/poison_per_bite = 5
	var/poison_type = "potassium_chlorophoride"

/mob/living/simple_animal/hostile/giantwasp/FindTarget()
	. = ..()
	if(.)
		emote("buzzes towards [.]")

/mob/living/simple_animal/hostile/giantwasp/AttackingTarget()
	..()
	if(isliving(target_mob))
		var/mob/living/L = target_mob
		if(L.reagents)
			L.reagents.add_reagent("toxin", poison_per_bite)
			if(prob(poison_per_bite))
				L << "\red You feel a stabbing pain in your chest!"
				L.visible_message("<span class='danger'>\the [src] plunges its stinger into \the [L]!</span>")
				L.reagents.add_reagent(poison_type, 2)
// Agressive Algae/Biodigestive Ooze

/mob/living/simple_animal/hostile/ooze
	name = "Biodigestive Ooze"
	desc = "An exceptionally agressive algae. Beware of it's powerful acid!"
	icon_state = "Goldgrub"
	icon_living = "Goldgrub"
	icon_dead = "Goldgrub_dead"

	response_help = "recoils from the"
	response_disarm = "struggles helplessly against the"
	response_harm = "beats pointlessly at the"
	speed = 8 // Higher is slower if I recall? These should be slow, but deadly
	maxHealth = 200
	health = 200

	harm_intent_damage = 5
	melee_damage_lower = 20
	melee_damage_upper = 20
	attacktext = "glomps"
	attack_sound = 'sound/weapons/bite.ogg' //REPLACE

	min_oxy = 0
	max_oxy = 0
	min_tox = 0
	max_tox = 0
	min_co2 = 0
	max_co2 = 0
	min_n2 = 0
	max_n2 = 0
	minbodytemp = 0

	faction = "mimic"
	move_to_delay = 8

/mob/living/simple_animal/hostile/ooze/FindTarget()
	. = ..()
	if(.)
		emote("slorps at [.]!")

/mob/living/simple_animal/hostile/ooze/AttackingTarget()
	..()
	if(isliving(target_mob))
		var/mob/living/L = target_mob
		if(L.reagents)
			L.reagents.add_reagent("sacid", (maxHealth/10))

/mob/living/simple_animal/hostile/ooze/death()
	var/obj/effect/decal/cleanable/mucus/C = new(get_turf(src))
	C.name = "slime"
	C.desc = "Disgusting slime."
	if(maxHealth > 25)
		visible_message("\red <b>[src]</b> splits into two!")
		//spawn slime bits
		var/mob/living/simple_animal/hostile/ooze/A = new(get_turf(src))
		var/mob/living/simple_animal/hostile/ooze/B = new(get_turf(src))
		A.maxHealth = (src.maxHealth / 4)
		B.maxHealth = (src.maxHealth / 4)
		A.speed = 4
		B.speed = 4
		A.melee_damage_lower = (A.maxHealth/10)
		A.melee_damage_upper = (A.maxHealth/10)
		B.melee_damage_lower = (A.maxHealth/10)
		B.melee_damage_upper = (A.maxHealth/10)
	else
		visible_message("\red <b>[src]</b> quivers and melts into a puddle")
	del(src)

//Cookie Monster (You monster)

/obj/item/weapon/reagent_containers/food/snacks/cookie/monstrous

	New()
		..()
		reagents.add_reagent(pick("plasticide","mutationtoxin", "amutationtoxin","stoxin2","space_drugs","serotrotium","mercury","tramadol","cryptobiolin","adminordrazine","nanites","xenomicrobes","mutagen"), 5)

/mob/living/simple_animal/hostile/cmonster
	name = "Cookie Monster"
	desc = "An animatronic monster with a love of cookies. Beware of it's delicious confections!"
	icon_state = "drone0"
	icon_living = "drone0"
	icon_dead = "drone_dead"
	meat_type = /obj/item/weapon/reagent_containers/food/snacks/cookie/monstrous

	response_help = "strokes the"
	response_disarm = "pushes the"
	response_harm = "kicks the"
	speed = 3
	maxHealth = 80 //Not super durable. The real danger is eating the drops.
	health = 80

	harm_intent_damage = 5
	melee_damage_lower = 8
	melee_damage_upper = 10
	attacktext = "claws"
	attack_sound = 'sound/weapons/bite.ogg' //REPLACE

	min_oxy = 5
	max_oxy = 0
	min_tox = 0
	max_tox = 10
	min_co2 = 0
	max_co2 = 10
	min_n2 = 0
	max_n2 = 0
	minbodytemp = 0
	unsuitable_atoms_damage = 15

	faction = "mimic"
	move_to_delay = 8

/mob/living/simple_animal/hostile/cmonster/FindTarget()
	. = ..()
	if(.)
		emote("shouts \"Cookie!\" at [.]")

/mob/living/simple_animal/hostile/cmonster/death()
	..()
	new /obj/item/weapon/reagent_containers/food/snacks/cookie/monstrous/(loc)
	new /obj/item/weapon/reagent_containers/food/snacks/cookie/monstrous/(loc)
	new /obj/item/weapon/reagent_containers/food/snacks/cookie/monstrous/(loc)
	new /obj/item/weapon/reagent_containers/food/snacks/cookie/monstrous/(loc)
	new /obj/item/weapon/reagent_containers/food/snacks/cookie/monstrous/(loc)
	new /obj/item/weapon/reagent_containers/food/snacks/cookie/monstrous/(loc)
	visible_message("\red <b>[src]</b> breaks apart, scattering cookies everywhere!")
	del(src)
