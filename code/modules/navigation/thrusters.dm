//This file will be for thruster code. Which ties in to astronav.
/obj/structure/thruster //Parent object for thruster components

	var/fried = 0 //This flag is used if a component is fried. If it is, then the component fails on activateThruster() and checkReady()
	var/welded = 1 //is this object welded down? Components tend to fail if they are not welded properly.
	var/covered = 1 //this is 1 if the object's cover is closed

	var/obj/structure/thruster/core = null//This object represents the parent core object. Not used/null for the core object itself.


	anchored = 1 //Can we move it? Unanchored objects can't link and don't work if they (somehow) link
	density = 1 //Can't walk through them
	

	linkup(var/obj/structure/core thrusterCore) //default proc to link non-core objects. Overwritten by the core.
		core = thrusterCore	
	unlink() //default proc to backlink non-core objects. Overwritten by the core itself.
		core = null
	checkReady() //some default checks, most of these should not ever be called, but are here for sanity-checking/debugging
		if(!anchored)
			world.log << "\red ERROR! UNANCHORED [src] was successfully checked something. This should not be happening!"
			core.unlink()
			return 0
		if(!welded)
			world.log << "\red ERROR! UNWELDED [src] was successfully checked by [usr]. This should not be happening!"
			core.unlink()
			return 0
		return 1 //IF everything works, return 1
			
	activateThruster() //This activates the component. It returns 1 if the component successfully activated.
		return 1 //If everything works, return 1
	attackby(obj/item/weapon/W as obj, mob/user as mob) //This is called after sub-object manipulation. Part manipulation checkes if cover is open first.
		if(istype(W, /obj/item/weapon/crowbar))
			cover = !cover
			return
		if(istype(W, /obj/item/weapon/wrench))
			if(welded)
			else
				anchored = !anchored
				core.unlink()


/obj/structure/thruster/core //The core object for thrusters
/obj/structure/thruster/inject //The fuel injector for thrusters
/obj/structure/thruster/fieldgen //the field generators for thrusters
/obj/structure/thruster/emgrid //The output object for thrusters (WARNING, RADIATION)
/obj/effect/fieldflyover //An effect that places objects in the fly/layer
/obj/effect/thrusteremfield //An EM field for the generator

/obj/machinery/computer/thruster //the control computer for thrusters
