# ---- Context of Injury ----
updateTextInput(session, "injurydate", value = df$injurydate)
updateTextInput(session, "injurytime", value = df$injurytime)
#updateTextInput(session, "injury_health_area", value = "")
updateTextInput(session, "traveldistance", value = df$traveldistance)

updateTextInput(session, "injurytown", value = df$injurytown)
#updateTextInput(session, "injury_district", value = df$injury_district)
updateTextInput(session, "injury_neighborhood", value = df$injury_neighborhood)
updateTextInput(session, "injuryregion", value = df$injuryregion)   # mapped to injuryregion

# ---- Injury Place and Activity ----
updateCheckboxGroupInput(session, "i_loc", selected = df$i_loc)   # mapped to i_loc
updateRadioButtons(session, "i_activity", selected = df$i_activity) # mapped to i_activity
updateRadioButtons(session, "i_alcohol_patient", selected = df$i_alcohol_patient) # mapped
updateRadioButtons(session, "i_alcohol_perpretrator", selected = df$i_alcohol_perpretrator) # mapped

# ---- Mechanism ----
updateCheckboxGroupInput(session, "i_mechanism", selected = df$i_mechanism) # mapped

# ---- Safety Equipment ----
updateRadioButtons(session, "i_rtirole_patient", selected = df$i_rtirole_patient)  # mapped
updateRadioButtons(session, "i_seatbelt", selected = df$i_seatbelt)         # mapped
updateRadioButtons(session, "i_carseat", selected = df$i_carseat)           # mapped
updateRadioButtons(session, "i_helmet", selected = df$i_helmet)             # mapped
updateRadioButtons(session, "i_airbag", selected = df$i_airbag)             # mapped

# ---- Intent and Counterpart ----
updateRadioButtons(session, "i_counterpart", selected = df$i_counterpart)    # mapped
updateRadioButtons(session, "i_intent", selected = df$i_intent)                   # mapped
updateRadioButtons(session, "i_intentperp", selected = df$i_intentperp)          # mapped
updateCheckboxGroupInput(session, "i_intentcontext", selected = df$i_intentcontext) # mapped

# ---- Pre-Hospital Care ----
updateRadioButtons(session, "scenecare", selected = df$scenecare)              # mapped
updateCheckboxGroupInput(session, "transport", selected = df$transport)         # mapped
updateCheckboxGroupInput(session, "scenecaregiven", selected = df$scenecaregiven)   # mapped
updateCheckboxGroupInput(session, "careprovider", selected = df$careprovider)  # mapped

# ---- Prior Care ----
updateRadioButtons(session, "priorcare", selected = df$priorcare)            # mapped
updateCheckboxGroupInput(session, "priorcareloc", selected = df$priorcareloc)     # mapped

# ---- Injury Severity ----
updateCheckboxGroupInput(session, "severity_ind", selected = df$severity_ind) # mapped
