/*
*This file contains the unity slipspace drive
*This drive contains two major components: The containment field objects, and the core.
*Containment fields provide a ceiling for how much power the core can provide
*While the core itself is limited in production by its quality.
*Drive machinery draw power from the grid to function. This increases when the drive is in operation
*/

/obj/machinery/drive
	icon = 'icons/obj/drive.dmi'

/obj/machinery/computer/drive
	icon = 'icons/obj/computer.dmi'
	icon_state = "comm_monitor"
	name = "Slipspace Core Monitor"
	desc = "This console monitors and controls the parts of the slipspace drive!"

/obj/machinery/drive/containment
	icon_state = "containment"
	name = "Containment Field"
	desc = "This device produces a field that protects the core from overloading."
	
/obj/machinery/drive/core
	icon_state = "core"
	name = "Slipspace Core"
	desc = "This device allows the ship to travel into slipspace for short periods of time"
