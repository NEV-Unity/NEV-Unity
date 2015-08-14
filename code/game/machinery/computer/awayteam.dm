//This file was auto-corrected by findeclaration.exe on 25.5.2012 20:42:31

// The communications computer
/obj/machinery/computer/awayteam
	name = "Away Team Communications Console"
	desc = "This console is used to communicate with the ship."
	icon_state = "comm"
	circuit = "/obj/item/weapon/circuitboard/awayteam"
	var/message

/obj/machinery/computer/awayteam/attack_hand(user as mob)
	if(..(user))
		return
	src.add_fingerprint(usr)
	var/dat
	dat = text("<center>Away Team Communications Console:<br> <b><A href='?src=\ref[src];message=[1]'>Send Message</A></b></center>")
	user << browse("[dat]", "window=awaycommconsole;size=200x100")

/obj/machinery/computer/awayteam/Topic(href, href_list)
	if(..())
		return
	usr.set_machine(src)
	src.add_fingerprint(usr)
	if(href_list["message"])
		message = copytext(reject_bad_text(input(usr, "Write your message:", "Awaiting Input", "")),1,MAX_MESSAGE_LEN)
		for(var/mob/M in player_list)
			if(!istype(M,/mob/new_player))
				M << "<b><font size = 3><font color = red>Incoming message:</font color> [message]</font size></b>"
