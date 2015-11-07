/*
Language  and radio Key quickref
1 - Zho			2 - Tradeband		3 - Gutter		4 - Sign
5 - Xenomorph		6 - Pekhota Sign	7 - Weis'unathi		8 - Ara
9 - Hindi		0 - Angelic		! - Emote		+ - Special radio channel
a - Xeno Hivemind	b - binary		c - command		d - drone
e - engineering		f - Uwe'unathi		g - ling		h - departent
i - intercomm		j - Rewar		k - Skrelian		l - left ear/hand
m - medical		n - science		o - Sitra'Unathi	p - Kida
q - Rootspeak		r - right ear/hand	s - security		t - syndicate
u - cargo		v - vox			w - whisper		x - borer
y - Sini		z - Zawan		* - Emote

Availible keys
-=@#$%^&() - Need to double-check if they can work as keys.

*/

#define SCRAMBLE_CACHE_LEN 20

var/global/list/language_datums = list()

proc/populate_language_list()
	for(var/type in typesof(/datum/language)-/datum/language)
		var/datum/language/G = new type()
		if(G.cost > 0)
			language_datums[G.name] = G

/*
	Datum based languages. Easily editable and modular.
*/

/datum/language
	var/name = "an unknown language" // Fluff name of language if any.
	var/desc = "A language."         // Short description for 'Check Languages'.
	var/speech_verb = "says"         // 'says', 'hisses', 'farts'.
	var/ask_verb = "asks"            // Used when sentence ends in a ?
	var/exclaim_verb = "exclaims"    // Used when sentence ends in a !
	var/whisper_verb                 // Optional. When not specified speech_verb + quietly/softly is used instead.
	var/signlang_verb = list()       // list of emotes that might be displayed if this language has NONVERBAL or SIGNLANG flags
	var/colour = "body"              // CSS style to use for strings in this language.
	var/key = "x"                    // Character used to speak in language eg. :o for Unathi.
	var/flags = 0                    // Various language flags.
	var/native                       // If set, non-native speakers will have trouble speaking.
	var/list/syllables               // Used when scrambling text for a non-speaker.
	var/list/space_chance = 55       // Likelihood of getting a space in the random scramble string.
	var/cost = 0                     // How much a lanauge costs to learn. languages with 0 cost are not on the language list

/datum/language/proc/get_random_name(var/gender, name_count=2, syllable_count=4)
	if(!syllables || !syllables.len)
		if(gender==FEMALE)
			return capitalize(pick(first_names_female)) + " " + capitalize(pick(last_names))
		else
			return capitalize(pick(first_names_male)) + " " + capitalize(pick(last_names))

	var/full_name = ""
	var/new_name = ""

	for(var/i = 0;i<name_count;i++)
		new_name = ""
		for(var/x = rand(Floor(syllable_count/2),syllable_count);x>0;x--)
			new_name += pick(syllables)
		full_name += " [capitalize(lowertext(new_name))]"

	return "[trim(full_name)]"

/datum/language
	var/list/scramble_cache = list()

/datum/language/proc/scramble(var/input)

	if(!syllables || !syllables.len)
		return stars(input)

	// If the input is cached already, move it to the end of the cache and return it
	if(input in scramble_cache)
		var/n = scramble_cache[input]
		scramble_cache -= input
		scramble_cache[input] = n
		return n

	var/input_size = length(input)
	var/scrambled_text = ""
	var/capitalize = 1

	while(length(scrambled_text) < input_size)
		var/next = pick(syllables)
		if(capitalize)
			next = capitalize(next)
			capitalize = 0
		scrambled_text += next
		var/chance = rand(100)
		if(chance <= 5)
			scrambled_text += ". "
			capitalize = 1
		else if(chance > 5 && chance <= space_chance)
			scrambled_text += " "

	scrambled_text = trim(scrambled_text)
	var/ending = copytext(scrambled_text, length(scrambled_text))
	if(ending == ".")
		scrambled_text = copytext(scrambled_text,1,length(scrambled_text)-1)
	var/input_ending = copytext(input, input_size)
	if(input_ending in list("!","?","."))
		scrambled_text += input_ending

	// Add it to cache, cutting old entries if the list is too long
	scramble_cache[input] = scrambled_text
	if(scramble_cache.len > SCRAMBLE_CACHE_LEN)
		scramble_cache.Cut(1, scramble_cache.len-SCRAMBLE_CACHE_LEN-1)


	return scrambled_text

/datum/language/proc/format_message(message, verb)
	return "[verb], <span class='message'><span class='[colour]'>\"[capitalize(message)]\"</span></span>"

/datum/language/proc/format_message_plain(message, verb)
	return "[verb], \"[capitalize(message)]\""

/datum/language/proc/format_message_radio(message, verb)
	return "[verb], <span class='[colour]'>\"[capitalize(message)]\"</span>"

/datum/language/proc/get_talkinto_msg_range(message)
	// if you yell, you'll be heard from two tiles over instead of one
	return (copytext(message, length(message)) == "!") ? 2 : 1

/datum/language/proc/broadcast(var/mob/living/speaker,var/message,var/speaker_mask)
	log_say("[key_name(speaker)] : ([name]) [message]")

	if(!speaker_mask) speaker_mask = speaker.name
	var/msg = "<i><span class='game say'>[name], <span class='name'>[speaker_mask]</span> [format_message(message, get_spoken_verb(message))]</span></i>"

	for(var/mob/player in player_list)
		if(istype(player,/mob/dead) || ((src in player.languages) && check_special_condition(player)))
			player << msg

/datum/language/proc/check_special_condition(var/mob/other)
	return 1

/datum/language/proc/get_spoken_verb(var/msg_end)
	switch(msg_end)
		if("!")
			return exclaim_verb
		if("?")
			return ask_verb
	return speech_verb

// Noise "language", for audible emotes.
/datum/language/noise
	name = "Noise"
	desc = "Noises"
	key = ""
	flags = RESTRICTED|NONGLOBAL|INNATE|NO_TALK_MSG|NO_STUTTER

/datum/language/noise/format_message(message, verb)
	return "<span class='message'><span class='[colour]'>[message]</span></span>"

/datum/language/noise/format_message_plain(message, verb)
	return message

/datum/language/noise/format_message_radio(message, verb)
	return "<span class='[colour]'>[message]</span>"

/datum/language/noise/get_talkinto_msg_range(message)
	// if you make a loud noise (screams etc), you'll be heard from 4 tiles over instead of two
	return (copytext(message, length(message)) == "!") ? 4 : 2

//Tesau Languages

/datum/language/tesaunoble
	name = "Rezar"
	desc = "The ancient and traditional language of the Hurahshi, composed of structured yowls and chirps. Native to the Tesau."
	speech_verb = "mrowls"
	ask_verb = "mrowls"
	exclaim_verb = "yowls"
	colour = "tajaran"
	key = "j"
	cost = 3
	syllables = list("tajr","kir","raj","kii","mir","kra","ak","nal","vah","khaz","jrri","ran","darr", \
	"mita","dynh","manq","rhe","zar","rrhaz","kal","char","eech","thaa","dra","jarl","mah","sana","dra","ii'r", \
	"ka","aasi","far","wa","baq","ara","qara","zir","sam","mak","hrar","nja","rir","khan","jan","dar","rik","kah", \
	"hal","ket","jarl","mah","tal","cresh","aza")

/datum/language/tesaubarb
	name = "Zawan"
	desc = "The traditional trade tounge of the Barbari,composed of expressive yowls and chirps. Native to the Tesau."
	speech_verb = "mrowls"
	ask_verb = "mrowls"
	exclaim_verb = "yowls"
	colour = "tajaran2"
	key = "z"
	cost = 3
	syllables = list("rr","rr","kir","ruj","kii","mir","kru","uhk","nul","vuh","khuz","jri","run","durr", \
	"mi","jri","dynh","munq","rhe","zur","rrhuz","eech","thuu","dru","jurl","muh","sunu","dru","ii'r","zic", "tus", \
	"ku","uusi","fur","wu","buq","uru","quru","zir","sum","muk","hrur","nju","rir","khun","jun","dur","rik","kuh", \
	"hul","ket","jurl","muh","tul","cresh","uzu","rugh")

/datum/language/tesausign
	name = "Pekhota sign"
	desc = "A mixture of manual comunication and body language used by Pekhota tesau for silent communication in the field."
	speech_verb = "signs"
	signlang_verb = list("reports")
	key = "6"
	flags = SIGNLANG
	cost = 3

//Unathi Languages

/datum/language/unathisinta
	name = "Sinta"
	desc = "A language composed of sililant hisses and rattles originating from the Sinta region of Moghes. Native to the Unathi."
	speech_verb = "hisses"
	ask_verb = "hisses"
	exclaim_verb = "roars"
	colour = "soghun"
	key = "o"
	syllables = list("ss","ss","ss","ss","skak","seeki","resh","las","esi","kor","sh")
	cost = 3

/datum/language/unathiue
	name = "Uwe"
	desc = "A language composed of sililant hisses and rattles originating from the Uwe region of Moghes. Native to the Unathi."
	speech_verb = "hisses"
	ask_verb = "hisses"
	exclaim_verb = "roars"
	colour = "soghun"
	key = "f"
	syllables = list("ss","ss","ss","ss","sauk","ssekri","rish","lash","si","kor","sah")
	cost = 3

/datum/language/unathweis
	name = "Weis"
	desc = "A language composed of sililant hisses and rattles originating from the Weisa region of Moghes. Native to the Unathi."
	speech_verb = "hisses"
	ask_verb = "hisses"
	exclaim_verb = "roars"
	colour = "soghun"
	key = "7"
	syllables = list("ss","ss","ss","ss","wausk","ssewri","rush","kash","ui","korwa","swe")
	cost = 3

//Skrell Languages

/datum/language/skrell
	name = "Skrellian"
	desc = "A melodic and complex language spoken by the Skrell. Some of the notes are inaudible to humans."
	speech_verb = "warbles"
	ask_verb = "warbles"
	exclaim_verb = "warbles"
	colour = "skrell"
	key = "k"
	syllables = list("qr","qrr","xuq","qil","quum","xuqm","vol","xrim","zaoo","qu-uu","qix","qoo","zix","*","!")
	cost = 3

/datum/language/sini
	name = "Sini"
	desc = "A melodic and complex language spoken by the Kocasslani Skrell. Some of the notes are inaudible to humans."
	speech_verb = "sings"
	colour = "skrell"
	key = "y"
	syllables = list("ur","urr","xuu","uil","uuum","xuum","gol","xrim","gaoo","uu-uu","uix","uoo","zix","*","!")
	cost = 3

//Kida - We may get more of these if kida become more popular

/datum/language/kida
	name = "Kida"
	desc = "A language made of clicks and sputters, native to the Kida"
	speech_verb = "clicks"
	colour = "vaurca"
	key = "p"
	flags = WHITELISTED
	syllables = list("kic","klic","\'tic","kit","lit","xic","vil","xrit","tshh","qix","qlit","zix","\'","!")
	cost = 3

//Trade and common Languages

/datum/language/trader
	name = "Tradeband"
	desc = "Maintained by the various trading cartels in major systems, this elegant, structured language is used for bartering and bargaining."
	speech_verb = "enunciates"
	colour = "say_quote"
	key = "2"
	space_chance = 100
	syllables = list("lorem", "ipsum", "dolor", "sit", "amet", "consectetur", "adipiscing", "elit",
					 "sed", "do", "eiusmod", "tempor", "incididunt", "ut", "labore", "et", "dolore",
					 "magna", "aliqua", "ut", "enim", "ad", "minim", "veniam", "quis", "nostrud",
					 "exercitation", "ullamco", "laboris", "nisi", "ut", "aliquip", "ex", "ea", "commodo",
					 "consequat", "duis", "aute", "irure", "dolor", "in", "reprehenderit", "in",
					 "voluptate", "velit", "esse", "cillum", "dolore", "eu", "fugiat", "nulla",
					 "pariatur", "excepteur", "sint", "occaecat", "cupidatat", "non", "proident", "sunt",
					 "in", "culpa", "qui", "officia", "deserunt", "mollit", "anim", "id", "est", "laborum")
	cost = 2

/datum/language/gutter
	name = "Gutter"
	desc = "Much like Ceti Basic, this crude pidgin tongue descended from numerous languages and serves as Tradeband for criminal elements."
	speech_verb = "growls"
	colour = "rough"
	key = "3"
	syllables = list ("gra","ba","ba","breh","bra","rah","dur","ra","ro","gro","go","ber","bar","geh","heh", "gra")
	cost = 2

/datum/language/sign
	name = "Sign language"
	desc = "A mixture of manual communication and body-languaged, used to communication with those who have impaired hearing."
	speech_verb = "signs"
	signlang_verb = list("signs")
	key = "4"
	flags = SIGNLANG
	cost = 2

/datum/language/common
	name = "Anglic"
	desc = "A language based on the human trade language English, with heavy influences from romance and germanic languages."
	speech_verb = "says"
	whisper_verb = "whispers"
	key = "0"
	flags = RESTRICTED
	syllables = list("blah","blah","blah","bleh","meh","neh","nah","wah")

//TODO flag certain languages to use the mob-type specific say_quote and then get rid of these.
/datum/language/common/get_spoken_verb(var/msg_end)
	switch(msg_end)
		if("!")
			return pick("exclaims","shouts","yells") //TODO: make the basic proc handle lists of verbs.
		if("?")
			return ask_verb
	return speech_verb


//Human Native Languages

/datum/language/zho
	name = "Zho"
	desc = "A melodic language based on Mandarin Chinese; Native to humanity."
	speech_verb = "says"
	whisper_verb = "whispers"
	colour = "solcom2"
	key = "1"
	cost = 3
	syllables = list("tao","shi","tzu","yi","com","be","is","i","op","vi","ed","lec","mo","cle","te","dis","e")

/datum/language/zho/get_spoken_verb(var/msg_end)
	switch(msg_end)
		if("!")
			return pick("exclaims","shouts","yells") //TODO: make the basic proc handle lists of verbs.
		if("?")
			return ask_verb
	return speech_verb

/datum/language/ara
	name = "Ara"
	desc = "A language based on Arabic; Native to humanity."
	speech_verb = "says"
	whisper_verb = "whispers"
	colour = "solcom"
	key = "8"
	cost = 3
	syllables = list("tao","shi","tzu","yi","com","be","is","i","op","vi","ed","lec","mo","cle","te","dis","e")

/datum/language/ara/get_spoken_verb(var/msg_end)
	switch(msg_end)
		if("!")
			return pick("exclaims","shouts","yells") //TODO: make the basic proc handle lists of verbs.
		if("?")
			return ask_verb
	return speech_verb

/datum/language/hindi
	name = "Hindi"
	desc = "A language based on traditional Hini; Native to humanity."
	speech_verb = "says"
	whisper_verb = "whispers"
	colour = "solcom"
	key = "9"
	cost = 3
	syllables = list("tao","shi","tzu","yi","com","be","is","i","op","vi","ed","lec","mo","cle","te","dis","e")

/datum/language/hindi/get_spoken_verb(var/msg_end)
	switch(msg_end)
		if("!")
			return pick("exclaims","shouts","yells") //TODO: make the basic proc handle lists of verbs.
		if("?")
			return ask_verb
	return speech_verb


//Vox - All vox speak vox-pidgin, nobody else can. They are speshul


/datum/language/vox
	name = "Vox-pidgin"
	desc = "The common tongue of the various Vox ships making up the Shoal. It sounds like chaotic shrieking to everyone else."
	speech_verb = "shrieks"
	ask_verb = "creels"
	exclaim_verb = "SHRIEKS"
	colour = "vox"
	key = "v"
	flags = WHITELISTED
	syllables = list("ti","ti","ti","hi","hi","ki","ki","ki","ki","ya","ta","ha","ka","ya","chi","cha","kah", \
	"SKRE","AHK","EHK","RAWK","KRA","AAA","EEE","KI","II","KRI","KA")

/datum/language/vox/get_random_name()
	return ..(FEMALE,1,6)

//PLANTMENS - Nobody gets this but the plants. They are speshul

/datum/language/diona
	name = "Rootspeak"
	desc = "A creaking, subvocal language spoken instinctively by the Dionaea. Due to the unique makeup of the average Diona, a phrase of Rootspeak can be a combination of anywhere from one to twelve individual voices and notes."
	speech_verb = "creaks and rustles"
	ask_verb = "creaks"
	exclaim_verb = "rustles"
	colour = "soghun"
	key = "q"
	flags = RESTRICTED
	syllables = list("hs","zt","kr","st","sh")

/datum/language/diona/get_random_name()
	var/new_name = "[pick(list("To Sleep Beneath","Wind Over","Embrace of","Dreams of","Witnessing","To Walk Beneath","Approaching the"))]"
	new_name += " [pick(list("the Void","the Sky","Encroaching Night","Planetsong","Starsong","the Wandering Star","the Empty Day","Daybreak","Nightfall","the Rain"))]"
	return new_name

//Xenos and other restricted languages

/datum/language/xenocommon
	name = "Xenomorph"
	colour = "alien"
	desc = "The common tongue of the xenomorphs."
	speech_verb = "hisses"
	ask_verb = "hisses"
	exclaim_verb = "hisses"
	key = "5"
	flags = RESTRICTED
	syllables = list("sss","sSs","SSS")

/datum/language/xenos
	name = "Hivemind"
	desc = "Xenomorphs have the strange ability to commune over a psychic hivemind."
	speech_verb = "hisses"
	ask_verb = "hisses"
	exclaim_verb = "hisses"
	colour = "alien"
	key = "a"
	flags = RESTRICTED | HIVEMIND

/datum/language/xenos/check_special_condition(var/mob/other)

	var/mob/living/carbon/M = other
	if(!istype(M))
		return 1
	if(locate(/datum/organ/internal/xenos/hivenode) in M.internal_organs)
		return 1

	return 0

/datum/language/ling
	name = "Changeling"
	desc = "Although they are normally wary and suspicious of each other, changelings can commune over a distance."
	speech_verb = "says"
	colour = "changeling"
	key = "g"
	flags = RESTRICTED | HIVEMIND

/datum/language/ling/broadcast(var/mob/living/speaker,var/message,var/speaker_mask)

	if(speaker.mind && speaker.mind.changeling)
		..(speaker,message,speaker.mind.changeling.changelingID)
	else
		..(speaker,message)

/datum/language/corticalborer
	name = "Cortical Link"
	desc = "Cortical borers possess a strange link between their tiny minds."
	speech_verb = "sings"
	ask_verb = "sings"
	exclaim_verb = "sings"
	colour = "alien"
	key = "x"
	flags = RESTRICTED | HIVEMIND

/datum/language/corticalborer/broadcast(var/mob/living/speaker,var/message,var/speaker_mask)

	var/mob/living/simple_animal/borer/B

	if(istype(speaker,/mob/living/carbon))
		var/mob/living/carbon/M = speaker
		B = M.has_brain_worms()
	else if(istype(speaker,/mob/living/simple_animal/borer))
		B = speaker

	if(B)
		speaker_mask = B.truename
	..(speaker,message,speaker_mask)

/datum/language/binary
	name = "Robot Talk"
	desc = "Most human stations support free-use communications protocols and routing hubs for synthetic use."
	colour = "say_quote"
	speech_verb = "states"
	ask_verb = "queries"
	exclaim_verb = "declares"
	key = "b"
	flags = RESTRICTED | HIVEMIND
	var/drone_only

/datum/language/binary/broadcast(var/mob/living/speaker,var/message,var/speaker_mask)

	if(!speaker.binarycheck())
		return

	if (!message)
		return

	var/message_start = "<i><span class='game say'>[name], <span class='name'>[speaker.name]</span>"
	var/message_body = "<span class='message'>[speaker.say_quote(message)], \"[message]\"</span></span></i>"

	for (var/mob/M in dead_mob_list)
		if(!istype(M,/mob/new_player) && !istype(M,/mob/living/carbon/brain)) //No meta-evesdropping
			M.show_message("[message_start] [message_body]", 2)

	for (var/mob/living/S in living_mob_list)

		if(drone_only && !istype(S,/mob/living/silicon/robot/drone))
			continue
		else if(istype(S , /mob/living/silicon/ai))
			message_start = "<i><span class='game say'>[name], <a href='byond://?src=\ref[S];track2=\ref[S];track=\ref[speaker];trackname=[html_encode(speaker.name)]'><span class='name'>[speaker.name]</span></a>"
		else if (!S.binarycheck())
			continue

		S.show_message("[message_start] [message_body]", 2)

	var/list/listening = hearers(1, src)
	listening -= src

	for (var/mob/living/M in listening)
		if(istype(M, /mob/living/silicon) || M.binarycheck())
			continue
		M.show_message("<i><span class='game say'><span class='name'>synthesised voice</span> <span class='message'>beeps, \"beep beep beep\"</span></span></i>",2)

	//robot binary xmitter component power usage
//	if (isrobot(speaker))
//		var/mob/living/silicon/robot/R = speaker
//		var/datum/robot_component/C = R.components["comms"]
//		R.cell_use_power(C.active_usage)

/datum/language/binary/drone
	name = "Drone Talk"
	desc = "A heavily encoded damage control coordination stream."
	speech_verb = "transmits"
	ask_verb = "transmits"
	exclaim_verb = "transmits"
	colour = "say_quote"
	key = "d"
	flags = RESTRICTED | HIVEMIND
	drone_only = 1

// Language handling.
/mob/proc/add_language(var/language)

	var/datum/language/new_language = all_languages[language]

	if(!istype(new_language) || new_language in languages)
		return 0

	languages.Add(new_language)
	return 1

/mob/proc/remove_language(var/rem_language)
	var/datum/language/L = all_languages[rem_language]
	. = (L in languages)
	languages.Remove(L)

// Can we speak this language, as opposed to just understanding it?
/mob/proc/can_speak(datum/language/speaking)

	return (universal_speak || (speaking && speaking.flags & INNATE) || speaking in src.languages)

//TBD
/mob/verb/check_languages()
	set name = "Check Known Languages"
	set category = "IC"
	set src = usr

	var/dat = "<b><font size = 5>Known Languages</font></b><br/><br/>"

	for(var/datum/language/L in languages)
		if(!(L.flags & NONGLOBAL))
			dat += "<b>[L.name] (:[L.key])</b><br/>[L.desc]<br/><br/>"

	src << browse(dat, "window=checklanguage")
	return

#undef SCRAMBLE_CACHE_LEN
