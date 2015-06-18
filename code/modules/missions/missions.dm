/*
* Module by Jamini
* Shift mss Code
* Optional, Role-play objectives for the crew
* Creates a quick printout on the bridge at round start
* That gives the crew direction if they lack their
* Own ideas for extended or slow rounds.
*
* The shift mss is printed at round end
* Under the AI EOR stuff
*/

/datum/game_mode/proc/send_mss()
	//Header for the mss. Always the same!
	var/intercepttext = "<FONT size = 3><B>Cent. Com. Update</B> mission summary:</FONT><HR>"
	intercepttext += "<B> In case you have misplaced your copy, attached is your current Mission status update: </B><br><hr>"
	//Create the mss here

	var/mssfile = file2text("config/missions/missionlist.txt")//List of all availible missions. In config/missions folder
	var/list/mssoptions = text2list(mssfile, "\n") //convert that external list into a list in code
	var/datum/mss/mss = new /datum/mss()
	mss.forge_mss(pick(mssoptions)) //we forge a mss out of the list
	intercepttext += mss.msstext //here we take the mss text and put it on the intercept

	//then we print it out.
	for (var/obj/machinery/computer/communications/comm in machines)
		if (!(comm.stat & (BROKEN | NOPOWER)) && comm.prints_intercept)
			var/obj/item/weapon/paper/intercept = new /obj/item/weapon/paper( comm.loc )
			intercept.name = "Cent. Com. Mission Summary"
			intercept.info = intercepttext

			comm.messagetitle.Add("Cent. Com. Mission Summary")
			comm.messagetext.Add(intercepttext)

/datum/mss
	var/msstext = ""
/datum/mss/proc/forge_mss(var/name)
	var/file = file2text("config/missions/mission" + name + ".txt")//takes the selected mss text file
	var/lines = text2list(file, "\n") //convert it to a list
	for(var/line in lines)//and add it line by line to the mss text
		if (!line)
			continue
		else
			msstext += (line + "<br>") //<br> added so it can be parsed correctly!