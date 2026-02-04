## Transfer Reasons
updateTextInput(session, "patientname", value = df$patientname)
updateTextInput(session, "patient_ctr_id", value = df$patient_ctr_id)
updateTextInput(session, "site_id", value = df$site_id)
updateTextInput(session, "phonenumber", value = df$phonenumber)
updateTextInput(session, "phonenumber_2", value = df$phonenumber_2)
updateDateInput(session, "arrivaldate", value = df$arrivaldate)
updateTextInput(session, "arrivaltime", value = df$arrivaltime)

### Demographic section
# Transfer
updateRadioButtons(session, "transfer", selected = df$transfer)
# Transfer reason (checkbox group)
updateCheckboxGroupInput(session, "transferreason", selected = df$transferreason)
# Age
updateNumericInput(session, "age", value = df$age)
# Sex
updateRadioButtons(session, "sex", selected = df$sex)
# Marital status
updateRadioButtons(session, "marital_status", selected = df$marital_status)
# Education
updateRadioButtons(session, "education", selected = df$education)
# Education complete
updateRadioButtons(session, "education_complete", selected = df$education_complete)
# Occupation
updateRadioButtons(session, "occupation", selected = df$occupation)
# Household type (urban)
updateRadioButtons(session, "urban", selected = df$urban)
# Cellphone
updateRadioButtons(session, "cellphone", selected = df$cellphone)
# Television
updateRadioButtons(session, "tv", selected = df$tv)
# Cable
updateRadioButtons(session, "cable", selected = df$cable)
# Mixer
updateRadioButtons(session, "mixer", selected = df$mixer)
# Cooking fuel
updateRadioButtons(session, "fuel", selected = df$cooking_fuel)
# Medical history (multi)
updateCheckboxGroupInput(session, "medicalhx", selected = df$medicalhx)
# Chronic illnesses (multi)
updateCheckboxGroupInput(session, "medicalhx_chronic", selected = df$medicalhx_chronic)
# Pregnant
updateRadioButtons(session, "pregnant", selected = df$pregnant)
# Prior injury
updateRadioButtons(session, "prior_injury", selected = df$prior_injury)
# Violence-related
updateRadioButtons(session, "prior_injury_violence", selected = df$prior_injury_violence)
# Alcohol use
updateRadioButtons(session, "alcoholuse", selected = df$alcoholuse)
# Tobacco use
updateRadioButtons(session, "tobaccouse", selected = df$tobaccouse)
# PHQ Depression
updateRadioButtons(session, "phq_depression", selected = df$phq_depression)
updateRadioButtons(session, "phq_depression_2", selected = df$phq_depression_2)
# Tetanus
updateRadioButtons(session, "tetanus", selected = df$tetanus)
# Tetanus wound
updateRadioButtons(session, "tetanus_wound", selected = df$tetanus_wound)
# Contnent provider
updateRadioButtons(session, "consentprovider", selected = df$consentprovider)
