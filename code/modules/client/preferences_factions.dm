var/global/list/seen_citizenships = list()
var/global/list/seen_systems = list()
var/global/list/seen_factions = list()
var/global/list/seen_religions = list()

//Commenting this out for now until I work the lists it into the event generator/journalist/chaplain.
/proc/UpdateFactionList(mob/living/carbon/human/M)
	/*if(M && M.client && M.client.prefs)
		seen_citizenships |= M.client.prefs.citizenship
		seen_systems      |= M.client.prefs.home_system
		seen_factions     |= M.client.prefs.faction
		seen_religions    |= M.client.prefs.religion*/
	return

var/global/list/citizenship_choices = list(
	"United Terran States",
	"Eastern People's Republic",
	"Venusian Combine",
	"Europan Combine",
	"Eurasian Union",
	"Combined Pekhota Forces",
	"Paharan League",
	"Moghes Hegemony",
	"Skrellian Confederacy",
	"None",
	"Other"
	)

var/global/list/home_system_choices = list(
	"Sol",
	"Tau Ceti",
	"Pahra",
	"Moghes",
	"Other"
	)

var/global/list/faction_choices = list(
	"United Stellar Nations",
	"Vey Med",
	"Einstein Engines",
	"Free Trade Union",
	"Ward-Takahashi GMB",
	"Gilthari Exports",
	"Grayson Manufactories Ltd.",
	"Aether Atmospherics",
	"Zeng-Hu Pharmaceuticals",
	"Hesphaistos Industries"
	)

var/global/list/religion_choices = list(
	"Hinduism",
	"Buddhism",
	"Islam",
	"Christian",
	"Agnostic",
	"Deist",
	"Spiritualist",
	"None",
	"Other"
	)
