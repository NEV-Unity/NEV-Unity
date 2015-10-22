/obj/item/organ/translator
	name = "universal translator"
	icon_state = "brain-prosthetic"
	organ_tag = "translator"
	prosthetic_name = "universal translator"
	robotic = 2
	organ_type = /datum/organ/internal/translator

/datum/organ/internal/translator
	name = "universal translator"
	parent_organ = "head"
	removed_type = /obj/item/organ/translator

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
/obj/item/organ/eyes/night/removed(var/mob/living/carbon/human/target)
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
		src.see_in_dark = 8
		src.nutrition -= 100 //activating nv verb costs you 1/4 of your max nutrition as a downside.
		src.see_invisible = SEE_INVISIBLE_MINIMUM //If this doesn't work, we will need to add a flag and something in life/process in life.dm to make it work. Non-ideal, might need to normalize with regular NVG?
	else
		src.see_in_dark = 2
/mob/living/carbon/human/proc/has_translator() //Check if humans have a translator
	var/datum/organ/internal/ORGAN
	ORGAN = organs_by_name["translator"]
	if(!ORGAN || ORGAN.status == ORGAN_DESTROYED)
		return 0
	else
		return 1
