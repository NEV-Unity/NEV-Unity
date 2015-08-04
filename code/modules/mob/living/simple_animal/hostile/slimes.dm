//
// Abstract Class
//

/mob/living/simple_animal/hostile/ooze
	name = "Biodigestive Ooze"
	desc = "An exceptionally agressive algae. Beware of it's powerful acid!"
	icon_state = "carp"
	icon_living = "carp"
	icon_dead = "carp_dead"

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

/mob/living/simple_animal/hostile/slime/FindTarget()
	. = ..()
	if(.)
		emote("slorps at [.]!")

/mob/living/simple_animal/hostile/slime/AttackingTarget()
	..()
	if(isliving(target_mob))
		var/mob/living/L = target_mob
		if(L.reagents)
			L.reagents.add_reagent("sacid", (maxhealth/10))

/mob/living/simple_animal/hostile/slime/death()
	..()
  var/obj/effect/decal/cleanable/mucus/C = new(get_turf(src))
  C.name = "slime"
	C.desc = "Disgusting slime."
	if(maxhealth > 25)
  	visible_message("\red <b>[src]</b> splits into two!")
  	//spawn slime bits
  	var/mob/living/simple_animal/hostile/slime/A = new(get_turf(src))
  	var/mob/living/simple_animal/hostile/slime/B = new(get_turf(src))

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


