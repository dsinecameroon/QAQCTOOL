# Vital signs
updateRadioButtons(session, "lifesigns", selected = df$lifesigns)
updateRadioButtons(session, "respirationassist", selected = df$respirationassist)
updateRadioButtons(session, "cpr", selected = df$cpr)
updateRadioButtons(session, "vitalstaken", selected = df$vitalstaken)
updateRadioButtons(session, "vitalsnottaken", selected = df$vitalsnottaken)
updateNumericInput(session, "vitalstakenamount", value = df$vitalstakenamount)

# Vitals–1
updateTextInput(session, "vitals1_sbp", value = df$vitals1_sbp)
updateTextInput(session, "vitals1_dbp", value = df$vitals1_dbp)
updateTextInput(session, "vitals1_hr", value = df$vitals1_hr)
updateTextInput(session, "vitals1_rr", value = df$vitals1_rr)
updateTextInput(session, "vitals1_tcelcius", value = df$vitals1_tcelcius)
updateTextInput(session, "vitals1_o2", value = df$vitals1_o2sat)
updateTextInput(session, "vitals1_time", value = df$vitals1_time)

# Vitals–2
updateTextInput(session, "vitals2_sbp", value = df$vitals2_sbp)
updateTextInput(session, "vitals2_dbp", value = df$vitals2_dbp)
updateTextInput(session, "vitals2_hr", value = df$vitals2_hr)
updateTextInput(session, "vitals2_rr", value = df$vitals2_rr)
updateTextInput(session, "vitals2_tcelcius", value = df$vitals2_tcelcius)
updateTextInput(session, "vitals2_o2", value = df$vitals2_o2sat)
updateTextInput(session, "vitals2_time", value = df$vitals2_time)

# Vitals–3
updateTextInput(session, "vitals3_sbp", value = df$vitals3_sbp)
updateTextInput(session, "vitals3_dbp", value = df$vitals3_dbp)
updateTextInput(session, "vitals3_hr", value = df$vitals3_hr)
updateTextInput(session, "vitals3_rr", value = df$vitals3_rr)
updateTextInput(session, "vitals3_tcelcius", value = df$vitals3_tcelcius)
updateTextInput(session, "vitals3_o2", value = df$vitals3_o2sat)
updateTextInput(session, "vitals3_time", value = df$vitals3_time)



# Airway / Respiration
updateRadioButtons(session, "airway", selected = df$airway)
updateRadioButtons(session, "a_intervention", selected = df$a_intervention)
updateRadioButtons(session, "respirations", selected = df$respirations)
updateRadioButtons(session, "chestrise", selected = df$chestrise)
updateRadioButtons(session, "trachealdeviation", selected = df$trachealdeviation)
updateRadioButtons(session, "b_intervention", selected = df$b_intervention)
updateRadioButtons(session, "breath", selected = df$breath)
updateRadioButtons(session, "access", selected = df$access)
# Palpable Pulse
updateRadioButtons(session, "palpablepulse", selected = df$palpablepulse)
# External Bleeding
updateRadioButtons(session, "externalbleeding", selected = df$externalbleeding)
# FAST
updateRadioButtons(session, "fast", selected = df$fast)
# Diagnostic Peritoneal Lavage
updateRadioButtons(session, "peritoneallavage", selected = df$peritoneallavage)
# Circulation Intervention (checkbox group)
updateCheckboxGroupInput(session, "c_intervention", selected = df$c_intervention)
# Circulation Times
updateTextInput(session, "c_time1", value = df$c_time1)
updateTextInput(session, "c_time2", value = df$c_time2)
updateTextInput(session, "c_time3", value = df$c_time3)


# Pupils / GCS
updateRadioButtons(session, "pupils", selected = df$pupils)
updateRadioButtons(session, "ccollar", selected = df$ccollar)
updateRadioButtons(session, "gcs_eyes", selected = df$gcs_eyes)
updateRadioButtons(session, "gcs_verbal", selected = df$gcs_verbal)
updateRadioButtons(session, "gcs_motor", selected = df$gcs_motor)
updateRadioButtons(session, "gcs_qualifier", selected = df$gcs_qualifier)
updateRadioButtons(session, "gsc_missing", selected = df$gsc_missing)


# Patient exam
updateRadioButtons(session, "patientdisrobe", selected = df$patientdisrobe)
updateRadioButtons(session, "tempcontrol", selected = df$tempcontrol)

# Update HEAIS numeric inputs based on dataframe values
updateNumericInput(session, "gen_heais", value = df$gen_heais)
updateNumericInput(session, "face_heais", value = df$face_heais)
updateNumericInput(session, "hncs_heais", value = df$hncs_heais)
updateNumericInput(session, "chestts_heais", value = df$chestts_heais)
updateNumericInput(session, "abpells_heais", value = df$abpells_heais)
updateNumericInput(session, "ex_heais", value = df$ex_heais)



# Injury matrix (example for bruise/abrasion head/neck)
source("field_update.R", local = TRUE)
