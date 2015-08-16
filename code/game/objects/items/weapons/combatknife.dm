//Actual combat knives.-Kerbal22
/obj/item/weapon/combatknife/
	name = "Combat Knife"
	icon = 'icons/obj/kitchen.dmi'
	icon_state = "knife"
	desc = "Now THIS is a knife!"
	flags = FPRINT | TABLEPASS | CONDUCT
	sharp = 1
	edge = 1
	force = 10.0
	w_class = 2.0
	throwforce = 6.0
	throw_speed = 3
	throw_range = 6
	matter = list("metal" = 12000)
	origin_tech = "materials=1"
	attack_verb = list("slashed", "stabbed", "sliced", "torn", "ripped", "diced", "cut")

	suicide_act(mob/user)
		viewers(user) << pick("\red <b>[user] is slitting \his wrists with the [src.name]! It looks like \he's trying to commit suicide.</b>", \
							"\red <b>[user] is slitting \his throat with the [src.name]! It looks like \he's trying to commit suicide.</b>", \
							"\red <b>[user] is slitting \his stomach open with the [src.name]! It looks like \he's trying to commit seppuku.</b>")
		return (BRUTELOSS)