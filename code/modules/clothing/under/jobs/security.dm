/*
 * Contains:
 *		Security
 *		Marshal
 *		Commander
 */

/*
 * Security
 */
/obj/item/clothing/under/rank/warden
	desc = "It's made of a slightly sturdier material than standard jumpsuits, to allow for more robust protection. It has the word \"Chief Petty Officer\" written on the shoulders."
	name = "warden's jumpsuit"
	icon_state = "security"
	item_state = "b_suit"
	item_color = "secred"
	armor = list(melee = 10, bullet = 0, laser = 0,energy = 0, bomb = 0, bio = 0, rad = 0)
	flags = FPRINT | TABLEPASS
	siemens_coefficient = 0.9

/obj/item/clothing/under/rank/security
	name = "espatier's jumpsuit"
	desc = "It's made of a slightly sturdier material than standard jumpsuits, to allow for robust protection."
	icon_state = "security"
	item_state = "b_suit"
	item_color = "secred"
	armor = list(melee = 10, bullet = 0, laser = 0,energy = 0, bomb = 0, bio = 0, rad = 0)
	flags = FPRINT | TABLEPASS
	siemens_coefficient = 0.9

/obj/item/clothing/under/rank/dispatch
	name = "dispatcher's uniform"
	desc = "A dress shirt and khakis with a security patch sewn on."
	icon_state = "dispatch"
	item_state = "dispatch"
	item_color = "dispatch"
	armor = list(melee = 10, bullet = 0, laser = 0,energy = 0, bomb = 0, bio = 0, rad = 0)
	flags = FPRINT | TABLEPASS
	siemens_coefficient = 0.9

/obj/item/clothing/under/rank/security2
	name = "espatier's uniform"
	desc = "It's made of a slightly sturdier material, to allow for robust protection."
	icon_state = "redshirt2"
	item_state = "b_suit"
	item_color = "redshirt2"
	armor = list(melee = 10, bullet = 0, laser = 0,energy = 0, bomb = 0, bio = 0, rad = 0)
	flags = FPRINT | TABLEPASS
	siemens_coefficient = 0.9

/obj/item/clothing/under/rank/security/corp
	icon_state = "sec_corporate"
	item_state = "sec_corporate"
	item_color = "sec_corporate"

/obj/item/clothing/under/rank/warden/corp
	icon_state = "warden_corporate"
	item_state = "warden_corporate"
	item_color = "warden_corporate"

/obj/item/clothing/under/rank/security/formal
	icon_state = "sec_f"
	item_state = "sec_f"
	item_color = "sec_f"

/obj/item/clothing/under/rank/warden/formal
	icon_state = "warden_f"
	item_state = "warden_f"
	item_color = "warden_f"

/obj/item/clothing/under/tactical
	name = "tactical jumpsuit"
	desc = "It's made of a slightly sturdier material than standard jumpsuits, to allow for robust protection."
	icon_state = "swatunder"
	item_state = "swatunder"
	item_color = "swatunder"
	armor = list(melee = 10, bullet = 5, laser = 5,energy = 0, bomb = 0, bio = 0, rad = 0)
	flags = FPRINT | TABLEPASS
	siemens_coefficient = 0.9

/*
 * Marshal
 */
/obj/item/clothing/under/det
	name = "Marshal/'s uniform"
	desc = "Someone who wears this means business."
	icon_state = "security"
	item_state = "b_suit"
	item_color = "secred"
	armor = list(melee = 10, bullet = 0, laser = 0,energy = 0, bomb = 0, bio = 0, rad = 0)
	flags = FPRINT | TABLEPASS
	siemens_coefficient = 0.9

/obj/item/clothing/under/det/black
	icon_state = "detective2"
	item_color = "detective2"

/obj/item/clothing/under/det/slob
	icon_state = "polsuit"
	item_color = "polsuit"

/obj/item/clothing/under/det/slob/verb/rollup()
	set name = "Roll suit sleeves"
	set category = "Object"
	set src in usr
	item_color = item_color == "polsuit" ? "polsuit_rolled" : "polsuit"
	if (ishuman(loc))
		var/mob/living/carbon/human/H = loc
		H.update_inv_w_uniform(1)

/obj/item/clothing/head/det_hat
	name = "hat"
	desc = "Someone who wears this will look very smart."
	icon_state = "detective"
	allowed = list(/obj/item/weapon/reagent_containers/food/snacks/candy_corn, /obj/item/weapon/pen)
	armor = list(melee = 50, bullet = 5, laser = 25,energy = 10, bomb = 0, bio = 0, rad = 0)
	siemens_coefficient = 0.9

/obj/item/clothing/head/det_hat/black
	icon_state = "detective2"


/*
 * Commander
 */
/obj/item/clothing/under/rank/head_of_security
	desc = "It's a jumpsuit worn by those few with the dedication to achieve the position of \"Commander\". It has additional armor to protect the wearer."
	name = "commander's jumpsuit"
	icon_state = "hos"
	item_state = "b_suit"
	item_color = "hosred"
	armor = list(melee = 10, bullet = 0, laser = 0,energy = 0, bomb = 0, bio = 0, rad = 0)
	flags = FPRINT | TABLEPASS
	siemens_coefficient = 0.8

/obj/item/clothing/under/rank/head_of_security/corp
	icon_state = "hos_corporate"
	item_state = "hos_corporate"
	item_color = "hos_corporate"

/obj/item/clothing/under/rank/head_of_security/formal
	icon_state = "hos_f"
	item_state = "hos_f"
	item_color = "hos_f"

/obj/item/clothing/head/helmet/HoS
	name = "Commander's Hat"
	desc = "The hat of the Commander. For showing the officers who's in charge."
	icon_state = "hoscap"
	flags = FPRINT | TABLEPASS | HEADCOVERSEYES
	armor = list(melee = 80, bullet = 60, laser = 50,energy = 10, bomb = 25, bio = 10, rad = 0)
	flags_inv = 0
	flags_inv = HIDEEARS
	siemens_coefficient = 0.8

/obj/item/clothing/suit/armor/hos
	name = "Commander's jacket"
	desc = "An armoured jacket with golden rank pips and livery."
	icon_state = "hos"
	item_state = "hos"
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|ARMS|LEGS
	armor = list(melee = 65, bullet = 30, laser = 50, energy = 10, bomb = 25, bio = 0, rad = 0)
	flags_inv = HIDEJUMPSUIT
	siemens_coefficient = 0.6

/obj/item/clothing/suit/armor/hos/vest
	name = "armored vest"
	desc = "A platecarrier worns by the commander."
	icon_state = "hos-armor"
	item_state = "armor"
	flags_inv = 0
	siemens_coefficient = 0.6

/obj/item/clothing/suit/armor/hos/formal
	name = "Commander's jacket"
	desc = "An armoured jacket with golden rank pips and livery."
	icon_state = "formal_hos"
	item_state = "formal_hos"

/obj/item/clothing/head/helmet/HoS/dermal
	name = "Dermal Armour Patch"
	desc = "You're not quite sure how you manage to take it on and off, but it implants nicely in your head."
	icon_state = "dermal"
	item_state = "dermal"
	siemens_coefficient = 0.6

//Jensen cosplay gear
/obj/item/clothing/under/rank/head_of_security/jensen
	desc = "You never asked for anything that stylish."
	name = "commander's jumpsuit"
	icon_state = "jensen"
	item_state = "jensen"
	item_color = "jensen"
	siemens_coefficient = 0.6

/obj/item/clothing/suit/armor/hos/jensen
	name = "armored trenchcoat"
	desc = "A trenchcoat with armour concealed underneath."
	icon_state = "jensencoat"
	item_state = "jensencoat"
	flags_inv = 0
	siemens_coefficient = 0.6

/*
 * Naval Uniforms
 */

/obj/item/clothing/under/rank/navy/hos
	name = "Naval Commander Uniform"
	desc = "A service uniform worn by a Commander of the NanoTrasen Naval branch."
	icon_state = "hosdnavyclothes"
	item_state = "hosdnavyclothes"
	item_color = "hosdnavyclothes"
	armor = list(melee = 10, bullet = 0, laser = 0,energy = 0, bomb = 0, bio = 0, rad = 0)
	flags = FPRINT | TABLEPASS
	siemens_coefficient = 0.8

/obj/item/clothing/under/rank/navy/hos/blue
	name = "Blue Commander Uniform"
	desc = "A blue service uniform worn by the Commander."
	icon_state = "hosblueclothes"
	item_state = "hosblueclothes"
	item_color = "hosblueclothes"

/obj/item/clothing/under/rank/navy/hos/tan
	name = "Tan Commander Uniform"
	desc = "A tan service uniform worn by the Commander."
	icon_state = "hostanclothes"
	item_state = "hostanclothes"
	item_color = "hostanclothes"

/obj/item/clothing/under/rank/navy/warden
	name = "Naval Chief Petty Officer Uniform"
	desc = "A service uniform worn by a Chief Petty Officer of the NanoTrasen Naval branch."
	icon_state = "wardendnavyclothes"
	item_state = "wardendnavyclothes"
	item_color = "wardendnavyclothes"
	armor = list(melee = 10, bullet = 0, laser = 0,energy = 0, bomb = 0, bio = 0, rad = 0)
	flags = FPRINT | TABLEPASS
	siemens_coefficient = 0.9

/obj/item/clothing/under/rank/navy/warden/blue
	name = "Blue Chief Petty Officer Uniform"
	desc = "A blue service uniform worn by the Chief Petty Officer."
	icon_state = "wardenblueclothes"
	item_state = "wardenblueclothes"
	item_color = "wardenblueclothes"

/obj/item/clothing/under/rank/navy/warden/tan
	name = "Tan Chief Petty Officer Uniform"
	desc = "A tan service uniform worn by the Chief Petty Officer."
	icon_state = "wardentanclothes"
	item_state = "wardentanclothes"
	item_color = "wardentanclothes"

/obj/item/clothing/under/rank/navy/det
	name = "Investigator's uniform"
	desc = "A smart pair of khakis and a dress shirt."
	icon_state = "wardentanclothes"
	item_state = "wardentanclothes"
	item_color = "wardentanclothes"

/obj/item/clothing/under/rank/navy/officer
	name = "Naval Officer Uniform"
	desc = "A service unfirom worn by an officer of the NanoTrasen Naval branch."
	icon_state = "officerdnavyclothes"
	item_state = "officerdnavyclothes"
	item_color = "officerdnavyclothes"
	armor = list(melee = 10, bullet = 0, laser = 0,energy = 0, bomb = 0, bio = 0, rad = 0)
	flags = FPRINT | TABLEPASS
	siemens_coefficient = 0.9

/obj/item/clothing/under/rank/navy/officer/blue
	name = "Blue Officer Uniform"
	desc = "A blue service uniform worn by a espatier."
	icon_state = "officerblueclothes"
	item_state = "officerblueclothes"
	item_color = "officerblueclothes"

/obj/item/clothing/under/rank/navy/officer/tan
	name = "Tan Officer Uniform"
	desc = "A tan service uniform worn by a espatier."
	icon_state = "officertanclothes"
	item_state = "officertanclothes"
	item_color = "officertanclothes"

/obj/item/clothing/under/rank/navy/det/forensics
	name = "Technician's uniform"
	desc = "A tan service uniform worn by a forensics officer."
	icon_state = "officertanclothes"
	item_state = "officertanclothes"
	item_color = "officertanclothes"