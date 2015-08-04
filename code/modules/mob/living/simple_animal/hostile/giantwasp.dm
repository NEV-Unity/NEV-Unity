/mob/living/simple_animal/hostile/giantwasp
	name = "giant wasp"
	desc = "A giant wasp native to many habitable planes. Beware of its deadly stinger!"
	icon = 'icons/mob/bats.dmi'
	icon_state = "bat"
	icon_living = "bat"
	icon_dead = "bat_dead"
	icon_gib = "bat_dead"
	speak_chance = 0
	turns_per_move = 3
	meat_type = /obj/item/weapon/reagent_containers/food/snacks/meat
	response_help = "pets the"
	response_disarm = "gently pushes aside the"
	response_harm = "hits the"
	speed = 4
	maxHealth = 45
	health = 45

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

//	break_stuff_probability = 2

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
			

/mob/living/simple_animal/hostile/giantwasp/death()
	..()
	visible_message("\red <b>[src]</b> breaks apart!")
