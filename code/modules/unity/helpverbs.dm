/mob/verb/help_server()
	set name = "About Unity"
	set category = "Help"
	set src = usr

	var/dat
	dat = {"
		<html><head>
		</head>
		<body>
		<iframe width='100%' height='97%' src="ADDRESS HERE" frameborder="0" id="main_frame"></iframe>
		</body>

		</html>

		"}

	src << browse(dat, "window=about")
	return

/mob/verb/help_rules()
	set name = "Server Rules"
	set category = "Help"
	set src = usr

	var/dat
	dat = {"
		<html><head>
		</head>
		<body>
		<iframe width='100%' height='97%' src="ADDRESS HERE" frameborder="0" id="main_frame"></iframe>
		</body>

		</html>

		"}

	src << browse(dat, "window=about")
	return

/mob/verb/help_regulations()
	set name = "Ship Regulations"
	set category = "Help"
	set src = usr

	var/dat
	dat = {"
		<html><head>
		</head>
		<body>
		<iframe width='100%' height='97%' src="ADDRESS HERE" frameborder="0" id="main_frame"></iframe>
		</body>

		</html>

		"}

	src << browse(dat, "window=about")
	return

/mob/verb/help_setting()
	set name = "About Setting"
	set category = "Help"
	set src = usr

	var/dat
	dat = {"
		<html><head>
		</head>
		<body>
		<iframe width='100%' height='97%' src="ADDRESS HERE" frameborder="0" id="main_frame"></iframe>
		</body>

		</html>

		"}

	src << browse(dat, "window=about")
	return

/mob/verb/help_aliens()
	set name = "About Aliens"
	set category = "Help"
	set src = usr

	var/dat
	dat = {"
		<html><head>
		</head>
		<body>
		<iframe width='100%' height='97%' src="ADDRESS HERE" frameborder="0" id="main_frame"></iframe>
		</body>

		</html>

		"}

	src << browse(dat, "window=about")
	return

/mob/verb/help_bionics()
	set name = "About Augments"
	set category = "Help"
	set src = usr

	var/dat
	dat = {"
		<html><head>
		</head>
		<body>
		<iframe width='100%' height='97%' src="ADDRESS HERE" frameborder="0" id="main_frame"></iframe>
		</body>

		</html>

		"}

	src << browse(dat, "window=about")
	return

/mob/verb/help_languages()
	set name = "About Languages"
	set category = "Help"
	set src = usr

	var/dat
	dat = {"
		<html><head>
		</head>
		<body>
		<iframe width='100%' height='97%' src="ADDRESS HERE" frameborder="0" id="main_frame"></iframe>
		</body>

		</html>

		"}

	src << browse(dat, "window=about")
	return
	

	
/mob/living/carbon/human/verb/hold_breath()
	set category = "IC"
	set name = "Hold Breath"
	set desc = "Hold your breath. Use again to start breathing."
	
	holdbreath = !holdbreath
	if(holdbreath)
		src <<  "You start holding your breath."
	else
		src << "You start breathing normally."
	
