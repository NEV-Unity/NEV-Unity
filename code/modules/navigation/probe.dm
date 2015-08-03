#define PROBE_AWAYZ 2          //Z-level of the Dock.
#define PROBE_SHIPZ 1       //Z-level of the Station.
#define PROBE_AWAY_AREA "/area/probe/away" //Type of the supply shuttle area for sending away
#define PROBE_HOME_AREA "/area/probe/station"	//Type of the supply shuttle area for dock

/obj/structure/shuttlecorner
	name = "shuttle"
	icon = 'icons/turf/shuttle.dmi'
	icon_state = "diagonalWall"
	anchored = 1
	density = 1
	opacity = 1

/obj/machinery/computer/probe
	icon = 'icons/obj/computer.dmi'
	icon_state = "comm_monitor"
	name = "Probe Operation Console"
	desc = "This console controls the Unity's long-distance probes!"
	var/datum/system/cursystem
	var/datum/planet/curplanet
	var/away = 0
	var/scandelay = 2000 //How long each scan tick takes. 2000 is the default
	var/traveldelay = 600 //How long it takes to travel to/from the site. 600 is the default
	var/obj/structure/reagent_dispensers/probe/collector
	var/operating = 0

/obj/machinery/computer/probe/ui_interact(mob/user, ui_key = "main", var/datum/nanoui/ui = null)
	if(stat & (BROKEN|NOPOWER)) return
	if(user.stat || user.restrained()) return

	// this is the data which will be sent to the ui
	var/data[0]
	data["oplanet"] = ship.curplanet
	data["away"] = away

	// update the ui if it exists, returns null if no ui is passed/found
	ui = nanomanager.try_update_ui(user, src, ui_key, ui, data)
	if (!ui)
		// the ui does not exist, so we'll create a new() one
        // for a list of parameters and their descriptions see the code docs in \code\modules\nano\nanoui.dm
		ui = new(user, src, ui_key, "probe.tmpl", name, 380, 380)
		// when the ui is first opened this is the data it will use
		ui.set_initial_data(data)
		// open the new ui window
		ui.open()
		// auto update every Master Controller tick
		ui.set_auto_update(1)
/obj/machinery/computer/probe/attack_paw(mob/user)
	user << "You are too primitive to use this computer."
	return

/obj/machinery/computer/probe/attack_ai(mob/user)
	return src.attack_hand(user)

/obj/machinery/computer/probe/attack_hand(mob/user as mob)
	if(stat & BROKEN)
		return
	ui_interact(user)

/obj/machinery/computer/probe/Topic(href, href_list)
	var/area/home = locate(PROBE_HOME_AREA)
	var/area/site = locate(PROBE_AWAY_AREA)
	if(stat & (NOPOWER|BROKEN))
		return 0
	if(href_list["return"])
		if(!away)
			src.visible_message("The Terminal States: Shuttle already returned. Unable to recall.Please launch probe.")
			src.visible_message("\blue \icon[src] buzzes irritably!", 7)
			playsound(src.loc, 'sound/machines/buzz-sigh.ogg', 50, 1)
			return 0
		if(operating)
			src.visible_message("The Terminal States: Shuttle already recalled. Please wait")
			src.visible_message("\blue \icon[src] buzzes irritably!", 7)
			playsound(src.loc, 'sound/machines/buzz-sigh.ogg', 50,1)
			return 0
		operating = 1
		src.visible_message("The Terminal States: Return Procedure Initiated. ETA: 1 Minute")
		sleep(traveldelay)
		src.visible_message("The Terminal States: Probe Retrived")
		//Return the probe home. This takes a minute
		site.move_contents_to(home)
		ship.cantmove = 0
		away = 0
		operating = 0
		return 1
	if(href_list["launch"])
		if(away)
			src.visible_message("The Terminal States: Shuttle already away. Unable to launch.Please recall probe.")
			src.visible_message("\blue \icon[src] buzzes irritably!", 7)
			playsound(src.loc, 'sound/machines/buzz-sigh.ogg', 50, 1)
			return 0
		var/mob/x
		for(x in locate(PROBE_HOME_AREA))
			if(x)
				src.visible_message("The Terminal States: Organic Matter in probe. Unable to launch.")
				src.visible_message("\blue \icon[src] buzzes irritably!", 7)
				playsound(src.loc, 'sound/machines/buzz-sigh.ogg', 50, 1)
				return 0
		src.visible_message("The Terminal States: Launching Probe. ETA to target site: 1 Minute")
		playsound(src.loc, 'sound/effects/extinguish.ogg', 50, 1)
		away = 1
		//Send away the probe
		home.move_contents_to(site)
		ship.cantmove = 1
		sleep(traveldelay)
		src.visible_message("The Terminal States: Probe at target site. Scanning. ETA: 10 Minutes")
		//wait 10 minutes
		sleep(scandelay)
		if(away)
			src.visible_message("The Terminal States: Probe scan at 33%")
		sleep(scandelay)
		if(away)
			src.visible_message("The Terminal States: Probe scan at 66%")
		sleep(scandelay)
		if(away)
			src.visible_message("The Terminal States: Probe scan complete. Please signal for return")
			//if the probe isn't recalled, fill it with stuff
			fillprobe()
		return 1

/obj/machinery/computer/probe/proc/fillprobe()
	//gather debries
	//TODO
	//fill the gas tank
	for(var/obj/machinery/atmospherics/pipe/tank/probe/x in locate(PROBE_AWAY_AREA))
		var/datum/gas_mixture/mix
		mix = new /datum/gas_mixture
		mix.temperature = ship.curplanet.temp
		mix.volume = x.volume
/*		for(var/datum/feature/y in ship.curplanet.features)
			if(y.name == "Water")
				mix.adjust(o2 = (25*ONE_ATMOSPHERE)*(mix.volume)/(R_IDEAL_GAS_EQUATION*mix.temperature),0,0,0, null)
			if(y.name == "Deuterium")
				mix.toxins = (25*ONE_ATMOSPHERE)*(mix.volume)/(R_IDEAL_GAS_EQUATION*mix.temperature)
			if(y.name == "Plant Life"||y.name == "Animal Life" || y.name == "Intelligent Life")
				mix.oxygen = (25*ONE_ATMOSPHERE)*(mix.volume)/(R_IDEAL_GAS_EQUATION*mix.temperature)
				mix.nitrogen = (75*ONE_ATMOSPHERE)*(mix.volume)/(R_IDEAL_GAS_EQUATION*mix.temperature)
				mix.carbon_dioxide = (1*ONE_ATMOSPHERE)*(mix.volume)/(R_IDEAL_GAS_EQUATION*mix.temperature)*/
		x.air_temporary = mix
	//collect various reagents from your surrounding
	for(var/obj/structure/reagent_dispensers/probe/x in locate(PROBE_AWAY_AREA))
		for(var/datum/feature/y in ship.curplanet.features)
			if(y.name == "Water")
				if(prob(50))
					x.reagents.add_reagent("water",100)
				if(prob(50))
					x.reagents.add_reagent("ice",100)
			if(y.name == "Ammonia Deposits")
				if(prob(75))
					x.reagents.add_reagent("ammonia",100)
			if(y.name == "Deuterium")
				if(prob(35))
					x.reagents.add_reagent("hydrogen",100)
			if(y.name == "Methane Deposits" || y.name == "Shipwreak")
				if(prob(75))
					x.reagents.add_reagent("fuel",100)
			if(y.name == "Volcanic Activity")
				if(prob(25))
					x.reagents.add_reagent("sulfur",100)
			if(y.name == "Mineral Deposits"||y.name =="Moon" || y.name == "Rings"||y.name == "Asteroids"||y.name == "Meteors")
				if(prob(10))
					x.reagents.add_reagent("iron",100)
				if(prob(10))
					x.reagents.add_reagent("copper",100)
				if(prob(10))
					x.reagents.add_reagent("gold",100)
				if(prob(10))
					x.reagents.add_reagent("silver",100)
				if(prob(10))
					x.reagents.add_reagent("potassium",100)
				if(prob(10))
					x.reagents.add_reagent("mercury",100)
				if(prob(10))
					x.reagents.add_reagent("uranium",100)
				if(prob(10))
					x.reagents.add_reagent("aluminum",100)
				if(prob(10))
					x.reagents.add_reagent("silicon",100)

			if(y.name == "Radiation Spike")
				if(prob(50))
					x.reagents.add_reagent("radium",250)
				if(prob(50))
					x.reagents.add_reagent("mutagen",50)
			if(y.name == "Ion Storm")
				x.reagents.add_reagent("uranium",250)
			if(y.name == "Bluespace Rift")
				if(prob(5))
					x.reagents.add_reagent("holywater",100)
				if(prob(5))
					x.reagents.add_reagent("nanites",100)
				if(prob(5))
					x.reagents.add_reagent("xenomicrobes",100)
				if(prob(5))
					x.reagents.add_reagent("nicotine",100)
				if(prob(5))
					x.reagents.add_reagent("slimejelly",100)
				if(prob(5))
					x.reagents.add_reagent("cyanide",100)
				if(prob(5))
					x.reagents.add_reagent("minttoxin",100)
				if(prob(5))
					x.reagents.add_reagent("glue",100)
				if(prob(1))
					if(prob(1))
						x.reagents.add_reagent("adminordrazine",1)
			if(y.name == "Plant Life")
				x.reagents.add_reagent("nutriment",20)
				if(prob(33))
					x.reagents.add_reagent("sugar",20)
				if(prob(33))
					x.reagents.add_reagent("nitrogen",20)
				if(prob(33))
					x.reagents.add_reagent("ethanol",20)
				if(prob(5))
					x.reagents.add_reagent("lube",5)
				if(prob(5))
					x.reagents.add_reagent("stoxin",5)
				if(prob(5))
					x.reagents.add_reagent("potassium",5)
				if(prob(5))
					x.reagents.add_reagent("sterilizine",5)
				if(prob(5))
					x.reagents.add_reagent("plasticide",5)
				if(prob(5))
					x.reagents.add_reagent("frostoil",5)
				if(prob(5))
					x.reagents.add_reagent("stoxin2",5)
				if(prob(5))
					x.reagents.add_reagent("space_drugs",5)
				if(prob(5))
					x.reagents.add_reagent("glycerol",5)
				if(prob(5))
					x.reagents.add_reagent("imidazoline",20)
				if(prob(5))
					x.reagents.add_reagent("peridaxon",20)
				if(prob(25))
					x.reagents.add_reagent("hyperzine",20)
			if(y.name == "Animal Life")
				x.reagents.add_reagent("nutriment",20)
				if(prob(25))
					x.reagents.add_reagent("blood",20)
				if(prob(1))
					x.reagents.add_reagent("mutationtoxin",1)
				if(prob(1))
					x.reagents.add_reagent("amutationtoxin",1)
				if(prob(10))
					x.reagents.add_reagent("serotrotium",5)
				if(prob(10))
					x.reagents.add_reagent("virusfood", 5)
				if(prob(5))
					x.reagents.add_reagent("fuel",20)
				if(prob(50))
					x.reagents.add_reagent("cryptobiolin", 20)
				if(prob(5))
					x.reagents.add_reagent("impedrezene",5)
				if(prob(5))
					x.reagents.add_reagent("imidazoline",20)
				if(prob(5))
					x.reagents.add_reagent("peridaxon",20)
				if(prob(25))
					x.reagents.add_reagent("hyperzine",20)
			if(y.name == "Life Signs"||y.name == "Intelligent Life")
				if(prob(5))
					x.reagents.add_reagent("lube",20)
				if(prob(5))
					x.reagents.add_reagent("inaprovaline",20)
				if(prob(20))
					x.reagents.add_reagent("space_drugs",50)
				if(prob(20))
					x.reagents.add_reagent("serotrotium",50)
				if(prob(5))
					x.reagents.add_reagent("thermite",20)
				if(prob(5))
					x.reagents.add_reagent("tramadol",100)
				if(prob(25))
					x.reagents.add_reagent("fuel",200)
				if(prob(25))
					x.reagents.add_reagent("cleaner",200)
				if(prob(5))
					x.reagents.add_reagent("kelotane",20)
				if(prob(5))
					x.reagents.add_reagent("dermaline",20)
				if(prob(5))
					x.reagents.add_reagent("dexalin",20)
				if(prob(5))
					x.reagents.add_reagent("dexalinp",20)
				if(prob(5))
					x.reagents.add_reagent("tricordrazine",20)
				if(prob(5))
					x.reagents.add_reagent("anti_toxin",20)
				if(prob(5))
					x.reagents.add_reagent("synaptizine",20)
				if(prob(5))
					x.reagents.add_reagent("impedrezene",20)
				if(prob(5))
					x.reagents.add_reagent("arithrazine",20)
				if(prob(5))
					x.reagents.add_reagent("alkysine",20)
				if(prob(5))
					x.reagents.add_reagent("imidazoline",20)
				if(prob(5))
					x.reagents.add_reagent("bicaridine",20)
				if(prob(15))
					x.reagents.add_reagent("hyperzine",20)
				if(prob(5))
					x.reagents.add_reagent("peridaxon",20)
				if(prob(35))
					x.reagents.add_reagent("beer2",400)
				if(prob(35))
					x.reagents.add_reagent("beer",400)
				if(prob(1))
					x.reagents.add_reagent("silencer",300)
				if(prob(1))
					if(prob(1))
						x.reagents.add_reagent("nanocap",1000)
/area/probay
	name = "\improper Probe Bay"
	icon_state = "probe"

/area/probe/station
	name = "Probe ship"
	icon_state = "shuttle"
	luminosity = 1
	lighting_use_dynamic = 0
	requires_power = 0
/area/probe/away
	name = "Probe away"
	icon_state = "shuttle2"
	luminosity = 1
	lighting_use_dynamic = 0
	requires_power = 0
//Probe Equipment
/obj/structure/reagent_dispensers/probe
	anchored = 1
	name = "Probe Liquid Tank"
	desc = "Carries liquid collected from sites."
	icon_state = "probetank"
/obj/structure/reagent_dispensers/generic
	name = "Portable Tank"
	desc = "Used to move large quantities of liquids"
	icon_state = "probeportable"
/obj/machinery/atmospherics/pipe/tank/probe
	name = "Probe Gas Canister"
	desc = "Carries gas collected from sites."