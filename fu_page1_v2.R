tagList(

  div(class = "form-title", "CTR - Trauma Patient Follow Up and Outcome Form"),

  fluidRow(
    column(6,textInput("ctr_id", "Patient CTR ID:")),
    column(6,textInput("arrivaldate", "Date of Admission:",))),

  div(class = "rowline"),

  # ---------------- Surgery Recommended ----------------
  div(class = "section-box tight",
      div(class = "section-hdr", "Surgery"),

      fluidRow(
        column(
          12,
          div(
            class = "q-row",
            div(class = "q-text", "Was surgery recommended by the treating clinician?"),
            div(
              class = "q-opts",
              radioButtons(
                "fu_surgeryrec",
                label = NULL,
                choices = c("Yes" = 1, "No" = 0),
                selected = character(0),
                inline = TRUE
              )
            )
          )

        )),
        fluidRow(
          column(6,
                 div(
                   class = "q-row",
                   div(class = "q-text", "*If YES, which surgeries? (mark all recommended)"),
                 )

          ),
          column(6,
                 div(
                   class = "q-row",
                   div(class = "q-text", "Was surgery performed?"),
                 )

          )
      ),

      fluidRow(
        column(6,
               div(
                 class = "q-row",
                 div(class = "q-text", "Head/Neurosurgery"),
               )

        ),
        column(6,
               div(
                 class = "q-opts",
                 radioButtons(
                   "fu_head_surgeryperf",
                   label = NULL,
                   choices = c("Yes" = "1", "No" = "0"),
                   selected = character(0),
                   inline = TRUE
                 )
               )
        )
      ),

      fluidRow(
        column(
          3,
          div(
            class = "no-lines",
            checkboxInput("fu_head_surgery___1", "Craniotomy / Cranioplasty", FALSE),
            tags$br(), tags$br(),
            checkboxInput("fu_head_surgery___2", "Burr Hole", FALSE)
          )
        ),

        column(
          9,
          div(
            class = "no-lines",
            fluidRow(
              column(
                8,
                div(
                  class = "no-lines",
                  fluidRow(
                    column(6, textInput("fu_cranio_surgery_date", "Date:", "")),
                    column(6, textInput("fu_cranio_surgery_time", "Time:", ""))
                  ),
                  # tags$br(),
                  fluidRow(
                    column(6, textInput("fu_burr_surgery_date", "", "")),
                    column(6, textInput("fu_burr_surgery_time", "", ""))
                  )
                )
              ),
              column(
                4,
                div(
                  class = "no-lines",
                  textInput("fu_head_other", "specify reason", "")
                )
              )
            )
          )
        )
      ),

      ### ---- Face / Eye surgery ----

      # Row 1: section label + recommended (Yes/No)
      fluidRow(
        column(
          6,
          div(
            class = "q-row",
            div(class = "q-text", "Face/ Eye surgery")
          )
        ),
        column(
          6,
          div(
            class = "q-opts",
            radioButtons(
              "fu_face_surgeryperf",     # uses your dataset column
              label = NULL,
              choices = c("Yes" = "1", "No" = "0"),
              selected = character(0),
              inline = TRUE
            )
          )
        )
      ),

      # Row 2: left = procedure type; right = performed + date/time + no reason
      fluidRow(
        column(
          3,
          div(
            class = "no-lines",
            textInput("fu_face_surgery", "(specify procedure type)", "")          )
        ),

        column(
          9,
          div(
            class = "no-lines",
            fluidRow(
              column(
                8,
                div(
                  class = "no-lines",
                  fluidRow(
                    column(6, textInput("fu_face_surgery_date", "Date:", "")),
                    column(6, textInput("fu_face_surgery_time", "Time:", ""))
                  )
                )
              ),
              column(
                4,
                div(
                  class = "no-lines",
                  textInput("fu_head_other", "Other (specify)", "")
                )
              )
            )
          )
        )
      ),

      ## Neck Surgery

      fluidRow(
        column(6,
               div(
                 class = "q-row",
                 div(class = "q-text", "Neck Surgery"),
               )

        ),
        column(6,
               div(
                 class = "q-opts",
                 radioButtons(
                   "fu_neck_surgeryperf",
                   label = NULL,
                   choices = c("Yes" = "1", "No" = "0"),
                   selected = character(0),
                   inline = TRUE
                 )
               )
        )
      ),

      fluidRow(
        column(
          3,
          div(
            class = "no-lines",
            checkboxInput("fu_necksurgery_type___neck_exp", "Neck exploration", FALSE),
            tags$br(),
            tags$br(),
            checkboxInput("fu_necksurgery_type___broncho", "Bronchoscopy", FALSE),
            tags$br(),
            tags$br(),
            checkboxInput("fu_necksurgery_type___eso", "Esophagoscopy", FALSE)

          )
        ),

        column(
          9,
          div(
            class = "no-lines",
            fluidRow(
              column(
                8,
                div(
                  class = "no-lines",
                  fluidRow(
                    column(6, textInput("fu_neck_explo_date", "Date:", "")),
                    column(6, textInput("fu_neck_explo_time", "Time:", ""))
                  ),
                  # tags$br(),
                  fluidRow(
                    column(6, textInput("fu_bronch_surgery_date", "", "")),
                    column(6, textInput("fu_bronch_surgery_time", "", ""))
                  ),
                  fluidRow(
                    column(6, textInput("fu_esoph_surgery_date", "", "")),
                    column(6, textInput("fu_esoph_surgery_time", "", ""))
                  )
                )
              ),
              column(
                4,
                div(
                  class = "no-lines",
                  textInput("fu_neck_other", "specify reason", "")
                )
              )
            )
          )
        )
      ),

      ### Chest SUrgery
      ## ---- Chest Surgery ----

      fluidRow(
        column(6,
               div(class = "q-row",
                   div(class = "q-text", "Chest Surgery")
               )
        ),
        column(6,
               div(class = "q-opts",
                   radioButtons(
                     "fu_chest_surgeryperf",
                     label = NULL,
                     choices = c("Yes" = "1", "No" = "0"),
                     selected = character(0),
                     inline = TRUE
                   )
               )
        )
      ),

      fluidRow(
        column(
          3,
          div(
            class = "no-lines",
            tags$br(),
            checkboxInput("fu_chest_surgery___1", "Chest Tube", FALSE),
            tags$br(),
            checkboxInput("fu_chest_surgery___2", "Thoracentesis / drainage", FALSE),
            tags$br(),
            checkboxInput("fu_chest_surgery___3", "Thoracotomy", FALSE),
            tags$br(),tags$br(),
            checkboxInput("fu_chest_surgery___4", "Lung resection", FALSE),
            tags$br(),
            checkboxInput("fu_chest_surgery___5", "Vessel ligation", FALSE),
            tags$br(),
            checkboxInput("fu_chest_surgery___6", "Major Vascular Repair", FALSE),
            tags$br(),
            checkboxInput("fu_chest_surgery___7", "Other hemorrhage control", FALSE)
          )
        ),
        column(
          9,
          div(
            class = "no-lines",
            fluidRow(
              column(
                8,
                div(
                  class = "no-lines",
                  fluidRow(
                    column(6, textInput("fu_chesttube_surgery_date", "Date:", "")),
                    column(6, textInput("fu_chesttube_surgery_time", "Time:", ""))
                  ),
                  fluidRow(
                    column(6, textInput("fu_drainage_surgery_date", "", "")),
                    column(6, textInput("fu_drainage_surgery_time", "", ""))
                  ),
                  fluidRow(
                    column(6, textInput("fu_thora_surgery_date", "", "")),
                    column(6, textInput("fu_thora_surgery_time", "", ""))
                  ),
                  fluidRow(
                    column(6, textInput("fu_lungres_surgery_date", "", "")),
                    column(6, textInput("fu_lungres_surgery_time", "", ""))
                  ),
                  fluidRow(
                    column(6, textInput("fu_vessel_surgery_date", "", "")),
                    column(6, textInput("fu_vessel_surgery_time", "", ""))
                  ),
                  fluidRow(
                    column(6, textInput("fu_vascularmajor_surgery_date", "", "")),
                    column(6, textInput("fu_vascularmajor_surgery_time", "", ""))
                  ),
                  fluidRow(
                    column(6, textInput("fu_otherhem_surgery_date", "", "")),
                    column(6, textInput("fu_otherhem_surgery_time", "", ""))
                  )
                )
              ),
              column(
                4,
                div(
                  class = "no-lines",
                  textInput("fu_chest_other", "specify reason", "")
                )
              )
            )
          )
        )
      ),

      ## ---- Abdominal Surgery ----

      fluidRow(
        column(6,
               div(class = "q-row",
                   div(class = "q-text", "Abdominal Surgery")
               )
        ),
        column(6,
               div(class = "q-opts",
                   radioButtons(
                     "fu_abdominal_surgeryperf",
                     label = NULL,
                     choices = c("Yes" = "1", "No" = "0"),
                     selected = character(0),
                     inline = TRUE
                   )
               )
        )
      ),

      fluidRow(
        column(
          3,
          div(
            class = "no-lines tight-input",
            tags$br(),
            checkboxInput("fu_abdominal_surgery___1", "Exploratory laparotomy", FALSE),
            tags$br(),
            checkboxInput("fu_abdominal_surgery___2", "Bowel resection / repair", FALSE),
            tags$br(),
            checkboxInput("fu_abdominal_surgery___3", "Diversion / Ostomy", FALSE),
            tags$br(),
            checkboxInput("fu_abdominal_surgery___4", "Liver repair", FALSE),
            tags$br(),
            checkboxInput("fu_abdominal_surgery___5", "Splenectomy", FALSE),
            tags$br(),
            checkboxInput("fu_abdominal_surgery___6", "Vascular repair", FALSE),
            tags$br(),
            checkboxInput("fu_abdominal_surgery___7", "Pancreatic repair", FALSE)
          )
        ),
        column(
          9,
          div(
            class = "no-lines tight-input",
            fluidRow(
              column(
                8,
                div(
                  class = "no-lines tight-input",
                  fluidRow(
                    column(6, textInput("fu_lapar_surgery_date", "Date:", "")),
                    column(6, textInput("fu_lapar_surgery_time", "Time:", ""))
                  ),
                  fluidRow(
                    column(6, textInput("fu_bowel_surgery_date", "", "")),
                    column(6, textInput("fu_bowel_surgery_time", "", ""))
                  ),
                  fluidRow(
                    column(6, textInput("fu_ostomy_surgery_date", "", "")),
                    column(6, textInput("fu_ostomy_surgery_time", "", ""))
                  ),
                  fluidRow(
                    column(6, textInput("fu_liver_surgery_date", "", "")),
                    column(6, textInput("fu_liver_surgery_time", "", ""))
                  ),
                  fluidRow(
                    column(6, textInput("fu_splene_surgery_date", "", "")),
                    column(6, textInput("fu_splene_surgery_time", "", ""))
                  ),
                  fluidRow(
                    column(6, textInput("fu_vascular_surgery_date", "", "")),
                    column(6, textInput("fu_vascular_surgery_time", "", ""))
                  ),
                  fluidRow(
                    column(6, textInput("fu_pancreatic_surgery_date", "", "")),
                    column(6, textInput("fu_pancreatic_surgery_time", "", ""))
                  )
                )
              ),
              column(
                4,
                div(
                  class = "no-lines",
                  textInput("fu_abdominal_other", "specify reason", "")
                )
              )
            )
          )
        )
      ),

      ## ---- Orthopedic Surgery ----

      fluidRow(
        column(6,
               div(class = "q-row",
                   div(class = "q-text", "Orthopedic Surgery")
               )
        ),
        column(6,
               div(class = "q-opts",
                   radioButtons(
                     "fu_ortho_surgeryperf",
                     label = NULL,
                     choices = c("Yes" = "1", "No" = "0"),
                     selected = character(0),
                     inline = TRUE
                   )
               )
        )
      ),

      fluidRow(
        column(
          3,
          div(
            class = "no-lines",
            tags$br(),
            checkboxInput("fu_ortho_surgery___1", "Osteosynthesis", FALSE),
            tags$br(),
            checkboxInput("fu_ortho_surgery___2", "Amputation", FALSE),
            tags$br(),
            checkboxInput("fu_ortho_surgery___3", "External Fixation", FALSE),
            tags$br(), tags$br(),
            checkboxInput("fu_ortho_surgery___4", "Open Reduction / ORIF", FALSE),
            tags$br(),
            checkboxInput("fu_ortho_surgery___5", "Tendinoplasty", FALSE)
          )
        ),
        column(
          9,
          div(
            class = "no-lines",
            fluidRow(
              column(
                8,
                div(
                  class = "no-lines",
                  fluidRow(
                    column(6, textInput("fu_osteo_surgery_date", "Date:", "")),
                    column(6, textInput("fu_osteo_surgery_time", "Time:", ""))
                  ),
                  fluidRow(
                    column(6, textInput("fu_amp_surgery_date", "", "")),
                    column(6, textInput("fu_amp_surgery_time", "", ""))
                  ),
                  fluidRow(
                    column(6, textInput("fu_fix_surgery_date", "", "")),
                    column(6, textInput("fu_fix_surgery_time", "", ""))
                  ),
                  fluidRow(
                    column(6, textInput("fu_reduct_surgery_date", "", "")),
                    column(6, textInput("fu_reduct_surgery_time", "", ""))
                  ),
                  fluidRow(
                    column(6, textInput("fu_tendin_surgery_date", "", "")),
                    column(6, textInput("fu_tendin_surgery_time", "", ""))
                  )
                )
              ),
              column(
                4,
                div(
                  class = "no-lines",
                  textInput("fu_ortho_other", "specify reason", "")
                )
              )
            )
          )
        )
      ),
      ## ---- Vascular Surgery ----

      fluidRow(
        column(6,
               div(class = "q-row",
                   div(class = "q-text", "Vascular Surgery")
               )
        ),
        column(6,
               div(class = "q-opts",
                   radioButtons(
                     "fu_vascular_surgeryperf",
                     label = NULL,
                     choices = c("Yes" = "1", "No" = "0"),
                     selected = character(0),
                     inline = TRUE
                   )
               )
        )
      ),

      fluidRow(
        column(
          3,
          div(
            class = "no-lines",
            checkboxInput("fu_vascular_surgery___1", "Arterial / Venous Ligation", FALSE),
            tags$br(), tags$br(),
            checkboxInput("fu_vascular_surgery___2", "Arterial / Venous Repair", FALSE)
          )
        ),
        column(
          9,
          div(
            class = "no-lines",
            fluidRow(
              column(
                8,
                div(
                  class = "no-lines",
                  fluidRow(
                    column(6, textInput("fu_liga_surgery_date", "Date:", "")),
                    column(6, textInput("fu_liga_surgery_time", "Time:", ""))
                  ),
                  fluidRow(
                    column(6, textInput("fu_repair_surgery_date", "", "")),
                    column(6, textInput("fu_repair_surgery_time", "", ""))
                  )
                )
              ),
              column(
                4,
                div(
                  class = "no-lines",
                  textInput("fu_vascular_other", "specify reason", "")
                )
              )
            )
          )
        )
      ),
      ## ---- Urogenital Surgery ----

      fluidRow(
        column(6,
               div(class = "q-row",
                   div(class = "q-text", "Urogenital Surgery")
               )
        ),
        column(6,
               div(class = "q-opts",
                   radioButtons(
                     "fu_uro_surgeryperf",
                     label = NULL,
                     choices = c("Yes" = "1", "No" = "0"),
                     selected = character(0),
                     inline = TRUE
                   )
               )
        )
      ),

      fluidRow(
        column(
          3,
          div(
            class = "no-lines",
            tags$br(),
            checkboxInput("fu_uro_surgery___1", "Cystoscopy", FALSE),
            tags$br(),
            checkboxInput("fu_uro_surgery___2", "Repair of urethra / bladder / ureters", FALSE),
            tags$br(),
            checkboxInput("fu_uro_surgery___3", "Cesarean section", FALSE),
            tags$br(),
            checkboxInput("fu_uro_surgery___4", "D&C / Manual Aspiration", FALSE),
            tags$br(),
            checkboxInput("fu_uro_surgery___5", "Repair of internal / external genitalia", FALSE)
          )
        ),
        column(
          9,
          div(
            class = "no-lines",
            fluidRow(
              column(
                8,
                div(
                  class = "no-lines",
                  fluidRow(
                    column(6, textInput("fu_cysto_surgery_date", "Date:", "")),
                    column(6, textInput("fu_cysto_surgery_time", "Time:", ""))
                  ),
                  fluidRow(
                    column(6, textInput("fu_uro_surgery_date", "", "")),
                    column(6, textInput("fu_uro_surgery_time", "", ""))
                  ),
                  fluidRow(
                    column(6, textInput("fu_c_section_surgery_date", "", "")),
                    column(6, textInput("fu_c_section_surgery_time", "", ""))
                  ),
                  fluidRow(
                    column(6, textInput("fu_d_c_surgery_date", "", "")),
                    column(6, textInput("fu_d_c_surgery_time", "", ""))
                  ),
                  fluidRow(
                    column(6, textInput("fu_int_ext_genital_surgery_date", "", "")),
                    column(6, textInput("fu_int_ext_genital_surgery_time", "", ""))
                  )
                )
              ),
              column(
                4,
                div(
                  class = "no-lines",
                  textInput("fu_uro_other", "specify reason", "")
                )
              )
            )
          )
        )
      ),

      ## ---- Soft Tissue Surgery ----

      fluidRow(
        column(6,
               div(class = "q-row",
                   div(class = "q-text", "Soft Tissue Surgery")
               )
        ),
        column(6,
               div(class = "q-opts",
                   radioButtons(
                     "fu_soft_surgeryperf",
                     label = NULL,
                     choices = c("Yes" = "1", "No" = "0"),
                     selected = character(0),
                     inline = TRUE
                   )
               )
        )
      ),

      fluidRow(
        column(
          3,
          div(
            class = "no-lines",
            checkboxInput("fu_soft_surgery___1", "Debridement", FALSE),
            tags$br(), tags$br(),
            checkboxInput("fu_soft_surgery___2", "Complex Suture Repair", FALSE),
            tags$br(), tags$br(),
            checkboxInput("fu_soft_surgery___3", "Skin Graft", FALSE)
          )
        ),
        column(
          9,
          div(
            class = "no-lines",
            fluidRow(
              column(
                8,
                div(
                  class = "no-lines",
                  fluidRow(
                    column(6, textInput("fu_debride_surgery_date", "Date:", "")),
                    column(6, textInput("fu_debride_surgery_time", "Time:", ""))
                  ),
                  fluidRow(
                    column(6, textInput("fu_suture_surgery_date", "", "")),
                    column(6, textInput("fu_suture_surgery_time", "", ""))
                  ),
                  fluidRow(
                    column(6, textInput("fu_graft_surgery_date", "", "")),
                    column(6, textInput("fu_graft_surgery_time", "", ""))
                  )
                )
              ),
              column(
                4,
                div(
                  class = "no-lines",
                  textInput("fu_soft_other", "specify reason", "")
                )
              )
            )
          )
        )
      ),

      ## ---- Other procedure & Surgery note ----
      fluidRow(
        column(
          6,
          div(
            class = "q-row",
            div(class = "q-text", "Other")
          )
        ),
        column(
          6,
          div(
            class = "q-opts",
            radioButtons(
              "fu_other_otherprocedure",     # uses your dataset column
              label = NULL,
              choices = c("Yes" = "1", "No" = "0"),
              selected = character(0),
              inline = TRUE
            )
          )
        )
      ),

      # Row 2: left = procedure type; right = performed + date/time + no reason
      fluidRow(
        column(
          3,
          div(
            class = "no-lines",
            textInput("fu_specify_otherprocedure", "(specify)", "")          )
        ),

        column(
          9,
          div(
            class = "no-lines",
            fluidRow(
              column(
                8,
                div(
                  class = "no-lines",
                  fluidRow(
                    column(6, textInput("", "Date:", "")),
                    column(6, textInput("", "Time:", ""))
                  )
                )
              ),
              column(
                4,
                div(
                  class = "no-lines",
                  textInput("surx_note", "Other (specify)", "")
                )
              )
            )
          )
        )
      )
  )
  )
