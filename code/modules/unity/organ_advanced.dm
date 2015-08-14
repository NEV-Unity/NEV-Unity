/obj/item/organ/eyes/shielded
	name = "eyeballs"
	icon_state = "eyes"
	gender = PLURAL
	prosthetic_name = "shielded visual prosthesis"
	prosthetic_icon = "eyes-prosthetic"
	organ_tag = "eyes"
	organ_type = /datum/organ/internal/eyes/shielded
	robotic = 2

/datum/organ/internal/eyes/shielded
	name = "eyes"
	parent_organ = "head"
	removed_type = /obj/item/organ/eyes/shielded
	
/obj/item/organ/eyes/night
	name = "eyeballs"
	icon_state = "eyes"
	gender = PLURAL
	prosthetic_name = "infrared visual prosthesis"
	prosthetic_icon = "eyes-prosthetic"
	organ_tag = "eyes"
	organ_type = /datum/organ/internal/eyes/night
	robotic = 2

/datum/organ/internal/eyes/night
	name = "eyes"
	parent_organ = "head"
	removed_type = /obj/item/organ/eyes/night
	
/obj/item/organ/eyes/night/replaced(var/mob/living/carbon/human/target)
	// Give the user the  see_in_dark verb
	target.verbs += /mob/living/carbon/human/proc/toggle_nightvision_eyes
	..()
/objitem/organ/eyes/night/removed(var/mob/living/carbon/human/target)
	//Remove any active see_in_dark enhancements
	//Remove the toggle_nightvision() verb
	target.verbs -= /mob/living/carbon/human/proc/toggle_nightvision_eyes
	target.see_in_dark = 2
	..()
/mob/living/carbon/human/proc/toggle_nightvision_eyes()
	set category = "Abilities"
	set name = "Toggle Nightvision"
	set desc = "Toggle your nightvision."
	if(src.see_in_dark == 2)
		src.see_in_dark = 5
		src.nutrition -= 100 //activating nv verb costs you 1/4 of your max nutrition as a downside. 
	else
		src.see_in_dark = 2
