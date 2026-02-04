## ---- Surgery recommended ----
updateRadioButtons(
  session,
  "fu_surgeryrec",
  selected = df$fu_surgeryrec
)

## ---- Head / Neurosurgery ----
updateRadioButtons(session, "fu_head_surgeryperf", selected = df$fu_head_surgeryperf)

updateCheckboxInput(
  session, "fu_head_surgery___1",
  value = as.logical(as.integer(df$fu_head_surgery___1))
)
updateCheckboxInput(
  session, "fu_head_surgery___2",
  value = as.logical(as.integer(df$fu_head_surgery___2))
)

updateTextInput(session, "fu_cranio_surgery_date", value = df$fu_cranio_surgery_date)
updateTextInput(session, "fu_cranio_surgery_time", value = df$fu_cranio_surgery_time)
updateTextInput(session, "fu_burr_surgery_date", value = df$fu_burr_surgery_date)
updateTextInput(session, "fu_burr_surgery_time", value = df$fu_burr_surgery_time)
updateTextInput(session, "fu_head_other", value = df$fu_head_other)

## ---- Face / Eye surgery ----
updateRadioButtons(session, "fu_face_surgeryperf", selected = df$fu_face_surgeryperf)
updateTextInput(session, "fu_face_surgery", value = df$fu_face_surgery)
updateTextInput(session, "fu_face_surgery_date", value = df$fu_face_surgery_date)
updateTextInput(session, "fu_face_surgery_time", value = df$fu_face_surgery_time)

## ---- Neck surgery ----
updateRadioButtons(session, "fu_neck_surgeryperf", selected = df$fu_neck_surgeryperf)

updateCheckboxInput(
  session, "fu_necksurgery_type___neck_exp",
  value = as.logical(as.integer(df$fu_necksurgery_type___neck_exp))
)
updateCheckboxInput(
  session, "fu_necksurgery_type___broncho",
  value = as.logical(as.integer(df$fu_necksurgery_type___broncho))
)
updateCheckboxInput(
  session, "fu_necksurgery_type___eso",
  value = as.logical(as.integer(df$fu_necksurgery_type___eso))
)

updateTextInput(session, "fu_neck_explo_date", value = df$fu_neck_explo_date)
updateTextInput(session, "fu_neck_explo_time", value = df$fu_neck_explo_time)
updateTextInput(session, "fu_bronch_surgery_date", value = df$fu_bronch_surgery_date)
updateTextInput(session, "fu_bronch_surgery_time", value = df$fu_bronch_surgery_time)
updateTextInput(session, "fu_esoph_surgery_date", value = df$fu_esoph_surgery_date)
updateTextInput(session, "fu_esoph_surgery_time", value = df$fu_esoph_surgery_time)
updateTextInput(session, "fu_neck_other", value = df$fu_neck_other)

## ---- Chest surgery ----
updateRadioButtons(session, "fu_chest_surgeryperf", selected = df$fu_chest_surgeryperf)

for (i in 1:7) {
  updateCheckboxInput(
    session,
    paste0("fu_chest_surgery___", i),
    value = as.logical(as.integer(df[[paste0("fu_chest_surgery___", i)]]))
  )
}

updateTextInput(session, "fu_chesttube_surgery_date", value = df$fu_chesttube_surgery_date)
updateTextInput(session, "fu_chesttube_surgery_time", value = df$fu_chesttube_surgery_time)
updateTextInput(session, "fu_drainage_surgery_date", value = df$fu_drainage_surgery_date)
updateTextInput(session, "fu_drainage_surgery_time", value = df$fu_drainage_surgery_time)
updateTextInput(session, "fu_thora_surgery_date", value = df$fu_thora_surgery_date)
updateTextInput(session, "fu_thora_surgery_time", value = df$fu_thora_surgery_time)
updateTextInput(session, "fu_lungres_surgery_date", value = df$fu_lungres_surgery_date)
updateTextInput(session, "fu_lungres_surgery_time", value = df$fu_lungres_surgery_time)
updateTextInput(session, "fu_vessel_surgery_date", value = df$fu_vessel_surgery_date)
updateTextInput(session, "fu_vessel_surgery_time", value = df$fu_vessel_surgery_time)
updateTextInput(session, "fu_vascularmajor_surgery_date", value = df$fu_vascularmajor_surgery_date)
updateTextInput(session, "fu_vascularmajor_surgery_time", value = df$fu_vascularmajor_surgery_time)
updateTextInput(session, "fu_otherhem_surgery_date", value = df$fu_otherhem_surgery_date)
updateTextInput(session, "fu_otherhem_surgery_time", value = df$fu_otherhem_surgery_time)
updateTextInput(session, "fu_chest_other", value = df$fu_chest_other)

## ---- Abdominal surgery ----
updateRadioButtons(session, "fu_abdominal_surgeryperf", selected = df$fu_abdominal_surgeryperf)

for (i in 1:7) {
  updateCheckboxInput(
    session,
    paste0("fu_abdominal_surgery___", i),
    value = as.logical(as.integer(df[[paste0("fu_abdominal_surgery___", i)]]))
  )
}

updateTextInput(session, "fu_lapar_surgery_date", value = df$fu_lapar_surgery_date)
updateTextInput(session, "fu_lapar_surgery_time", value = df$fu_lapar_surgery_time)
updateTextInput(session, "fu_bowel_surgery_date", value = df$fu_bowel_surgery_date)
updateTextInput(session, "fu_bowel_surgery_time", value = df$fu_bowel_surgery_time)
updateTextInput(session, "fu_ostomy_surgery_date", value = df$fu_ostomy_surgery_date)
updateTextInput(session, "fu_ostomy_surgery_time", value = df$fu_ostomy_surgery_time)
updateTextInput(session, "fu_liver_surgery_date", value = df$fu_liver_surgery_date)
updateTextInput(session, "fu_liver_surgery_time", value = df$fu_liver_surgery_time)
updateTextInput(session, "fu_splene_surgery_date", value = df$fu_splene_surgery_date)
updateTextInput(session, "fu_splene_surgery_time", value = df$fu_splene_surgery_time)
updateTextInput(session, "fu_vascular_surgery_date", value = df$fu_vascular_surgery_date)
updateTextInput(session, "fu_vascular_surgery_time", value = df$fu_vascular_surgery_time)
updateTextInput(session, "fu_pancreatic_surgery_date", value = df$fu_pancreatic_surgery_date)
updateTextInput(session, "fu_pancreatic_surgery_time", value = df$fu_pancreatic_surgery_time)
updateTextInput(session, "fu_abdominal_other", value = df$fu_abdominal_other)

## ---- Soft tissue surgery ----
updateRadioButtons(session, "fu_soft_surgeryperf", selected = df$fu_soft_surgeryperf)

updateCheckboxInput(
  session, "fu_soft_surgery___1",
  value = as.logical(as.integer(df$fu_soft_surgery___1))
)
updateCheckboxInput(
  session, "fu_soft_surgery___2",
  value = as.logical(as.integer(df$fu_soft_surgery___2))
)
updateCheckboxInput(
  session, "fu_soft_surgery___3",
  value = as.logical(as.integer(df$fu_soft_surgery___3))
)

updateTextInput(session, "fu_debride_surgery_date", value = df$fu_debride_surgery_date)
updateTextInput(session, "fu_debride_surgery_time", value = df$fu_debride_surgery_time)
updateTextInput(session, "fu_suture_surgery_date", value = df$fu_suture_surgery_date)
updateTextInput(session, "fu_suture_surgery_time", value = df$fu_suture_surgery_time)
updateTextInput(session, "fu_graft_surgery_date", value = df$fu_graft_surgery_date)
updateTextInput(session, "fu_graft_surgery_time", value = df$fu_graft_surgery_time)
updateTextInput(session, "fu_soft_other", value = df$fu_soft_other)

## ---- Other procedure ----
updateRadioButtons(session, "fu_other_procedure", selected = df$fu_other_procedure)
updateTextInput(session, "fu_other_otherprocedure", value = df$fu_other_otherprocedure)
updateTextInput(session, "fu_specify_otherprocedure", value = df$fu_specify_otherprocedure)
