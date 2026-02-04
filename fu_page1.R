tagList(

  ### HEAD/NEUROSURGERY SECTION ----
  fluidRow(
    column(12, style = "border: none; padding: 0; margin: 0;",

           # Header and Yes/No radio buttons
           fluidRow(style = "border: none; padding: 0; margin-bottom: 2px;",
                    column(4, strong("Head/Neurosurgery"), style = "border: none;"),
                    column(8, radioButtons("fu_head_surgeryperf", NULL, inline = TRUE,
                                           choices = c("Yes" = "1", "No" = "0")),
                           style = "border: none;")
           ),

           # Surgery Items
           fluidRow(style = "border: none; padding-left: 20px;",
                    column(12,

                           # Craniotomy row
                           fluidRow(style = "border: none; margin-bottom: 2px;",
                                    column(1, checkboxInput("fu_head_surgery_craniotomy", NULL, FALSE),
                                           style = "border: none; padding-top: 6px;"),
                                    column(3, "Craniotomy", style = "border: none; padding-top: 6px;"),
                                    column(4, textInput("fu_cranio_surgery_date", label = NULL, placeholder = "Date/Details"),
                                           style = "border: none;"),
                                    column(4, textInput("fu_cranio_nosurgery", label = NULL, placeholder = "Date/Details"),
                                           style = "border: none;")
                           ),

                           # Burr Hole row
                           fluidRow(style = "border: none;",
                                    column(1, checkboxInput("fu_head_surgery_burrhole", NULL, FALSE),
                                           style = "border: none; padding-top: 6px;"),
                                    column(3, "Burr Hole", style = "border: none; padding-top: 6px;"),
                                    column(4, textInput("fu_burr_surgery_date", label = NULL, placeholder = "Date/Details"),
                                           style = "border: none;"),
                                    column(4, textInput("fu_burr_surgery_no", label = NULL, placeholder = "Date/Details"),
                                           style = "border: none;")
                           )
                    )
           )
    )
  ),

  ### FACE/EYE SURGERY SECTION ----
  fluidRow(
    column(12, style = "border: none; padding: 0; margin: 0;",
           fluidRow(style = "border: none; padding: 0; ",
                    column(4, checkboxInput("fu_face_surgery_other_yes", NULL, FALSE), strong("Face/Eye Surgery"), style = "border: none;"),
                    column(4, radioButtons("fu_face_surgeryperf", NULL, inline = TRUE,
                                           choices = c("Yes" = "1")),
                           style = "border: none;"),
                    column(4, radioButtons("fu_face_surgeryperf_no", NULL, inline = TRUE,
                                           choices = c("No" = "0")),
                           style = "border: none;")
           ),
           fluidRow(style = "border: none; padding-left: 20px;",
                    column(12,
                           fluidRow(style = "border: none;",
                                    column(4, textInput("fu_face_surgery_other_label", label = NULL,
                                                        placeholder = "(specify procedure type)"),
                                           style = "border: none;"),
                                    column(4, checkboxInput("fu_face_surgery_other_yes", NULL, FALSE), style = "border: none;"),
                                    column(4, checkboxInput("fu_face_surgery_other_no", NULL, FALSE), style = "border: none;")
                           )
                    )
           )
    )
  ),

  ### NECK SURGERY SECTION ----
  fluidRow(
    column(12, style = "border: none; padding: 0; margin: 0;",
           fluidRow(style = "border: none; padding: 0; ",
                    column(4, strong("Neck Surgery"), style = "border: none;"),
                    column(4, radioButtons("fu_neck_surgeryperf", NULL, inline = TRUE,
                                           choices = c("Yes" = "1")),
                           style = "border: none;"),
                    column(4, radioButtons("fu_neck_surgeryperf_no", NULL, inline = TRUE,
                                           choices = c("No" = "0")),
                           style = "border: none;")
           ),
           fluidRow(style = "border: none; padding-left: 20px;",
                    column(12,
                           fluidRow(style = "border: none; ",
                                    column(4, "Neck exploration", style = "border: none;"),
                                    column(4, checkboxInput("fu_necksurgery_type_neck_exp_yes", NULL, FALSE), style = "border: none;"),
                                    column(4, checkboxInput("fu_necksurgery_type_neck_exp_no", NULL, FALSE), style = "border: none;")
                           ),
                           fluidRow(style = "border: none; ",
                                    column(4, "Bronchoscopy", style = "border: none;"),
                                    column(4, checkboxInput("fu_necksurgery_type_broncho_yes", NULL, FALSE), style = "border: none;"),
                                    column(4, checkboxInput("fu_necksurgery_type_broncho_no", NULL, FALSE), style = "border: none;")
                           ),
                           fluidRow(style = "border: none;",
                                    column(4, "Esophagoscopy", style = "border: none;"),
                                    column(4, checkboxInput("fu_necksurgery_type_eso_yes", NULL, FALSE), style = "border: none;"),
                                    column(4, checkboxInput("fu_necksurgery_type_eso_no", NULL, FALSE), style = "border: none;")
                           )
                    )
           )
    )
  ),

  fluidRow(
    column(12, style = "border: none; padding: 0; margin: 0;",

           # Surgery performed?
           fluidRow(style = "border: none; padding: 0; ",
                    column(4, strong("Chest Surgery"), style = "border: none;"),
                    column(4, radioButtons("fu_chest_surgeryperf", NULL, inline = TRUE,
                                           choices = c("Yes" = "1")),
                           style = "border: none;"),
                    column(4, radioButtons("fu_chest_surgeryperf_no", NULL, inline = TRUE,
                                           choices = c("No" = "0")),
                           style = "border: none;")
           ),

           # Surgery subtype rows (indented)
           fluidRow(style = "border: none; padding-left: 20px;",
                    column(12,
                           fluidRow(style = "border: none; ",
                                    column(4, "Chest Tube", style = "border: none;"),
                                    column(4, checkboxInput("fu_chest_surgery_1_yes", NULL, FALSE),
                                           style = "border: none;"),
                                    column(4, checkboxInput("fu_chest_surgery_1_no", NULL, FALSE),
                                           style = "border: none;")
                           ),
                           fluidRow(style = "border: none; ",
                                    column(4, "Thoracentesis/drainage", style = "border: none;"),
                                    column(4, checkboxInput("fu_chest_surgery_2_yes", NULL, FALSE),
                                           style = "border: none;"),
                                    column(4, checkboxInput("fu_chest_surgery_2_no", NULL, FALSE),
                                           style = "border: none;")
                           ),
                           fluidRow(style = "border: none; ",
                                    column(4, "Thoracotomy", style = "border: none;"),
                                    column(4, checkboxInput("fu_chest_surgery_3_yes", NULL, FALSE),
                                           style = "border: none;"),
                                    column(4, checkboxInput("fu_chest_surgery_3_no", NULL, FALSE),
                                           style = "border: none;")
                           ),
                           fluidRow(style = "border: none; ",
                                    column(4, "Lung resection", style = "border: none;"),
                                    column(4, checkboxInput("fu_chest_surgery_4_yes", NULL, FALSE),
                                           style = "border: none;"),
                                    column(4, checkboxInput("fu_chest_surgery_4_no", NULL, FALSE),
                                           style = "border: none;")
                           ),
                           fluidRow(style = "border: none; ",
                                    column(4, "Vessel ligation", style = "border: none;"),
                                    column(4, checkboxInput("fu_chest_surgery_5_yes", NULL, FALSE),
                                           style = "border: none;"),
                                    column(4, checkboxInput("fu_chest_surgery_5_no", NULL, FALSE),
                                           style = "border: none;")
                           ),
                           fluidRow(style = "border: none; ",
                                    column(4, "Major Vascular Repair", style = "border: none;"),
                                    column(4, checkboxInput("fu_chest_surgery_6_yes", NULL, FALSE),
                                           style = "border: none;"),
                                    column(4, checkboxInput("fu_chest_surgery_6_no", NULL, FALSE),
                                           style = "border: none;")
                           ),
                           fluidRow(style = "border: none;",
                                    column(4, "Other hemorrhage control", style = "border: none;"),
                                    column(4, checkboxInput("fu_chest_surgery_7_yes", NULL, FALSE),
                                           style = "border: none;"),
                                    column(4, checkboxInput("fu_chest_surgery_7_no", NULL, FALSE),
                                           style = "border: none;")
                           )
                    )
           )
    )
  ),

  fluidRow(
    column(12, style = "border: none; padding: 0; margin: 0;",

           # Chest Surgery
           fluidRow(style = "border: none; padding: 0; ",
                    column(4, strong("Chest Surgery"), style = "border: none;"),
                    column(4, radioButtons("fu_chest_surgeryperf", NULL, inline = TRUE,
                                           choices = c("Yes" = "1")),
                           style = "border: none;"),
                    column(4, radioButtons("fu_chest_surgeryperf_no", NULL, inline = TRUE,
                                           choices = c("No" = "0")),
                           style = "border: none;")
           ),

           fluidRow(style = "border: none; padding-left: 20px;",
                    column(12,
                           fluidRow(style = "border: none; ",
                                    column(4, "Chest Tube", style = "border: none;"),
                                    column(4, checkboxInput("fu_chest_surgery_chest_tube_yes", NULL, FALSE), style = "border: none;"),
                                    column(4, checkboxInput("fu_chest_surgery_chest_tube_no", NULL, FALSE), style = "border: none;")
                           ),
                           fluidRow(style = "border: none; ",
                                    column(4, "Thoracentesis/drainage", style = "border: none;"),
                                    column(4, checkboxInput("fu_chest_surgery_thoracentesis_yes", NULL, FALSE), style = "border: none;"),
                                    column(4, checkboxInput("fu_chest_surgery_thoracentesis_no", NULL, FALSE), style = "border: none;")
                           ),
                           fluidRow(style = "border: none; ",
                                    column(4, "Thoracotomy", style = "border: none;"),
                                    column(4, checkboxInput("fu_chest_surgery_thoracotomy_yes", NULL, FALSE), style = "border: none;"),
                                    column(4, checkboxInput("fu_chest_surgery_thoracotomy_no", NULL, FALSE), style = "border: none;")
                           ),
                           fluidRow(style = "border: none; ",
                                    column(4, "Lung resection", style = "border: none;"),
                                    column(4, checkboxInput("fu_chest_surgery_lung_resection_yes", NULL, FALSE), style = "border: none;"),
                                    column(4, checkboxInput("fu_chest_surgery_lung_resection_no", NULL, FALSE), style = "border: none;")
                           ),
                           fluidRow(style = "border: none; ",
                                    column(4, "Vessel ligation", style = "border: none;"),
                                    column(4, checkboxInput("fu_chest_surgery_vessel_ligation_yes", NULL, FALSE), style = "border: none;"),
                                    column(4, checkboxInput("fu_chest_surgery_vessel_ligation_no", NULL, FALSE), style = "border: none;")
                           ),
                           fluidRow(style = "border: none;",
                                    column(4, "Major Vascular Repair", style = "border: none;"),
                                    column(4, checkboxInput("fu_chest_surgery_major_vascular_repair_yes", NULL, FALSE), style = "border: none;"),
                                    column(4, checkboxInput("fu_chest_surgery_major_vascular_repair_no", NULL, FALSE), style = "border: none;")
                           ),
                           fluidRow(style = "border: none;",
                                    column(4, "Other hemorrhage control", style = "border: none;"),
                                    column(4, checkboxInput("fu_chest_surgery_other_hemorrhage_yes", NULL, FALSE), style = "border: none;"),
                                    column(4, checkboxInput("fu_chest_surgery_other_hemorrhage_no", NULL, FALSE), style = "border: none;")
                           )
                    )
           )
    )
  ),

  # Abdominal Surgery
  fluidRow(
    column(12, style = "border: none; padding: 0; margin: 0;",

           # Surgery performed?
           fluidRow(style = "border: none; padding: 0; ",
                    column(4, strong("Abdominal Surgery"), style = "border: none;"),
                    column(4, radioButtons("fu_abdominal_surgeryperf", NULL, inline = TRUE,
                                           choices = c("Yes" = "1")),
                           style = "border: none;"),
                    column(4, radioButtons("fu_abdominal_surgeryperf_no", NULL, inline = TRUE,
                                           choices = c("No" = "0")),
                           style = "border: none;")
           ),

           # Subtype rows
           fluidRow(style = "border: none; padding-left: 20px;",
                    column(12,

                           # Exploratory Laparotomy
                           fluidRow(style = "border: none; ",
                                    column(4, "Exploratory Laparotomy", style = "border: none;"),
                                    column(4, checkboxInput("fu_abdominal_surgery_lap_yes", NULL, FALSE),
                                           style = "border: none;"),
                                    column(4, checkboxInput("fu_abdominal_surgery_lap_no", NULL, FALSE),
                                           style = "border: none;")
                           ),

                           # Bowel Resection/Repair
                           fluidRow(style = "border: none; ",
                                    column(4, "Bowel Resection/Repair", style = "border: none;"),
                                    column(4, checkboxInput("fu_abdominal_surgery_bowel_yes", NULL, FALSE),
                                           style = "border: none;"),
                                    column(4, checkboxInput("fu_abdominal_surgery_bowel_no", NULL, FALSE),
                                           style = "border: none;")
                           ),

                           # Diversion/Ostomy
                           fluidRow(style = "border: none; ",
                                    column(4, "Diversion/ Ostomy", style = "border: none;"),
                                    column(4, checkboxInput("fu_abdominal_surgery_ostomy_yes", NULL, FALSE),
                                           style = "border: none;"),
                                    column(4, checkboxInput("fu_abdominal_surgery_ostomy_no", NULL, FALSE),
                                           style = "border: none;")
                           ),

                           # Liver Repair
                           fluidRow(style = "border: none; ",
                                    column(4, "Liver Repair", style = "border: none;"),
                                    column(4, checkboxInput("fu_abdominal_surgery_liver_yes", NULL, FALSE),
                                           style = "border: none;"),
                                    column(4, checkboxInput("fu_abdominal_surgery_liver_no", NULL, FALSE),
                                           style = "border: none;")
                           ),

                           # Splenectomy
                           fluidRow(style = "border: none; ",
                                    column(4, "Splenectomy", style = "border: none;"),
                                    column(4, checkboxInput("fu_abdominal_surgery_splene_yes", NULL, FALSE),
                                           style = "border: none;"),
                                    column(4, checkboxInput("fu_abdominal_surgery_splene_no", NULL, FALSE),
                                           style = "border: none;")
                           ),

                           # Vascular Repair
                           fluidRow(style = "border: none; ",
                                    column(4, "Vascular Repair", style = "border: none;"),
                                    column(4, checkboxInput("fu_abdominal_surgery_vasc_yes", NULL, FALSE),
                                           style = "border: none;"),
                                    column(4, checkboxInput("fu_abdominal_surgery_vasc_no", NULL, FALSE),
                                           style = "border: none;")
                           ),

                           # Pancreatic Repair
                           fluidRow(style = "border: none;",
                                    column(4, "Pancreatic Repair", style = "border: none;"),
                                    column(4, checkboxInput("fu_abdominal_surgery_pancreas_yes", NULL, FALSE),
                                           style = "border: none;"),
                                    column(4, checkboxInput("fu_abdominal_surgery_pancreas_no", NULL, FALSE),
                                           style = "border: none;")
                           )
                    )
           )
    )
  ),

  # Orthopedic Surgery
  fluidRow(
    column(12, style = "border: none; padding: 0; margin: 0;",

           # Surgery performed?
           fluidRow(style = "border: none; padding: 0; ",
                    column(4, strong("Orthopedic Surgery"), style = "border: none;"),
                    column(4, radioButtons("fu_ortho_surgeryperf", NULL, inline = TRUE,
                                           choices = c("Yes" = "1")),
                           style = "border: none;"),
                    column(4, radioButtons("fu_ortho_surgeryperf_no", NULL, inline = TRUE,
                                           choices = c("No" = "0")),
                           style = "border: none;")
           ),

           # Subtype rows
           fluidRow(style = "border: none; padding-left: 20px;",
                    column(12,

                           # Osteosynthesis
                           fluidRow(style = "border: none; ",
                                    column(4, "Osteosynthesis", style = "border: none;"),
                                    column(4, checkboxInput("fu_ortho_surgery_osteo_yes", NULL, FALSE),
                                           style = "border: none;"),
                                    column(4, checkboxInput("fu_ortho_surgery_osteo_no", NULL, FALSE),
                                           style = "border: none;")
                           ),

                           # Amputation
                           fluidRow(style = "border: none; ",
                                    column(4, "Amputation", style = "border: none;"),
                                    column(4, checkboxInput("fu_ortho_surgery_amput_yes", NULL, FALSE),
                                           style = "border: none;"),
                                    column(4, checkboxInput("fu_ortho_surgery_amput_no", NULL, FALSE),
                                           style = "border: none;")
                           ),

                           # External Fixation
                           fluidRow(style = "border: none; ",
                                    column(4, "External Fixation", style = "border: none;"),
                                    column(4, checkboxInput("fu_ortho_surgery_extfix_yes", NULL, FALSE),
                                           style = "border: none;"),
                                    column(4, checkboxInput("fu_ortho_surgery_extfix_no", NULL, FALSE),
                                           style = "border: none;")
                           ),

                           # Open Reduction / ORIF
                           fluidRow(style = "border: none; ",
                                    column(4, "Open Reduction / ORIF", style = "border: none;"),
                                    column(4, checkboxInput("fu_ortho_surgery_orif_yes", NULL, FALSE),
                                           style = "border: none;"),
                                    column(4, checkboxInput("fu_ortho_surgery_orif_no", NULL, FALSE),
                                           style = "border: none;")
                           ),

                           # Tendinoplasty
                           fluidRow(style = "border: none;",
                                    column(4, "Tendinoplasty", style = "border: none;"),
                                    column(4, checkboxInput("fu_ortho_surgery_tendino_yes", NULL, FALSE),
                                           style = "border: none;"),
                                    column(4, checkboxInput("fu_ortho_surgery_tendino_no", NULL, FALSE),
                                           style = "border: none;")
                           )
                    )
           )
    )
  ),

  # Vascular Surgery
  fluidRow(
    column(12, style = "border: none; padding: 0; margin: 0;",

           # Surgery performed?
           fluidRow(style = "border: none; padding: 0; ",
                    column(4, strong("Vascular Surgery"), style = "border: none;"),
                    column(4, radioButtons("fu_vascular_surgeryperf", NULL, inline = TRUE,
                                           choices = c("Yes" = "1")),
                           style = "border: none;"),
                    column(4, radioButtons("fu_vascular_surgeryperf_no", NULL, inline = TRUE,
                                           choices = c("No" = "0")),
                           style = "border: none;")
           ),

           # Subtype rows
           fluidRow(style = "border: none; padding-left: 20px;",
                    column(12,

                           # Arterial/Venous Ligation
                           fluidRow(style = "border: none; ",
                                    column(4, "Arterial/Venous Ligation", style = "border: none;"),
                                    column(4, checkboxInput("fu_vascular_surgery_ligation_yes", NULL, FALSE),
                                           style = "border: none;"),
                                    column(4, checkboxInput("fu_vascular_surgery_ligation_no", NULL, FALSE),
                                           style = "border: none;")
                           ),

                           # Arterial/Venous Repair
                           fluidRow(style = "border: none;",
                                    column(4, "Arterial/Venous Repair", style = "border: none;"),
                                    column(4, checkboxInput("fu_vascular_surgery_repair_yes", NULL, FALSE),
                                           style = "border: none;"),
                                    column(4, checkboxInput("fu_vascular_surgery_repair_no", NULL, FALSE),
                                           style = "border: none;")
                           )
                    )
           )
    )
  ),

  # Urogenital Surgery
  fluidRow(
    column(12, style = "border: none; padding: 0; margin: 0;",

           # Surgery performed?
           fluidRow(style = "border: none; padding: 0; ",
                    column(4, strong("Urogenital Surgery"), style = "border: none;"),
                    column(4, radioButtons("fu_uro_surgeryperf", NULL, inline = TRUE,
                                           choices = c("Yes" = "1")),
                           style = "border: none;"),
                    column(4, radioButtons("fu_uro_surgeryperf_no", NULL, inline = TRUE,
                                           choices = c("No" = "0")),
                           style = "border: none;")
           ),

           # Subtype rows
           fluidRow(style = "border: none; padding-left: 20px;",
                    column(12,

                           # Cystoscopy
                           fluidRow(style = "border: none; ",
                                    column(4, "Cystoscopy", style = "border: none;"),
                                    column(4, checkboxInput("fu_uro_surgery_cystoscopy_yes", NULL, FALSE),
                                           style = "border: none;"),
                                    column(4, checkboxInput("fu_uro_surgery_cystoscopy_no", NULL, FALSE),
                                           style = "border: none;")
                           ),

                           # Repair of urethra, bladder, ureters
                           fluidRow(style = "border: none; ",
                                    column(4, "Repair of urethra, bladder, ureters", style = "border: none;"),
                                    column(4, checkboxInput("fu_uro_surgery_repair_tract_yes", NULL, FALSE),
                                           style = "border: none;"),
                                    column(4, checkboxInput("fu_uro_surgery_repair_tract_no", NULL, FALSE),
                                           style = "border: none;")
                           ),

                           # Cesarean section
                           fluidRow(style = "border: none; ",
                                    column(4, "Cesarean Section", style = "border: none;"),
                                    column(4, checkboxInput("fu_uro_surgery_csection_yes", NULL, FALSE),
                                           style = "border: none;"),
                                    column(4, checkboxInput("fu_uro_surgery_csection_no", NULL, FALSE),
                                           style = "border: none;")
                           ),

                           # D&C / Manual Aspiration
                           fluidRow(style = "border: none; ",
                                    column(4, "D&C / Manual Aspiration", style = "border: none;"),
                                    column(4, checkboxInput("fu_uro_surgery_dc_asp_yes", NULL, FALSE),
                                           style = "border: none;"),
                                    column(4, checkboxInput("fu_uro_surgery_dc_asp_no", NULL, FALSE),
                                           style = "border: none;")
                           ),

                           # Repair of internal/external genitalia
                           fluidRow(style = "border: none;",
                                    column(4, "Repair of genitalia", style = "border: none;"),
                                    column(4, checkboxInput("fu_uro_surgery_genitalia_yes", NULL, FALSE),
                                           style = "border: none;"),
                                    column(4, checkboxInput("fu_uro_surgery_genitalia_no", NULL, FALSE),
                                           style = "border: none;")
                           )
                    )
           )
    )
  ),

  # Soft Tissue Surgery
  fluidRow(
    column(12, style = "border: none; padding: 0; margin: 0;",

           # Surgery performed?
           fluidRow(style = "border: none; padding: 0; ",
                    column(4, strong("Soft Tissue Surgery"), style = "border: none;"),
                    column(4, radioButtons("fu_soft_surgeryperf", NULL, inline = TRUE,
                                           choices = c("Yes" = "1")),
                           style = "border: none;"),
                    column(4, radioButtons("fu_soft_surgeryperf_no", NULL, inline = TRUE,
                                           choices = c("No" = "0")),
                           style = "border: none;")
           ),

           # Subtype rows
           fluidRow(style = "border: none; padding-left: 20px;",
                    column(12,

                           # No (specify reason)
                           fluidRow(style = "border: none; ",
                                    column(4, "No (specify reason)", style = "border: none;"),
                                    column(4, checkboxInput("fu_soft_surgery_none_yes", NULL, FALSE),
                                           style = "border: none;"),
                                    column(4, checkboxInput("fu_soft_surgery_none_no", NULL, FALSE),
                                           style = "border: none;")
                           ),

                           # Debridement
                           fluidRow(style = "border: none; ",
                                    column(4, "Debridement", style = "border: none;"),
                                    column(4, checkboxInput("fu_soft_surgery_debridement_yes", NULL, FALSE),
                                           style = "border: none;"),
                                    column(4, checkboxInput("fu_soft_surgery_debridement_no", NULL, FALSE),
                                           style = "border: none;")
                           ),

                           # Complex Suture Repair
                           fluidRow(style = "border: none; ",
                                    column(4, "Complex Suture Repair", style = "border: none;"),
                                    column(4, checkboxInput("fu_soft_surgery_complex_suture_yes", NULL, FALSE),
                                           style = "border: none;"),
                                    column(4, checkboxInput("fu_soft_surgery_complex_suture_no", NULL, FALSE),
                                           style = "border: none;")
                           ),

                           # Skin Graft
                           fluidRow(style = "border: none;",
                                    column(4, "Skin Graft", style = "border: none;"),
                                    column(4, checkboxInput("fu_soft_surgery_graft_yes", NULL, FALSE),
                                           style = "border: none;"),
                                    column(4, checkboxInput("fu_soft_surgery_graft_no", NULL, FALSE),
                                           style = "border: none;")
                           )
                    )
           )
    )
  ),

  # Other Procedures
  fluidRow(
    column(12, style = "border: none; padding: 0; margin: 0;",

           fluidRow(style = "border: none; padding: 0; ",
                    column(12, strong("Other Procedures"), style = "border: none;")
           ),

           # Procedure subtype rows (indented)
           fluidRow(style = "border: none; padding-left: 20px;",
                    column(12,

                           # Closed Reduction
                           fluidRow(style = "border: none; ",
                                    column(4, "Closed Reduction", style = "border: none;"),
                                    column(4, checkboxInput("fu_other_procedure_reduction_yes", NULL, FALSE),
                                           style = "border: none;"),
                                    column(4, checkboxInput("fu_other_procedure_reduction_no", NULL, FALSE),
                                           style = "border: none;")
                           ),

                           # Splinting / Casting
                           fluidRow(style = "border: none; ",
                                    column(4, "Splinting / Casting", style = "border: none;"),
                                    column(4, checkboxInput("fu_other_procedure_splint_yes", NULL, FALSE),
                                           style = "border: none;"),
                                    column(4, checkboxInput("fu_other_procedure_splint_no", NULL, FALSE),
                                           style = "border: none;")
                           ),

                           # Wound Care / Dressing
                           fluidRow(style = "border: none; ",
                                    column(4, "Wound Care / Dressing", style = "border: none;"),
                                    column(4, checkboxInput("fu_other_procedure_dressing_yes", NULL, FALSE),
                                           style = "border: none;"),
                                    column(4, checkboxInput("fu_other_procedure_dressing_no", NULL, FALSE),
                                           style = "border: none;")
                           ),

                           # Physiotherapy
                           fluidRow(style = "border: none; ",
                                    column(4, "Physiotherapy", style = "border: none;"),
                                    column(4, checkboxInput("fu_other_procedure_physio_yes", NULL, FALSE),
                                           style = "border: none;"),
                                    column(4, checkboxInput("fu_other_procedure_physio_no", NULL, FALSE),
                                           style = "border: none;")
                           ),

                           # Simple Suture Repair
                           fluidRow(style = "border: none; ",
                                    column(4, "Simple Suture Repair", style = "border: none;"),
                                    column(4, checkboxInput("fu_other_procedure_simple_suture_yes", NULL, FALSE),
                                           style = "border: none;"),
                                    column(4, checkboxInput("fu_other_procedure_simple_suture_no", NULL, FALSE),
                                           style = "border: none;")
                           ),

                           # Simple Aspiration
                           fluidRow(style = "border: none; ",
                                    column(4, "Simple Aspiration", style = "border: none;"),
                                    column(4, checkboxInput("fu_other_procedure_simple_asp_yes", NULL, FALSE),
                                           style = "border: none;"),
                                    column(4, checkboxInput("fu_other_procedure_simple_asp_no", NULL, FALSE),
                                           style = "border: none;")
                           ),

                           # Simple Incision & Drainage
                           fluidRow(style = "border: none; ",
                                    column(4, "Simple Incision & Drainage", style = "border: none;"),
                                    column(4, checkboxInput("fu_other_procedure_simple_inc_yes", NULL, FALSE),
                                           style = "border: none;"),
                                    column(4, checkboxInput("fu_other_procedure_simple_inc_no", NULL, FALSE),
                                           style = "border: none;")
                           ),

                           # Other
                           fluidRow(style = "border: none;",
                                    column(4, "Other", style = "border: none;"),
                                    column(4, checkboxInput("fu_other_procedure_other_yes", NULL, FALSE),
                                           style = "border: none;"),
                                    column(4, checkboxInput("fu_other_procedure_other_no", NULL, FALSE),
                                           style = "border: none;")
                           )
                    )
           )
    )
  )


  )
