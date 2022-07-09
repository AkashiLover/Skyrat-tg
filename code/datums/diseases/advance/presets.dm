// Cold
/datum/disease/advance/cold
	copy_type = /datum/disease/advance

/datum/disease/advance/cold/New()
	name = "Cold"
	symptoms = list(new/datum/symptom/sneeze)
	..()

// Flu
/datum/disease/advance/flu
	copy_type = /datum/disease/advance

/datum/disease/advance/flu/New()
	name = "Flu"
	symptoms = list(new/datum/symptom/cough)
	..()

//Randomly generated Disease, for virus crates and events
/datum/disease/advance/random
	name = "Experimental Disease"
	copy_type = /datum/disease/advance
	// SKYRAT EDIT ADDITION START - Less annoying miasma
	/// Does this virus come from miasma? Defaults to FALSE, will fail to infect anyone that has already caught a miasma virus before.
	var/from_miasma = FALSE
	// SKYRAT EDIT END

/datum/disease/advance/random/New(max_symptoms, max_level = 8, caused_by_miasma = FALSE) // SKYRAT EDIT - Less annoying miasma - ORIGINAL: /datum/disease/advance/random/New(max_symptoms, max_level = 8)
	if(!max_symptoms)
		max_symptoms = rand(1, VIRUS_SYMPTOM_LIMIT)
	var/list/datum/symptom/possible_symptoms = list()
	for(var/symptom in subtypesof(/datum/symptom))
		var/datum/symptom/S = symptom
		if(initial(S.level) > max_level)
			continue
		if(initial(S.level) <= 0) //unobtainable symptoms
			continue
		possible_symptoms += S
	for(var/i in 1 to max_symptoms)
		var/datum/symptom/chosen_symptom = pick_n_take(possible_symptoms)
		if(chosen_symptom)
			var/datum/symptom/S = new chosen_symptom
			symptoms += S
	from_miasma = caused_by_miasma
	Refresh()

	name = "Sample #[rand(1,10000)]"
