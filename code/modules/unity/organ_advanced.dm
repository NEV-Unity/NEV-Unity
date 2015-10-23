/obj/item/organ/binarychip
	name = "wireless binary chip"
	icon_state = "implant-prosthetic"
	organ_tag = "binary chip"
	prosthetic name = "wirelss biary chip"
	robotic = 2
	organ_type = /datum/organinternal/binarychip

/datum/organ/internal/binarychip
	name = "wireless binary chip"
	parent_organ = "head"
	removed_type = /obj/item/organ/binarychip

/obj/item/organ/binarychip/replaced(var/mob/living/carbon/human/target)
	//gives you binary
	target.add_language("Robot Talk")
	..()
/obj/item/organ/ebinarychip/removed(var/mob/living/carbon/human/target)
	// removes binary
	target.remove_language("Robot Talk")
	..()

/obj/item/organ/translator
	name = "universal translator"
	icon_state = "implant-prosthetic"
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
	prosthetic_name = "infrared retinal overlay"
	prosthetic_icon = "eyes-prosthetic"
	organ_tag = "nightvision"
	organ_type = /datum/organ/internal/eyes/night
	robotic = 2
	var/activated = 0

/datum/organ/internal/eyes/night
	name = "infrared retinal overlay"
	parent_organ = "head"
	removed_type = /obj/item/organ/eyes/night


/mob/living/carbon/human/proc/has_translator() //Check if humans have a translator. Should eventually generalize this.
	var/datum/organ/internal/ORGAN
	ORGAN = internal_organs_by_name["translator"]
	if(!ORGAN || ORGAN.status == ORGAN_DESTROYED)
		return 0
	else
		return 1
/mob/living/carbon/human/proc/has_night_vision()
	var/datum/organ/internal/ORGAN
	ORGAN = internal_organs_by_name["nightvision"]
	if(!ORGAN || ORGAN.status == ORGAN_DESTROYED)
		return 0
	else
		return 1
