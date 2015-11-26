/obj/effect/landmark/zoneloader
	name = "awayloader"
	icon = 'icons/mob/screen1.dmi'
	icon_state = "x2"
	anchored = 1.0
	unacidable = 1

/turf/simulated/floor/plating/away/
	name = "Ground"
	icon_state = "asteroid"
	icon_plating = "asteroid"



/turf/simulated/floor/plating/away/grass
	name = "Grass patch"
	icon_state = "grass1"
	icon_plating = "grass1"
	footstep_sound = "grassstep"

	New()
		icon_state = "grass[pick("1","2","3","4")]"
		..()
		spawn(4)
			if(src)
				for(var/direction in cardinal)
					if(istype(get_step(src,direction),/turf/simulated/floor))
						var/turf/simulated/floor/FF = get_step(src,direction)
						FF.update_icon() //so siding get updated properly


/turf/simulated/floor/plating/away/grass/attackby(obj/item/C as obj, mob/user as mob)

	if(!C || !user)
		return 0
	if(istype(C, /obj/item/weapon/shovel))
		new /obj/item/weapon/ore/glass(src)
		new /obj/item/weapon/ore/glass(src) //Make some sand if you shovel grass
		user << "\blue You shovel the grass."
		make_plating()
		return 0
	..()
proc/createAwayMission()
	var/list/potentialRandomZlevels = list()
	world << "\red \b DEBUG: Searching for away missions..."
	var/list/Lines
	if(ship.curplanet.planet_type == "Anom") //If the planet is an anomoly, load an empty space map
		Lines = file2list("maps/RandomZLevels/anomList.txt")
	else if(ship.curplanet.planet_type == "Habit")//If the planet is habitable, load a habitable map.
		Lines = file2list("maps/RandomZLevels/habitList.txt")
	else if(ship.curplanet.planet_type == "Debris")//If the planet is a debris fild, load a mining map
		Lines = file2list("maps/RandomZLevels/debrisList.txt")
	else if(ship.curplanet.planet_type == "Dead")//If the planet is a dead world, load a dead map
		Lines = file2list("maps/RandomZLevels/deadList.txt")
	else //If we don't have a map list already created, default to the default list.
		Lines = file2list("maps/RandomZLevels/fileList.txt")
	if(!Lines.len)	return
	for (var/t in Lines)
		if (!t)
			continue

		t = trim(t)
		if (length(t) == 0)
			continue
		else if (copytext(t, 1, 2) == "#")
			continue

		var/pos = findtext(t, " ")
		var/name = null
	//	var/value = null

		if (pos)
            // No, don't do lowertext here, that breaks paths on linux
			name = copytext(t, 1, pos)
		//	value = copytext(t, pos + 1)
		else
            // No, don't do lowertext here, that breaks paths on linux
			name = t

		if (!name)
			continue

		potentialRandomZlevels.Add(name)


	if(potentialRandomZlevels.len)
		world << "\red \b Loading away mission... Expect some minor lag"

		var/map = pick(potentialRandomZlevels)
		var/file = file(map)
		if(isfile(file))
			maploader.load_map(file,z_offset = awayZLevel, load_speed = 100)

		for(var/obj/effect/landmark/zoneloader/x in world)
			loadRandomZone(x)
		world << "\red \b Away mission loaded."
	if(ship.curplanet.planet_type == "Habit")
		for(var/turf/simulated/floor/plating/away/grass/x in world) //MARK
			if(x.z == awayZLevel)
				x.temperature = ship.curplanet.temp
				if(ship.curplanet.temp < 273)
					x.icon_state = "snow"
					x.name = "snow"
					x.icon_plating = "snow"
				if(ship.curplanet.temp > 315)
					x.icon_state = "asteroid"
					x.name = "desert"
					x.icon_plating = "asteroid"
		for(var/obj/structure/flora/tree/pine/x in world)
			if(x.z == awayZLevel)
				if(ship.curplanet.temp < 273)
					x.icon_state = pick("pine_1","pine_2","pine_3")
				if(ship.curplanet.temp > 315)
					x.icon_state = pick("deadtree_1", "deadtree_2", "deadtree_3","deadtree_4","deadtree_5","deadtree_6")



 //remove the random away zone from the list

	else
		world << "\red \b No away missions found."
		return
proc/loadRandomZone(var/obj/effect/landmark/zoneloader/target)
	var/list/potentialRandomZones = list()
	world << "\red \b DEBUG: Loading Random Zones..."
	var/list/Lines = list()

//First we load the generic mapfiles

	if(ship.curplanet.planet_type == "Anom") //If the planet is an anomoly, load from the anomoly lists
		Lines = file2list("maps/RandomZLevels/anomZoneGeneric.txt")
	else if(ship.curplanet.planet_type == "Habit")//If the planet is habitable, load from the habitable lists.
		Lines = file2list("maps/RandomZLevels/habitZoneGeneric.txt")
	else if(ship.curplanet.planet_type == "deadZoneGeneric.txt")
		Lines = file2list("maps/RandomZLevels/deadZoneGeneric.txt")
	else //If we don't have a map list already created, default to the default lists.
		Lines = file2list("maps/RandomZLevels/zoneGeneric.txt")



	for(var/datum/feature/x in ship.curplanet.features)
		if(ship.curplanet.planet_type == "Anom") //If the planet is an anomoly, load from the anomoly lists
			if(x.name == "Intermittent Signal")
				Lines.Add(file2list("maps/RandomZLevels/anomShipZones.txt"))
			if(x.name == "Sensor Blip")
				Lines.Add(file2list("maps/RandomZLevels/anomShipZones.txt"))
			if(x.name == "Intercepted Transmission")
				Lines.Add(file2list("maps/RandomZLevels/anomShipZones.txt"))
			if(x.name == "Anomolous Sector")
				Lines.Add(file2list("maps/RandomZLevels/mineralZones.txt"))
			if(x.name == "Gravity Field")
				Lines.Add(file2list("maps/RandomZLevels/mineralZones.txt"))
		if(ship.curplanet.planet_type == "Habit")
			if(x.name == "Ruins")
				Lines.Add(file2list("maps/RandomZLevels/habitStructureZones.txt"))
			if(x.name == "Outpost")
				Lines.Add(file2list("maps/RandomZLevels/habitStructureZones.txt"))
			if(x.name == "Intelligent Life")
				Lines.Add(file2list("maps/RandomZLevels/habitStructureZones.txt"))
		if(ship.curplanet.planet_type == "Debris")
			Lines.Add(file2list("maps/RandomZLevels/mineralZones.txt"))
			if(x.name == "Shipwreak")
				Lines.Add(file2list("maps/RandomZLevels/anomShipZones.txt"))
			if(x.name == "Energy Signatures")
				Lines.Add(file2list("maps/RandomZLevels/anomShipZones.txt"))
			if(x.name == "Life Signs")
				Lines.Add(file2list("maps/RandomZLevels/anomShipZones.txt"))
			if(x.name == "Distress Beacon")
				Lines.Add(file2list("maps/RandomZLevels/anomShipZones.txt"))
			if(x.name == "Empty Space")
				Lines.Add(file2list("maps/RandomZLevels/anomZoneGeneric.txt"))
			if(x.name == "Space Carp")
				Lines.Add(file2list("maps/RandomZLevels/spaceCarpZones.txt"))
			if(x.name == "Asteroids")
				Lines.Add(file2list("maps/RandomZLevels/mineralZones.txt"))
			if(x.name == "Meteors")
				Lines.Add(file2list("maps/RandomZLevels/mineralZones.txt"))
			if(x.name == "Space Junk")
				Lines.Add(file2list("maps/RandomZLevels/mineralZones.txt"))
		if(ship.curplanet.planet_type == "Gas")
			if(x.name == "Moon")
				Lines.Add(file2list("maps/RandomZLevels/mineralZones.txt"))
			if(x.name == "Rings")
				Lines.Add(file2list("maps/RandomZLevels/mineralZones.txt"))


	if(!Lines.len)	return
	for (var/t in Lines)
		if (!t)
			continue

		t = trim(t)
		if (length(t) == 0)
			continue
		else if (copytext(t, 1, 2) == "#")
			continue

		var/pos = findtext(t, " ")
		var/name = null
	//	var/value = null

		if (pos)
            // No, don't do lowertext here, that breaks paths on linux
			name = copytext(t, 1, pos)
		//	value = copytext(t, pos + 1)
		else
            // No, don't do lowertext here, that breaks paths on linux
			name = t

		if (!name)
			continue

		potentialRandomZones.Add(name)
	if(potentialRandomZones.len)
		world << "\red \b Loading away zone."

		var/map = pick(potentialRandomZones)
		var/file = file(map)
		if(isfile(file))
			maploader.load_map(file, z_offset = target.loc.z, y_offset =target.loc.y, x_offset = target.loc.x, load_speed = 100)
		del(target)
		world << "\red \b Away zone loaded."

	else
		world << "\red \b No away zone found."
		SetupXenoarchZ(awayZLevel)
		return



