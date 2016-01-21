/* This is a mobile practice dummy for security and science to test weapons and hand to hand fighting on. It can be queried
* to report on how much damage it has taken since the last update. The dummy is a solid gel with holographic projections on the
* surface. IT can be destroyed, but requires basically a point-blank explosion to do so.
*
* If emagged, it will reflect attacks back at the attacker.
* It has an object-based verb for printing out recent wounds dealt to it
* It has an object-based verb for changing its appearance
*/

/obj/structure/holodummy
	name = "Combat Pratice Dummy"
	description = "A tough silicon-gel based dummy with a holographic projector in its core. Great for taking out agressions or testing weapons!"
	icon = 'icons/obj/testdummy.dmi'
	icon_state = "Test Dummy" //There are a group of overlays that will be applied. There are four brute damage overlays and four burn overlays. Overlays use the multiply function to avoid doing "damage" to areas that do not exist. we should be able to just use the overlays varaible and procs to adjust them. Maybe.
	density = 1
	anchored = 1
	var/emagged = 0
	var/list/recenthits = null
	var/list/possibleicons = {"Test Dummy", "Gel Target", "Tin Cans", "Xenomorph"}  //A list of possible icons goes here!
	
	
/* Verbs here*/
/obj/structure/holodummy/verb/changeicon()
//This verb changes the icon of the dummy. Doing this clears damage reports and physical damage overlays
	set name = "Change Icon"
	set category = "Object"
	set src in view(1)
	//Here we bring up a list of possible icons and have the user select one, which becomes the new icon state
	
	//Clear damage overlays and recent hit log
	overlays.Cut()
	recenthits = null


/obj/structure/holodummy/verb/printReport() 
//This verb prints the results of the recent hits list, then clears it. IT also clears damage overlays
	set name = "Damage report"
	set category = "Object"
	set src in view(1)
	var/dat = "Dummy Damage Report /n /n [hr]"
	if(recenthits)
		var/counter = recenthits.len
		for(counter)
			dat +=  recenthits[counter] + "/n"
			counter--
	else
		dat += "No damage detected"
	//Print dat to paper

/obj/structure/holodummy/verb/toggleAnchors() 
//This verb lets you anchor and unanchor the dummy. Moving the dummy clears recent hits and overlays.
	set name = "Toggle Anchors"
	set category = "Object"
	set src in view(1)
	
	if(anchored)
		//display to all nearby users that the anchors are removed
	else
		//display to all nearby users that the anchors are deployed
	
	anchored = !anchored

/* Damage procs here */
/obj/structure/holodummy/bullet_act(var/obj/item/projectile/Proj) //This covers lasers and projectiles

/obj/structure/holodummy/attackby(obj/item/I as obj, mob/user as mob) //This covers handheld weapons
	//We add a string to the report including the name of the object, force applied (1 Force = 2.5N, probably will end up with some pretty wild things...), and target zone.
	var/multiplier = 2.5
	if(I.sharp)
		multiplier = 1

	var/hitstring = I.name + " struck the " + user.zone_sel.selecting + " with a force of " + (I.force * multiplier) + " N."
	
	if(recenthits)
		recenthits += hitstring
	else
		recenthits = hitstring
/obj/structure/holodummy/attack_hand(mob/user as mob) //This covers hand to hand attacks. The AI shouldn't be able to interact with this.

/obj/structure/holodummy/attack_paw(mob/user as mob) //this covers hand to hand attacks.
	return src.attack_hand(user)

/obj/structure/holodummy/attack_alien(mob/user as mob) //Alien hits!

/obj/structure/holodummy/attack_animal(mob/user as mob) //Animal hits!

/obj/structure/holodummy/attack_slime(mob/user as mob) //Slime hits!

/obj/structure/holodummy/blob_act() //BLOBS CAN PLAY WITH TEST DUMMIES TOO

/obj/structure/holodummy/ex_act(severity)

/obj/structure/holodummy/meteorhit(var/obj/O as obj)
