
var/const/ENGSEC			=(1<<0)

var/const/CAPTAIN			=(1<<0)
var/const/HOS				=(1<<1)
var/const/WARDEN			=(1<<2)
var/const/DETECTIVE			=(1<<3)
var/const/OFFICER			=(1<<4)
var/const/CHIEF				=(1<<5)
var/const/ENGINEER			=(1<<6)
var/const/ATMOSTECH			=(1<<7)
var/const/JANITOR			=(1<<8)
var/const/AI				=(1<<9)
var/const/CYBORG			=(1<<10)
var/const/INTERN_SEC		=(1<<11)
var/const/INTERN_ENG		=(1<<12)


var/const/MEDSCI			=(1<<1)

var/const/RD				=(1<<0)
var/const/SCIENTIST			=(1<<1)
var/const/CHEMIST			=(1<<2)
var/const/CMO				=(1<<3)
var/const/DOCTOR			=(1<<4)
var/const/EMT				=(1<<5)
var/const/GENETICIST		=(1<<6)
var/const/VIROLOGIST		=(1<<7)
var/const/PSYCHIATRIST		=(1<<8)
var/const/ROBOTICIST		=(1<<9)
var/const/XENOBIOLOGIST		=(1<<10)
var/const/FORENSICS			=(1<<11)
var/const/INTERN_MED		=(1<<12)
var/const/INTERN_SCI		=(1<<13)



var/const/CIVILIAN			=(1<<2)

var/const/HOP				=(1<<0)
var/const/BARTENDER			=(1<<1)
var/const/BOTANIST			=(1<<2)
var/const/CHEF				=(1<<3)
var/const/LIBRARIAN			=(1<<4)
var/const/QUARTERMASTER		=(1<<5)
var/const/CARGOTECH			=(1<<6)
var/const/MINER				=(1<<7)
var/const/LAWYER			=(1<<8)
var/const/CHAPLAIN			=(1<<9)
var/const/CLOWN				=(1<<10)
var/const/MIME				=(1<<11)
var/const/ASSISTANT			=(1<<12)


var/list/assistant_occupations = list(
)


var/list/command_positions = list(
	"Captain",
	"Executive Officer",
	"Commander",
	"Chief Engineer",
	"Research Director",
	"Chief Medical Officer"
)


var/list/engineering_positions = list(
	"Chief Engineer",
	"Station Engineer",
	"Atmospheric Technician",
	"Sanitation Engineer",
	"Engineering Apprentice"
)


var/list/medical_positions = list(
	"Chief Medical Officer",
	"Medical Doctor",
	"Geneticist",
	"Psychiatrist",
	"Chemist",
	"Emergency Medical Tech",
	"Nursing Intern"
)


var/list/science_positions = list(
	"Research Director",
	"Scientist",
	"Geneticist",	//Part of both medical and science
	"Roboticist",
	"Xenobiologist",
	"Forensic Technician",
	"Lab Assistant"
)

//BS12 EDIT
var/list/civilian_positions = list(
	"Executive Officer",
	"Bartender",
	"Botanist",
	"Chef",
	"Librarian",
	"Quartermaster",
	"Cargo Technician",
	"Shaft Miner",
	"Lawyer",
	"Chaplain",
	"Intern",
	"Assistant"
)


var/list/security_positions = list(
	"Commander",
	"Chief Petty Officer",
	"Marshal",
	"Espatier",
	"Security Cadet"
)


var/list/nonhuman_positions = list(
	"AI",
	"Cyborg",
	"pAI"
)


/proc/guest_jobbans(var/job)
	return ((job in command_positions))

/proc/get_job_datums()
	var/list/occupations = list()
	var/list/all_jobs = typesof(/datum/job)

	for(var/A in all_jobs)
		var/datum/job/job = new A()
		if(!job)	continue
		occupations += job

	return occupations

/proc/get_alternate_titles(var/job)
	var/list/jobs = get_job_datums()
	var/list/titles = list()

	for(var/datum/job/J in jobs)
		if(!J)	continue
		if(J.title == job)
			titles = J.alt_titles

	return titles

