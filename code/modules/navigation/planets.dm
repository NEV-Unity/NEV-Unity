datum/system
	var/name
	var/planets[] // List of planets in orbit
	var/star_number // Binary system?
	var/star_type //Approximate surface temperature of the star
	var/luminosity //Total radiation emitted by star. Luminosity differentiates stars within a class by size
	var/luminosity2 //binary star info
	var/rads //radiation output numeric value
/*
 Types
O, Blue, Over 25,000K (Ionized Helium )
B, Blue, 11,000K-25,000K ( Helium )
A, Blue, 7,500-11,000K (Hydrogen)
F, Blue-White, 6,000-7,500K
G, White-Yellow, 6,000-5,000K
K, Orange-Red, 5,000K-3,500K
M, Red, Under 3,500K
 */

/*
 Luminosity
Ia	Very luminous supergiants
Ib	Less luminous supergiants
II	Luminous giants
III	Giants
IV	Subgiants
V	Main sequence stars (dwarf stars)
VI	Subdwarf
VII	White Dwarf
	*/

datum/system/New()

	var/list/prefix = file2list("config/names/planetsfirst.txt")
	var/list/suffix = file2list("config/names/planetslast.txt")
	name = pick(prefix) + " " + pick(suffix) // Need input here from file. Randomize?
	star_type = pick("O","B","A","F","G","K","M") //Star color/temperature
	if(star_type == "O") //white dwarves are always weakest luminosity
		luminosity = "VII"
	else //All other stars vary depending on size!
		luminosity = pick("Ia","Ib","II","III","IV","V","VI")
	if(prob(25)) //25% chance of a binary system
		star_number = 2
		if(luminosity == "V" ||luminosity == "VI" || luminosity == "VII") //if we have a main sequence star
			luminosity2 = luminosity//Its binary star is identical!
		else //if we have a giant star
			luminosity2 = pick("V","VI","VII") //It's an eclipse binary!
	else //If we don't have a binary system, then we only have one star!
		luminosity2 = 0
		star_number = 1

//planet creation! Some of these are not planets, so make up to 20 sites! Also determine the radiation of this star. Ranging from 1-7.
	var/pnumber = 0
	switch(luminosity)
		if("VII")
			pnumber = rand(1,3)
			rads = 1
		if("VI")
			pnumber = rand(1,7)
			rads = 1
		if("V")
			pnumber = rand(1,12)
			rads = 2
		if("IV")
			pnumber = rand(1,12)
			rads = 3
		if("III")
			pnumber = rand(1,18)
			rads = 4
		else
			pnumber = rand(1,23)
			rads = 5
	switch(luminosity2)
		if("V")
			rads += 2
		if("VI" || "VII")
			rads += 1
	while(pnumber > 0)
		var/seed = rand(0,99)
		switch(star_type)
			if("O")
				seed = seed - 50 // White dwarves are mostly anomolies and balls of gas, with the very occasional Habitable world
			if("B")
				seed = seed - 30 // Blue stars are young and hot, so lots of gas giants and semi-habitable worlds, not so many airless rocks
			if("A")
				seed = seed - 10
			if("F")
				seed = seed
			if("G") //main sequence
				seed = seed + 10
			if("K") //orange/red stars have more debries fields and dead planets
				seed = seed + 30
			if("M") //red giants have tons of burnt-out rocks circling
				seed = seed + 50
		seed = seed - (pnumber * 5) //As you go out, you get more gas giants and anomolies
		var/ptype = "Dead"
		switch(seed)
			if(-100 to 9)
				ptype = "Anom"
			if(10 to 24)
				ptype = "Gas"
			if(25 to 34)
				ptype = "Habit"
			if(35 to 59)
				ptype = "Debris"
			if(60 to 200)
				ptype = "Dead"
		var/datum/planet/x = new /datum/planet(ptype)
		x.orbit_number = pnumber
		x.system = src
		if(planets)
			planets.Add(x)
		else
			planets = list(x)
		pnumber--

datum/planet/
	var/name
	var/orbit_number // How far from the star?
	var/datum/system/system //Who do you orbit?
	var/planet_type //See below. What type of planet is it?
//	var/datum/probe/probe
//Below vars show up on the scanner
	var/temp // How hot the site is
	var/size // How big the site is
	var/rads
	var/list/features
	var/visit

datum/planet/New()
	//Import random planet names here
	var/list/prefix = file2list("config/names/planetsfirst.txt")
	var/list/suffix = file2list("config/names/planetslast.txt")
	name = pick(prefix) + " " + pick(suffix) // Need input here from file. Randomize?

	//New() just spawns a blank planet
	orbit_number = 0
	system = null
	planet_type = null //This should never show
//	probe = null //planets don't start with probes

	temp = rand(100,473) //-173C to 200C
	size = rand(1,5)  // scale of 1-5. This determines how many features a site has.
	rads = rand(1,5) // scale of 1-5. Intensity determines light/temperature/radiation of a site
	visit = 0 // by default planets do not load sites

datum/planet/New(var/typein)
	..()
	planet_type = typein
	var/list/possible_features
	possible_features = null
	if(typein == "Anom")
		possible_features = list( "Intermittent Signal",  "Sensor Blip",  "Anomolous Sector", "Bluespace Rift", "Gravity Field", "Ion Storm",  "Radiation Spike",  "Solar Flare", "Intercepted Transmission")
	if(typein == "Gas")
		possible_features = list("Water","Helium Banding","Ammonia Deposits","Deuterium","Methane Deposits","Rings", "Moon",  "Hotspot")
	if(typein == "Habit")
		temp = rand(245, 368)
		possible_features = list("Mineral Deposits", "Caverns", "Desert", "Water", "Plant Life", "Animal Life",  "Intelligent Life",  "Ruins", "Volcanic Activity",  "Shipwreak",  "Mountains",  "Outpost",  "Moon")
		visit = 1
	if(typein == "Debris")
		possible_features = list("Shipwreak","Shipwreak","Skipjack","Combat Drones","Water", "Garbled Transmission",  "Asteroids",  "Energy Signatures",  "Life Signs",  "Distress Beacon",  "Empty Space", "Meteors",  "Space Junk", "Space Carp")
		visit = 1
	if(typein == "Dead")
		possible_features = list("Mineral Deposits","Mineral Deposits","Mineral Deposits","Water", "Caverns", "Caverns", "Caverns", "Facility",  "Space Carp")
		visit = 1
	var/x = 0
	while(x < size)
		var/datum/feature/zone = new /datum/feature()
		zone.name = pick(possible_features)
		if(features)
			features.Add(zone)
		else
			features = list(zone)
		x++
	return

datum/feature
	var/name
/*
  Planets
  Main sequence stars have most "Habitable" planets
  Giants have the most planets overall (Often Dead planets or gas giants)
  Dwarfs have the most  "Asteroids"
  Older/redder stars have the most "Debries"

  Site types
  -Habitable (Expo planet. Food/planets/hostile mobs. Provides O2, N2)
  --High/Low/Mid tech
  --Hot/cold/temperate
  --Arid/Costal/Aquatic

  -Gas Giant (Provides random gas in the probe canisters. Occasionally finds a deep space artifact)
  --Hydrogen
  --Helium
  --Methane
  --Ammonia

  -Dead Planets (Mining maps)
  --Iron
  --Silicates
  --Carbonates

  -Debries (Expo site. Derelict ships. Artifacts?)
  --War (Battle)
  --Temple (Tomb)
  --House (Scuttled)
  --Ark (Overrun)
  --School (Abanoned)

  -Anomoly Fields (Adds special events)
  --Bluespace Field
  --Gravity Field
  --Unstable Wormhole Field
  --Electromagnetic

*/

datum/ship

	var/datum/system/cursystem
	var/datum/planet/curplanet
	var/datum/system/system1
	var/datum/system/system2
	var/probes
	var/cantmove = 0

/hook/startup/proc/createShip()
	ship = new /datum/ship()
	return 1

datum/ship/New()

	cursystem = new /datum/system()
	curplanet = null
	system1 = new /datum/system()
	system2 = new /datum/system()
	probes = 6

datum/ship/proc/move(datum/system/x) //Used for moving the ship. 0 is no move, -1 is system 1, 1 is system 2
	cursystem = x
	system1 = new /datum/system()
	system2 = new /datum/system()
	onPlanet = 0
	return
datum/ship/proc/moveplan(datum/planet/x)
	curplanet = x
	world << "DEBUG WORKS"
	createAwayMission()
	onPlanet = 1
	return