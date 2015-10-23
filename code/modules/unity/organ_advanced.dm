/obj/item/organ/medichine
	name = "medical nanite hive"
	icon_state = "implant_prosthetic"
	organ_tag = "medichine"
	prosthetic_name = "medical nanite hive"
	robotic = 2
	organ_type = /datum/organ/internal/medichine
	
/datum/organ/internal/medichine
	name = "medichine"
	parent_organ = "groin"
	removed_type = /obj/item/organ/medichine

/obj/item/organ/medichine/replaced(var/mob/living/carbon/human/target)
	//gives the paindamp verb
	target.verbs += /mob/living/carbon/human/proc/medichine
	..()
/obj/item/organ/paindamp/removed(var/mob/living/carbon/human/target)
	// removes the paindamp verb
	target.verbs -= /mob/living/carbon/human/proc/medichine
	..()

/mob/living/carbon/human/proc/medichine()
	set category = "Abilities"
	set name = "Activate Medical Nanites"
	set desc = "Releases medical nanites into your system"
	var/datum/organ/internal/ORGAN
	ORGAN = internal_organs_by_name["medichine"]
	if(!ORGAN || ORGAN.status == ORGAN_DESTROYED)
		src << "Your groin burns in agony as your medichines malfunction!"
		src.adjustBruteLoss(5)
		src.adjustFireLoss(5)
		src.adjustToxLoss(5)
		return 0
	else
		src << "Your body goes limp as your medichines begin to slowly stitch your body together"
		src.reagents.add_reagent("spaceacillin", 5) //infection control
		src.reagents.add_reagent("tricordrazine",1) //mild healing
		src.weaken(5) 
		src.druggy = max(src.druggy, 5) //activating the implant gives you the druggy overlay
		ORGAN.damage += 1

/obj/item/organ/paindamp
	name = "pain dampner"
	icon_state = "implant_prosthetic"
	organ_tag = "painblock"
	prosthetic_name = "pain dampner"
	robotic = 2
	organ_type = /datum/organ/internal/paindamp
	
/datum/organ/internal/paindamp
	name = "pain dampner"
	parent_organ = "groin"
	removed_type = /obj/item/organ/paindamp

/obj/item/organ/paindamp/replaced(var/mob/living/carbon/human/target)
	//gives the paindamp verb
	target.verbs += /mob/living/carbon/human/proc/paindamp
	..()
/obj/item/organ/paindamp/removed(var/mob/living/carbon/human/target)
	// removes the paindamp verb
	target.verbs -= /mob/living/carbon/human/proc/paindamp
	..()

/mob/living/carbon/human/proc/paindamp()
	set category = "Abilities"
	set name = "Activate Pain Dampner"
	set desc = "Releases painkillers into your system"
	src.reagents.add_reagent("paracetamol", 2) //lasts for 1 minute 20seconds.
	src.druggy = max(src.druggy, 2) //activating the implant gives you the druggy overlay

/obj/item/organ/binarychip
	name = "wireless binary chip"
	icon_state = "implant-prosthetic"
	organ_tag = "binary chip"
	prosthetic name = "wirelss biary chip"
	robotic = 2
	organ_type = /datum/organ/internal/binarychip

/datum/organ/internal/binarychip
	name = "wireless binary chip"
	parent_organ = "head"
	removed_type = /obj/item/organ/binarychip

/obj/item/organ/binarychip/replaced(var/mob/living/carbon/human/target)
	//gives you binary
	target.add_language("Robot Talk")
	..()
/obj/item/organ/binarychip/removed(var/mob/living/carbon/human/target)
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
