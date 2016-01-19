//This file will be for thruster code. Which ties in to astronav.
/obj/structure/thruster //Parent object for thruster components

	var/fried = 0 //This flag is used if a component is fried. If it is, then the component fails on activateThruster() and checkReady()
	var/welded = 1 //is this object welded down? Components tend to fail if they are not welded properly.
	var/covered = 1 //this is 1 if the object's cover is closed
	icon = 'icons/obj/thrustericon.dmi' //put an icon file here
	icon_state = null //put an icon name here. This will be changed to icon_state + "_fried" whenever a component is fried
	var/obj/structure/thruster/core = null//This object represents the parent core object. Not used/null for the core object itself.


	anchored = 1 //Can we move it? Unanchored objects can't link and don't work if they (somehow) link
	density = 1 //Can't walk through them


	proc/linkup(var/obj/structure/core, thrusterCore) //default proc to link non-core objects. Overwritten by the core.
		core = thrusterCore
	proc/unlink() //default proc to backlink non-core objects. Overwritten by the core itself.
		core = null
	proc/componentfail() //this proc is called if a component fails during activation
		return
	proc/checkReady() //some default checks, most of these should not ever be called, but are here for sanity-checking/debugging
		if(!anchored)
			world.log << "\red ERROR! UNANCHORED [src] was successfully checked something. This should not be happening!"
			core.unlink()
			return 0
		if(!welded)
			world.log << "\red ERROR! UNWELDED [src] was successfully checked by [usr]. This should not be happening!"
			core.unlink()
			return 0
		if(fried)//if a component is fried, it isn't ready.
			return 0
		if(!covered)//if the cover is open
			return 0
		return 1 //IF everything works, return 1

	/obj/structure/thruster/proc/activateThruster() //This activates the component. It returns 1 if the component successfully activated.
		if(!anchored) //check anchored. If fails, then immediately return 0 and throw an error because someone is breaking my code
			world.log << "\red ERROR! UNANCHORED [src] was activated! This should not happen!"
			return 0
		if(!welded) //check welded. If fails, then immediately return 0 and throw and error because someone is breaking my code.
			world.log <<"\red ERROR! Unwelded [src] was somehow activated. This should not happen!"
			return 0
		if(fried) //check if it's fried, if it is, run the fail proc
			src.componentfail()
		if(!covered) //if the cover is open, fry the component and continue
			fried = 1
			icon_state = icon_state + "_fried"
	attackby(obj/item/weapon/W as obj, mob/user as mob) //This is called after sub-object manipulation. Part manipulation checkes if cover is open first.
		if(istype(W, /obj/item/weapon/crowbar))
			covered = !covered
			return
		if(istype(W, /obj/item/weapon/wrench))
			if(welded)
				usr << "\red [src] is welded to the floor!"
			else
				if(anchored)
					usr << "\blue You loosen the bolts on [src]"
				else
					usr << "\blue You tighten down the bolts on [src]"
				//playsound rachet.ogg here
				anchored = !anchored
				core.unlink()


/obj/structure/thruster/core //The core object for thrusters
	var/list/containment = null //This object is the linked containment fields. 6 of these babies are required in specific places to function.
	var/obj/structure/thruster/inject/fuelInjector = null//Injector - This object is the linked fuel injector
	var/obj/structure/thruster/emgrid/gridArray = null//Gridarray - This object is the linked emgrid object
	var/obj/item/weapon/stock_parts/matter_bin/corebin
	var/obj/item/weapon/stock_parts/capacitor/corecap
	icon_state = "core"

	checkReady() //inherited from parent object. This calls checkReady() on all sub-components. If they pass, it checks the following in itself:
		if(containment.len == 6) //If we don't have six containment generators, we aren't ready.
			return 0
		for(var/obj/structure/thruster/fieldgen/G in containment) //For each containment generator.
			G.checkReady() //Check if it's ready
		if(fuelInjector) //If we have a fuel injector
			if(fuelInjector.checkReady())//Check if it's ready
			else //otherwise, we aren't ready
				return 0
		else //if we have no injector, we aren't ready.
			return 0
		if(gridArray)//If we have an EMGrid
			if(gridArray.checkReady())//Check if it's ready
			else
				return 0 //if no, we aren't ready.
		else
			return 0 //IF no emGrid, we aren't ready.
		if(!corebin) //do we lack a mater bin?
			return 0
		if(!corecap) //do we lack a core capacitor?
			return 0
	..()//Check parent conditions (anchored, welded, fried)

/obj/structure/thruster/core/activateThruster() //inherited from parent object. This runs the thruster, causing issues if components do not work properly.
	var/canLaunch = 1
	..()//Check if we are anchored, welded, fried, or covered. We can jump with a fried core, but it's pretty disasterous anyway.
	if(containment.len == 0)//IF we have no containment at all, things fail badly.
		//Release a ship-wide EMP
		canLaunch = 0
	else
		var/workingThrusters = 0
		var/obj/structure/thruster/fieldgen/G
		for(G in containment)
			if(G.activateThruster())//This will activate each containment field. If they fail, they release a miniEMP
				workingThrusters++
		if(workingThrusters == 0)
			//Release a ship-wide EMP
			canLaunch = 0 //The ship will fail to jump
		if(workingThrusters == 1 || workingThrusters == 2)//1-2 containment
			//Release a Medium-sized EMP from the core
			canLaunch = 0//The ship will fail to jump
		if(workingThrusters == 3)//3 containment
			//Release a small EMP from the core
		if(fuelInjector)//If we have an injector
			if(!fuelInjector.activateThruster()) //try and activate it
				canLaunch = 0 //Can't launch (the component should fail itself)
		else//no injector?
			canLaunch = 0//Bwahahaha. No, you can't launch without fuel.
		if(gridArray)//If we have an emitter array
			if(!gridArray.activateThruster())//try to activate it
				canLaunch = 0//CAn't launch (the component should fail itself)
		else//no emitter array?
			canLaunch = 0//How will you launch without the part that gives you thrust?
		if(!corebin)
			fried = 1//No bin for the core? Fry the core but fly
			icon_state = icon_state + "_fried"
		if(!corecap)
			fried = 1//No capacitor for the core? Fry the core, but fly.
			icon_state = icon_state + "_fried"
	return canLaunch //If we can launch we return a 1

/obj/structure/thruster/core/componentfail()//If a fried core is forced to run, it detonates
	src.unlink()
		//Drop an explosion here. Do not delete the thruster core. It may break things

/obj/structure/thruster/core/linkup()
		/*    -Looks for nearby sub-components and links them. Steps
        -Check for fuel injector on "top" of core. If there, link it to core.
        -Check for grid array "below" of core. If there, link to core.
        -Check for containment arrays in specified locations from base square.
            1. +0X -2Y
            2. +0X +2Y
            3. +2X -2Y
            4. +2X +2Y
            5. +4X -2Y
            6. +4X +2Y
            Create flyover effect
            Link them to core
        -Calls linkup() on all sub-components.*/
/obj/structure/thruster/core/unlink()//   -performs the same steps as linkup(), but runs unlink() on the objects and then removes the references from the core object.
/obj/structure/thruster/core/ex_act()//Thruser cores cannot be destroyed in explosions.
/obj/structure/thruster/core/verb/debuglinkUp()
/obj/structure/thruster/core/verb/debugCheck()
/obj/structure/thruster/core/verb/debugActivate()
/obj/structure/thruster/core/verb/debugUnlink()

/obj/structure/thruster/core/New()
	corebin = new /obj/item/weapon/stock_parts/matter_bin(src)//defines a default matter bin
	corecap = new /obj/item/weapon/stock_parts/capacitor(src) //defines a default capacitor

/obj/structure/thruster/inject //The fuel injector for thrusters
	icon_state = "inject"
/obj/structure/thruster/fieldgen //the field generators for thrusters
	icon_state = "fieldgen0"
/obj/structure/thruster/emgrid //The output object for thrusters (WARNING, RADIATION)
	icon_state = "grid"
/obj/effect/fieldflyover //An effect that places objects in the fly/layer
	icon_state = "bracefly"
/obj/effect/thrusteremfield //An EM field for the generator
	icon_state = "field"
/obj/structure/thruster/bracen //The fuel injector for thrusters
	icon_state = "bracen"
/obj/structure/thruster/braces
	icon_state = "braces"

/obj/machinery/computer/thruster //the control computer for thrusters
