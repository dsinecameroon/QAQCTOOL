# ----- Xray Scan ---
source("ctr_page_4_radio.R", local = TRUE)

# ---- Consultation ----
# General / Visceral Surgery
updateRadioButtons(session, "consult_gensurg___recom_yes", selected = df$consult_gensurg___recom_yes)
updateRadioButtons(session, "consult_gensurg___recom_no", selected = df$consult_gensurg___recom_no)
updateRadioButtons(session, "consult_gensurg___called_yes", selected = df$consult_gensurg___called_yes)
updateRadioButtons(session, "consult_gensurg___called_no", selected = df$consult_gensurg___called_no)
updateRadioButtons(session, "consult_gensurg___arrived_yes", selected = df$consult_gensurg___arrived_yes)
updateRadioButtons(session, "consult_gensurg___arrived_no", selected = df$consult_gensurg___arrived_no)
updateTextInput(session, "consult_gensurgcalled_date", value = df$consult_gensurgcalled_date)
updateTextInput(session, "consult_gensurgarrived_date", value = df$consult_gensurgarrived_date)
updateTextInput(session, "consult_gensurgcalled", value = df$consult_gensurgcalled)
updateTextInput(session, "consult_gensurgarrived", value = df$consult_gensurgarrived)

# Orthopedic/Trauma Surgery
updateRadioButtons(session, "consult_ortho___recom_yes", selected = df$consult_ortho___recom_yes)
updateRadioButtons(session, "consult_ortho___recom_no", selected = df$consult_ortho___recom_no)
updateRadioButtons(session, "consult_ortho___called_yes", selected = df$consult_ortho___called_yes)
updateRadioButtons(session, "consult_ortho___called_no", selected = df$consult_ortho___called_no)
updateRadioButtons(session, "consult_ortho___arrived_yes", selected = df$consult_ortho___arrived_yes)
updateRadioButtons(session, "consult_ortho___arrived_no", selected = df$consult_ortho___arrived_no)
#updateTextInput(session, "consult_orthotime", value = df$consult_orthotime)
updateTextInput(session, "consult_orthocalled_date", value = df$consult_orthocalled_date)
updateTextInput(session, "consult_orthoarrived_date", value = df$consult_orthoarrived_date)
updateTextInput(session, "consult_orthocalled", value = df$consult_orthocalled)
updateTextInput(session, "consult_orthoarrived", value = df$consult_orthoarrived)

# Neurosurgery
updateRadioButtons(session, "consult_neuro___recom_yes", selected = df$consult_neuro___recom_yes)
updateRadioButtons(session, "consult_neuro___recom_no", selected = df$consult_neuro___recom_no)
updateRadioButtons(session, "consult_neuro___called_yes", selected = df$consult_neuro___called_yes)
updateRadioButtons(session, "consult_neuro___called_no", selected = df$consult_neuro___called_no)
updateRadioButtons(session, "consult_neuro___arrived_yes", selected = df$consult_neuro___arrived_yes)
updateRadioButtons(session, "consult_neuro___arrived_no", selected = df$consult_neuro___arrived_no)
updateTextInput(session, "consult_neurocalled_date", value = df$consult_neurocalled_date)
updateTextInput(session, "consult_neuroarrived_date", value = df$consult_neuroarrived_date)
updateTextInput(session, "consult_neurocalled", value = df$consult_neurocalled)
updateTextInput(session, "consult_neuroarrived", value = df$consult_neuroarrived)

# Vascular
updateRadioButtons(session, "consult_vasc___recom_yes", selected = df$consult_vasc___recom_yes)
updateRadioButtons(session, "consult_vasc___recom_no", selected = df$consult_vasc___recom_no)
updateRadioButtons(session, "consult_vasc___called_yes", selected = df$consult_vasc___called_yes)
updateRadioButtons(session, "consult_vasc___called_no", selected = df$consult_vasc___called_no)
updateRadioButtons(session, "consult_vasc___arrived_yes", selected = df$consult_vasc___arrived_yes)
updateRadioButtons(session, "consult_vasc___arrived_no", selected = df$consult_vasc___arrived_no)
updateTextInput(session, "consult_vasctime", value = df$consult_vasctime)
updateTextInput(session, "consult_vasccalled_date", value = df$consult_vasccalled_date)
updateTextInput(session, "consult_vascarrived_date", value = df$consult_vascarrived_date)
updateTextInput(session, "consult_vasccalled", value = df$consult_vasccalled)
updateTextInput(session, "consult_vascarrived", value = df$consult_vascarrived)

# Ent
updateRadioButtons(session, "consult_ent___recom_yes", selected = df$consult_ent___recom_yes)
updateRadioButtons(session, "consult_ent___recom_no", selected = df$consult_ent___recom_no)
updateRadioButtons(session, "consult_ent___called_yes", selected = df$consult_ent___called_yes)
updateRadioButtons(session, "consult_ent___called_no", selected = df$consult_ent___called_no)
updateRadioButtons(session, "consult_ent___arrived_yes", selected = df$consult_ent___arrived_yes)
updateRadioButtons(session, "consult_ent___arrived_no", selected = df$consult_ent___arrived_no)
updateTextInput(session, "consult_entcalled_date", value = df$consult_entcalled_date)
updateTextInput(session, "consult_entarrived_date", value = df$consult_entarrived_date)
updateTextInput(session, "consult_entcalled", value = df$consult_entcalled)
updateTextInput(session, "consult_entarrived", value = df$consult_entarrived)

# Plastic Surgery
updateRadioButtons(session, "consult_plastic___recom_yes", selected = df$consult_plastic___recom_yes)
updateRadioButtons(session, "consult_plastic___recom_no", selected = df$consult_plastic___recom_no)
updateRadioButtons(session, "consult_plastic___called_yes", selected = df$consult_plastic___called_yes)
updateRadioButtons(session, "consult_plastic___called_no", selected = df$consult_plastic___called_no)
updateRadioButtons(session, "consult_plastic___arrived_yes", selected = df$consult_plastic___arrived_yes)
updateRadioButtons(session, "consult_plastic___arrived_no", selected = df$consult_plastic___arrived_no)
updateTextInput(session, "consult_plasticcalled_date", value = df$consult_plasticcalled_date)
updateTextInput(session, "consult_plasticarrived_date", value = df$consult_plasticarrived_date)
updateTextInput(session, "consult_plasticcalled", value = df$consult_plasticcalled)
updateTextInput(session, "consult_plasticarrived", value = df$consult_plasticarrived)


# Other specialist (Specify):
updateRadioButtons(session, "consult_other___recom_yes", selected = df$consult_other___recom_yes)
updateRadioButtons(session, "consult_other___recom_no", selected = df$consult_other___recom_no)
updateRadioButtons(session, "consult_other___called_yes", selected = df$consult_other___called_yes)
updateRadioButtons(session, "consult_other___called_no", selected = df$consult_other___called_no)
updateRadioButtons(session, "consult_other___arrived_yes", selected = df$consult_other___arrived_yes)
updateRadioButtons(session, "consult_other___arrived_no", selected = df$consult_other___arrived_no)
updateTextInput(session, "consult_othertime", value = df$consult_othertime)
updateTextInput(session, "consult_othercalled_date", value = df$consult_othercalled_date)
updateTextInput(session, "consult_otherarrived_date", value = df$consult_otherarrived_date)
updateTextInput(session, "consult_othercalled", value = df$consult_othercalled)
updateTextInput(session, "consult_otherarrived", value = df$consult_otherarrived)


### Medications
# Analgesic
updateRadioButtons(session, "treat_analgesic___recom_yes", selected = df$treat_analgesic___recom_yes)
updateRadioButtons(session, "treat_analgesic___recom_no", selected = df$treat_analgesic___recom_no)
updateRadioButtons(session, "treat_analgesic___received_yes", selected = df$treat_analgesic___received_yes)
updateRadioButtons(session, "treat_analgesic___received_no", selected = df$treat_analgesic___received_no)
updateTextInput(session, "treat_analgesictime", value = df$treat_analgesictime)

# Anticoagulant
updateRadioButtons(session, "treat_anticoagulant___recom_yes", selected = df$treat_anticoagulant___recom_yes)
updateRadioButtons(session, "treat_anticoagulant___recom_no", selected = df$treat_anticoagulant___recom_no)
updateRadioButtons(session, "treat_anticoagulant___received_yes", selected = df$treat_anticoagulant___received_yes)
updateRadioButtons(session, "treat_anticoagulant___received_no", selected = df$treat_anticoagulant___received_no)
updateTextInput(session, "treat_anticoagulanttime", value = df$treat_anticoagulanttime)

# Antitetanus
updateRadioButtons(session, "treat_antitetanus___recom_yes", selected = df$treat_antitetanus___recom_yes)
updateRadioButtons(session, "treat_antitetanus___recom_no", selected = df$treat_antitetanus___recom_no)
updateRadioButtons(session, "treat_antitetanus___received_yes", selected = df$treat_antitetanus___received_yes)
updateRadioButtons(session, "treat_antitetanus___received_no", selected = df$treat_antitetanus___received_no)
updateTextInput(session, "treat_antitetanustime", value = df$treat_antitetanustime)

# Antibiotic
updateRadioButtons(session, "treat_antibiotic___recom_yes", selected = df$treat_antibiotic___recom_yes)
updateRadioButtons(session, "treat_antibiotic___recom_no", selected = df$treat_antibiotic___recom_no)
updateRadioButtons(session, "treat_antibiotic___received_yes", selected = df$treat_antibiotic___received_yes)
updateRadioButtons(session, "treat_antibiotic___received_no", selected = df$treat_antibiotic___received_no)
updateTextInput(session, "treat_antibiotictime", value = df$treat_antibiotictime)

# Crystalloid
updateRadioButtons(session, "treat_crystalloid___recom_yes", selected = df$treat_crystalloid___recom_yes)
updateRadioButtons(session, "treat_crystalloid___recom_no", selected = df$treat_crystalloid___recom_no)
updateRadioButtons(session, "treat_crystalloid___received_yes", selected = df$treat_crystalloid___received_yes)
updateRadioButtons(session, "treat_crystalloid___received_no", selected = df$treat_crystalloid___received_no)
updateTextInput(session, "treat_crystalloidtime", value = df$treat_crystalloidtime)

# Colloid
updateRadioButtons(session, "treat_colloid___recom_yes", selected = df$treat_colloid___recom_yes)
updateRadioButtons(session, "treat_colloid___recom_no", selected = df$treat_colloid___recom_no)
updateRadioButtons(session, "treat_colloid___received_yes", selected = df$treat_colloid___received_yes)
updateRadioButtons(session, "treat_colloid___received_no", selected = df$treat_colloid___received_no)
updateTextInput(session, "treat_colloidtime", value = df$treat_colloidtime)

# Blood
updateRadioButtons(session, "treat_blood___recom_yes", selected = df$treat_blood___recom_yes)
updateRadioButtons(session, "treat_blood___recom_no", selected = df$treat_blood___recom_no)
updateRadioButtons(session, "treat_blood___received_yes", selected = df$treat_blood___received_yes)
updateRadioButtons(session, "treat_blood___received_no", selected = df$treat_blood___received_no)
updateTextInput(session, "treat_bloodtime", value = df$treat_bloodtime)

# Tranexamic Acid
updateRadioButtons(session, "treat_tranexacid___recom_yes", selected = df$treat_tranexacid___recom_yes)
updateRadioButtons(session, "treat_tranexacid___recom_no", selected = df$treat_tranexacid___recom_no)
updateRadioButtons(session, "treat_tranexacid___received_yes", selected = df$treat_tranexacid___received_yes)
updateRadioButtons(session, "treat_tranexacid___received_no", selected = df$treat_tranexacid___received_no)
updateTextInput(session, "treat_tranexacidtime", value = df$treat_tranexacidtime)

# PPI / H2 Blocker
updateRadioButtons(session, "treat_ppi___recom_yes", selected = df$treat_ppi___recom_yes)
updateRadioButtons(session, "treat_ppi___recom_no", selected = df$treat_ppi___recom_no)
updateRadioButtons(session, "treat_ppi___received_yes", selected = df$treat_ppi___received_yes)
updateRadioButtons(session, "treat_ppi___received_no", selected = df$treat_ppi___received_no)
updateTextInput(session, "treat_ppitime", value = df$treat_ppitime)

# Other
updateRadioButtons(session, "treat_other___recom_yes", selected = df$treat_other___recom_yes)
updateRadioButtons(session, "treat_other___recom_no", selected = df$treat_other___recom_no)
updateRadioButtons(session, "treat_other___received_yes", selected = df$treat_other___received_yes)
updateRadioButtons(session, "treat_other___received_no", selected = df$treat_other___received_no)
updateTextInput(session, "treat_othertime", value = df$treat_othertime)

# Splint
updateRadioButtons(session, "treat_split___recom_yes", selected = df$treat_split___recom_yes)
updateRadioButtons(session, "treat_split___recom_no", selected = df$treat_split___recom_no)
updateRadioButtons(session, "treat_split___received_yes", selected = df$treat_split___received_yes)
updateRadioButtons(session, "treat_split___received_no", selected = df$treat_split___received_no)
updateTextInput(session, "treat_splittime", value = df$treat_splittime)

# External Reduction
updateRadioButtons(session, "treat_reduct___recom_yes", selected = df$treat_reduct___recom_yes)
updateRadioButtons(session, "treat_reduct___recom_no", selected = df$treat_reduct___recom_no)
updateRadioButtons(session, "treat_reduct___received_yes", selected = df$treat_reduct___received_yes)
updateRadioButtons(session, "treat_reduct___received_no", selected = df$treat_reduct___received_no)
updateTextInput(session, "treat_reducttime", value = df$treat_reducttime)

# Debridement
updateRadioButtons(session, "treat_debride___recom_yes", selected = df$treat_debride___recom_yes)
updateRadioButtons(session, "treat_debride___recom_no", selected = df$treat_debride___recom_no)
updateRadioButtons(session, "treat_debride___received_yes", selected = df$treat_debride___received_yes)
updateRadioButtons(session, "treat_debride___received_no", selected = df$treat_debride___received_no)
updateTextInput(session, "treat_debridetime", value = df$treat_debridetime)

# Nasogastric Tube
updateRadioButtons(session, "treat_nasogastric___recom_yes", selected = df$treat_nasogastric___recom_yes)
updateRadioButtons(session, "treat_nasogastric___recom_no", selected = df$treat_nasogastric___recom_no)
updateRadioButtons(session, "treat_nasogastric___received_yes", selected = df$treat_nasogastric___received_yes)
updateRadioButtons(session, "treat_nasogastric___received_no", selected = df$treat_nasogastric___received_no)
updateTextInput(session, "treat_nasogastrictime", value = df$treat_nasogastrictime)

# Urinary Catheter
updateRadioButtons(session, "treat_catheter___recom_yes", selected = df$treat_catheter___recom_yes)
updateRadioButtons(session, "treat_catheter___recom_no", selected = df$treat_catheter___recom_no)
updateRadioButtons(session, "treat_catheter___received_yes", selected = df$treat_catheter___received_yes)
updateRadioButtons(session, "treat_catheter___received_no", selected = df$treat_catheter___received_no)
updateTextInput(session, "treat_cathetertime", value = df$treat_cathetertime)


### Labs Result
# Urine test
updateRadioButtons(session, "upt_recommend", selected = df$upt_recommend)
updateRadioButtons(session, "upt_performed", selected = df$upt_performed)
updateRadioButtons(session, "upt_result", selected = df$upt_result)

# Hemoglobine
updateRadioButtons(session, "hgb_recommend", selected = df$hgb_recommend)
updateRadioButtons(session, "hgb_performed", selected = df$hgb_performed)
updateRadioButtons(session, "hgb_result", selected = df$hgb_result)

# Blood Group
updateRadioButtons(session, "bg_recommend", selected = df$bg_recommend)
updateRadioButtons(session, "bg_performed", selected = df$bg_performed)
updateRadioButtons(session, "bg_result", selected = df$bg_result)


#### Patient Disposition
updateRadioButtons(session, "disposition", selected = df$disposition)
updateRadioButtons(session, "disposition_transfer", selected = df$disposition_transfer)
updateTextInput(session, "dispo_time", value = df$dispo_time)
updateTextInput(session, "dispo_date", value = df$dispo_date)

### Cost of care
updateCheckboxGroupInput(session, "diagnostic_notperformed", selected = df$diagnostic_notperformed)
updateTextInput(session, "diagnostic_notperformedother", value = df$diagnostic_notperformedother)

updateCheckboxGroupInput(session, "dispo_payment", selected = df$dispo_payment)
updateTextInput(session, "dispo_paymentother", value = df$dispo_paymentother)
updateTextInput(session, "dispo_cost", value = df$dispo_cost)

updateRadioButtons(session, "dispo_costcareimpede", selected = df$dispo_costcareimpede)
updateRadioButtons(session, "emergency_finassist", selected = df$emergency_finassist)
updateRadioButtons(session, "emerg_finassist_used", selected = df$emerg_finassist_used)
updateRadioButtons(session, "emerg_finassist_improve", selected = df$emerg_finassist_improve)


