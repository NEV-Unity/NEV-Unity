// This system defines news that will be displayed in the course of a round.
// Uses BYOND's type system to put everything into a nice format

/datum/news_announcement
	var
		round_time // time of the round at which this should be announced, in seconds
		message // body of the message
		author = "USN Internal Leaks!"
		channel_name = "Tau Ceti Daily"
		can_be_redacted = 0

	revolution_inciting_event

		paycuts_suspicion
			round_time = 60*10
			message = {"Breaking news! United Stellar Nations leadership threatens government shutdown after
						political negotiations break down this week between Martian and Sol representatives.
						Within the next hour the USN council will meet for a final time in an attempt
						to prevent a shutdown, and ensure all government employees are paid. One representative
						has already sworn that he will never budge on his moral values!"}
			author = "Unauthorized"

		tesau_filibuster
			round_time = 60*20
			message = {"Breaking news! The Pekhota delegates to the United Stellar Nations summit threatens 
						filibuster the proposed budget discussions if more money is not allocated to
						financial aid to minority groups. Supported by the Unathi and Kida delegates,
						the Tesau representative has taken the floor to recite the entire Twilight series in
						an attempt to prevent any further discussion on the budget."}
			author = "Unauthorized"

		paycuts_confirmation
			round_time = 60*40
			message = {"Earlier rumours about a governent shutdown has been confirmed. Shockingly, however, 
						the pay freeze will only affect lower tier personnel. 
						Command Staff will, according to our sources, not be affected."}
			author = "Unauthorized"

		riots_in_europa
			round_time = 60*60
			message = {"Rioting has broken out on Europa, as over a million government employees walks off the job today
						in protest of the government shutdown. Unionized government workers have begun to picket
						military sites. There are reports of tear gas used by the military on the protestors."}
		blackops
			round_time = 60*75
			message = {"Reports of several peaceful protesters being held in illegal detention camps without trial by the western Earth government have been
						proven legitimate, in this dark hour. This reporter has went undercover into one of those camps
						Many of which are populated by non-humans. Outrage has sparked throughout the alliance as many allies
						of the western nations have denounced the USN as a whole, and many minor member-states have threatened
						to leave the alliance."}
			author = "Unauthorized"

		human_experiments
			round_time = 60*90
			message = {"Unbelievable reports about human experimentation have reached our ears. According
			 			to a refugee from one of the USSN research facilities, their station, in order
			 			to increase revenue, has refactored several of their facilities to perform experiments
			 			on live humans, including virology research, genetic manipulation, and \"feeding them
			 			to the slimes to see what happens\". Allegedly, these test subjects were neither
			 			protohumans nor volunteers, but rather unqualified staff that were forced into
			 			the experiments, and reported to have died in a \"work accident\" by The USN."}
			author = "Unauthorized"

	bluespace_research

		announcement
			round_time = 60*20
			message = {"The new field of research trying to explain several interesting spacetime oddities,
						also known as \"Bluespace Research\", has reached new heights. Of the several
						hundred space stations now orbiting in Tau Ceti, fifteen are now specially equipped
						to experiment with and research Bluespace effects. Rumours have it some of these
						stations even sport functional \"travel gates\" that can instantly move a whole research
						team to an alternate reality."}

	random_junk

		cheesy_honkers
			author = "Assistant Editor Carl Ritz"
			channel_name = "The Gibson Gazette"
			message = {"Do cheesy honkers increase risk of having a miscarriage? Several health administrations
						say so!"}
			round_time = 60 * 15

		net_block
			author = "Assistant Editor Carl Ritz"
			channel_name = "The Gibson Gazette"
			message = {"Several corporations banding together to block access to 'wetskrell.nt', site administrators
			claiming violation of net laws."}
			round_time = 60 * 50

		found_ssd
			channel_name = "Tau Ceti Daily"
			author = "Doctor Eric Hanfield"

			message = {"Several people have been found unconscious at their terminals. It is thought that it was due
						to a lack of sleep or of simply migraines from staring at the screen too long. Camera footage
						reveals that many of them were playing games instead of working and their pay has been docked
						accordingly."}
			round_time = 60 * 90

	lotus_tree

		explosions
			channel_name = "Tau Ceti Daily"
			author = "Reporter Leland H. Howards"

			message = {"The newly-christened civillian transport Lotus Tree suffered two very large explosions near the
						bridge today, and there are unconfirmed reports that the death toll has passed 50. The cause of
						the explosions remain unknown, but there is speculation that it might have something to do with
						the recent change of regulation in the Moore-Lee Corporation, a major funder of the ship, when M-L
						announced that they were officially acknowledging inter-species marriage and providing couples
						with marriage tax-benefits."}
			round_time = 60 * 30

	food_riots

		breaking_news
			channel_name = "Tau Ceti Daily"
			author = "Reporter Ro'kii Ar-Raqis"

			message = {"Breaking news: Food riots have broken out throughout the Refuge asteroid colony in the Tenebrae
						Lupus system. This comes only hours after Government officials announced they will no longer trade with the
						colony, citing the increased presence of \"hostile factions\" on the colony has made trade too dangerous to
						continue. Government officials have not given any details about said factions. More on that at the top of
						the hour."}
			round_time = 60 * 10

		more
			channel_name = "Tau Ceti Daily"
			author = "Reporter Ro'kii Ar-Raqis"

			message = {"More on the Refuge food riots: The Refuge Council has condemned Government's withdrawal from
			the colony, claiming \"there has been no increase in anti-Government activity\", and \"\[the only] reason
			Government withdrew was because the \[Tenebrae Lupus] system's Plasma deposits have been completely mined out.
			We have little to trade with them now\". Government officials have denied these allegations, calling them
			\"further proof\" of the colony's anti-Government stance. Meanwhile, Refuge Security has been unable to quell
			the riots. More on this at 6."}
			round_time = 60 * 60


var/global/list/newscaster_standard_feeds = list(/datum/news_announcement/bluespace_research, /datum/news_announcement/lotus_tree, /datum/news_announcement/random_junk,  /datum/news_announcement/food_riots)

proc/process_newscaster()
	check_for_newscaster_updates(ticker.mode.newscaster_announcements)

var/global/tmp/announced_news_types = list()
proc/check_for_newscaster_updates(type)
	for(var/subtype in typesof(type)-type)
		var/datum/news_announcement/news = new subtype()
		if(news.round_time * 10 <= world.time && !(subtype in announced_news_types))
			announced_news_types += subtype
			announce_newscaster_news(news)

proc/announce_newscaster_news(datum/news_announcement/news)

	var/datum/feed_message/newMsg = new /datum/feed_message
	newMsg.author = news.author
	newMsg.is_admin_message = !news.can_be_redacted

	newMsg.body = news.message

	var/datum/feed_channel/sendto
	for(var/datum/feed_channel/FC in news_network.network_channels)
		if(FC.channel_name == news.channel_name)
			sendto = FC
			break

	if(!sendto)
		sendto = new /datum/feed_channel
		sendto.channel_name = news.channel_name
		sendto.author = news.author
		sendto.locked = 1
		sendto.is_admin_channel = 1
		news_network.network_channels += sendto

	sendto.messages += newMsg

	for(var/obj/machinery/newscaster/NEWSCASTER in allCasters)
		NEWSCASTER.newsAlert(news.channel_name)
