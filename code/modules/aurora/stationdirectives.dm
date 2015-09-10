/*
 *
 *For housing procs and things related to the viewing of Station Directives.
 *Later iterations may get bound through other DMs
 *
 */

/*
 *Proc for fetching and displaying the Ship Directives
 */

/client/proc/directiveslookup(var/screen = 1, var/queryid="")
	var/dat = "<div align='center'><b>Ship Directives<br>United Stellar Nations<br>[station_name]</b></div><br>"
	dat += "<div align='center'><b>OOC Information:</b><br>These directives mock the Standard Operating Procedure which would otherwise be in place aboard the ship. They are not enforced out of character wise, however, you may find your character penalized in-game for not following them.</div><br>"

	establish_db_connection()
	if(!dbcon.IsConnected())
		dat += text("<div align='center'><font color=red><b>ERROR</b>: Unable to contact external database.</div></font>")
		error("SQL database connection failed. Attempted to fetch form information.")

	switch(screen)
		if(1)
			var/DBQuery/query = dbcon.NewQuery("SELECT id, name FROM aurora_directives")
			query.Execute()
			dat += "<div align='center'><table width='90%' cellpadding='2' cellspacing='0'>"
			dat += "<tr><td colspan='3' bgcolor='white' align='center'><a href='?src=\ref[src];directivescreen=3'>Regarding Ship Directives</a><br></td></tr>"

			while(query.NextRow())
				var/id = text2num(query.item[1])
				var/name = query.item[2]

				var/bgcolor = "#e3e3e3"
				if(id%2 == 0)
					bgcolor = "white"
				dat += "<tr bgcolor='[bgcolor]'><td>Directive #[id]</td><td>[name]</td><td><a href='?src=\ref[src];directiveview=[id]'>Review</a></td></tr>"
			dat += "</table></div>"
		if(2)
			if(!queryid)
				return //this should never happen

			var/DBQuery/searchquery = dbcon.NewQuery("SELECT id, name, data FROM aurora_directives WHERE id=[queryid]")
			searchquery.Execute()

			while(searchquery.NextRow())
				var/id = searchquery.item[1]
				var/name = searchquery.item[2]
				var/data = searchquery.item[3]

				dat += "<div align='center'><b>Directive #[id]<br>'[name]'</b></div><hr>"
				dat += "<div align='justify'>[data]</div>"

			dat += "<div align='center'><a href='?src=\ref[src];directivescreen=1'>Return to Index</a></div>"
		if(3)
			dat += "<div align='center'><b>Regarding Ship Directives</b></div><hr>"
			dat += "<div align='justify'>The Ship Directives are a set of specific orders and directives issued and enforced aboard a specific United Stellar Nations vessel. This terminal provides access to orders and directives enforced aboard the <i>[station_name].</i> Note that these are only enforced upon United Stellar Nations Personnel, and not civilians or visitors, unless ruled otherwise by sector specific Central Command.<br><br>"
			dat += "Punishment for a violation of Station Directives should be escalated in the following fashion:<br><ul><li>Verbal warning, and citation. Ensure that the crewmember is familiar with the Ship Directives.</li><li>Charge of violating article i111 - Failure to Execute an Order - of United Stellar Nations Regulation</li><li>Subsequent charge of violating article i206 - Neglect of Duty - of United Stellar Nations Regulation, and review of crewmember by the crewmember's Head of Staff.</li><li>Subsequent failure to follow ship directives will result in cryonic suspection until such time as a court martial can be convened</li></ul>"
			dat += "Dependent on the violation and actual crimes concerned, punishment may be escalated faster, with intent to ensure in the safety of ship, equipment and crew under jurisdiction of the local marshal.<br>"
			dat += "During emergency situation, ship directives may be overlooked or suspended at the discretion of the commanding officers. At the end of the emergency, same commanding officers must complete an Exceptional Circumstances review in accordance with regulations.</div>"
			dat += "<br><div align='center'><a href='?src=\ref[src];directivescreen=1'>Return to Index</a></div>"

	usr << browse("[dat]", "window=station_directives;size=400x400")
