
fluidRow(
  tags$div(style="overflow-x:auto; width:100%;",
           tags$table(class="table table-bordered table-sm",
                      style="width:100%;
                                            background-color:white;
                                            color:black;
                                            border-color:black;
                                            text-align:center;
                                            table-layout: fixed;
                                            border-collapse: collapse;
                                            border-spacing: 0;
                                          ",
                      # Header row
                      tags$thead(
                        tags$tr(
                          tags$th("Radiology Matrix",
                                  style="width:120px; background-color:#f0f0f0; color:black; border:1px solid black; padding:2px; font-size:12px; text-align:left;"),
                          lapply(c("Head","Neck","Chest","Abd.","Spine","Pelvis Obs","Pelvis UroG","Pelvis Other","LUE","RUE","LLE","RLE","Vascular"), function(region){
                            tags$th(region, style="width:60px; border:1px solid black; background-color:#f0f0f0; color:black;
                                   padding:2px; font-size:12px; text-align:center;")
                          })
                        )
                      ),

                      # Rows for modalities
                      tags$tbody(
                        lapply(c("X-ray","Ultrasound","CT Scan","MRI"), function(modality){
                          tags$tr(
                            tags$td(modality,
                                    style="width:120px; border:1px solid black; background-color:#f0f0f0; color:black; text-align:left; padding:2px; font-size:12px; white-space:nowrap;"),
                            lapply(c("head","neck","chest","abd","spine",
                                     "pelvis_obs","pelvis_uro","pelvis_other",
                                     "lue","rue","lle","rle","vasc"), function(region){
                                       inputId <- paste0("radio_", gsub(" ", "", tolower(modality)), "_", region)
                                       tags$td(
                                         style="width:60px; border:1px solid black; background-color:white; color:black; text-align:center; padding:2px;",
                                         numericInput(inputId, label = NULL, value = NA, min = 0, max = 6, step = 1, width = "60px")
                                       )
                                     })
                          )
                        })
                      )
           )
  )
),

fluidRow(
  column(12,
         textInput(
           "diagnostic_notperformed",
           label = NULL,
           value = NA
         ),
         textInput("diagnostic_notperformed_other", "Other (specify)", width = "300px")
  )
),

fluidRow(class="tight-row",

         column(12,

                tags$div(style="overflow-x:auto; width:100%;",
                         tags$table(class = "table table-bordered table-sm",
                                    style="width:100%; table-layout: fixed; font-size:10; background-color:white; border-collapse:collapse; text-align:center;",

                                    # Header
                                    tags$thead(
                                      tags$tr(
                                        tags$th("Consultants", style="width:20%; font-size:10; text-align:left; background-color:#ccc;"),
                                        tags$th("Recommended?", style="width:15%; font-size:10;"),
                                        tags$th("Called?", style="width:10%; font-size:10;"),
                                        tags$th("*If called, Date and Time", colspan=2, style="width:20%; font-size:10;"),
                                        tags$th("Arrived?", style="width:10%; font-size:10;"),
                                        tags$th("*If arrived, Date and Time", colspan=2, style="width:20%; font-size:10;")
                                      )
                                    ),

                                    # Consultant rows
                                    tags$tbody(
                                      lapply(c("General/Visceral Surgery",
                                               "Orthopedic/Trauma Surgery",
                                               "Neurosurgery",
                                               "Vascular",
                                               "ENT",
                                               "Plastic Surgery",
                                               "Other specialist (Specify):"), function(spec){
                                                 id <- gsub("[^A-Za-z]", "", tolower(spec))
                                                 tags$tr(
                                                   tags$td(spec, style="text-align:left; background-color:#eee;"),

                                                   # Recommended Radio button
                                                   tags$td(radioButtons(paste0(id, "_rec"), NULL, choices=c("Yes", "No"), selected = character(0) ,inline=TRUE)),

                                                   # Called Radio button
                                                   tags$td(radioButtons(paste0(id, "_call"), NULL, choices=c("Yes", "No"), selected = character(0), inline=FALSE)),

                                                   # Called Date and Time
                                                   tags$td(textInput(paste0(id, "_call_date"), "Date:", width="120px")),
                                                   tags$td(textInput(paste0(id, "_call_time"), "Time (24hr):", width="120px")),

                                                   # Arrived Radio button
                                                   tags$td(radioButtons(paste0(id, "_arr"), NULL, choices=c("Yes", "No"), selected = character(0), inline=TRUE)),
                                                   # Arrived Date and Time
                                                   tags$td(textInput(paste0(id, "_arr_date"), "Date:", width="120px")),
                                                   tags$td(textInput(paste0(id, "_arr_time"), "Time (24hr):", width="120px"))
                                                 )
                                               })
                                    )
                         )
                )

         )),

fluidRow(
  # Left Column (Medications/Sedation + Procedures)
  column(width = 7,  # ~65%
         tags$div(style="overflow-x:auto; width:100%;",
                  tags$table(class = "table table-bordered table-sm",
                             style="width:100%; table-layout: fixed; font-size:12px; background-color:white; border-collapse:collapse; text-align:center;",

                             # Header Row
                             tags$thead(
                               tags$tr(
                                 tags$th("Medications/Sedation & Procedures", style="width:30%; text-align:left; background-color:#ccc;"),
                                 tags$th("Recommended?", style="width:15%;"),
                                 tags$th("Received?", style="width:15%;"),
                                 tags$th("If received, time (hh:mm)", style="width:20%;"),
                                 tags$th("If recommended but NOT received, why?", style="width:20%;")
                               )
                             ),

                             # Rows for Medications and Procedures
                             tags$tbody(
                               lapply(c("Analgesic",
                                        "Anticoagulant/ blood thinner",
                                        "Antitetanus",
                                        "Antibiotic (specify):",
                                        "Fluid–Crystalloid",
                                        "Fluid–Colloid",
                                        "Blood",
                                        "Tranexamic Acid",
                                        "PPI or H2–Blocker",
                                        "Other (specify):",
                                        "Splint/Cast/Sling",
                                        "External Reduction",
                                        "Debridement/Foreign Body Removal/Laceration Repair",
                                        "Nasogastric Tube Placement",
                                        "Urinary Catheter Placement"), function(item){
                                          id <- gsub("[^A-Za-z]", "", tolower(item))
                                          tags$tr(
                                            tags$td(item, style="text-align:left; background-color:#eee;"),
                                            tags$td(radioButtons(paste0(id,"_rec"), NULL, choices=c("Yes","No"), selected = character(0), inline=TRUE)),
                                            tags$td(radioButtons(paste0(id,"_recvd"), NULL, choices=c("Yes","No"), selected = character(0), inline=TRUE)),
                                            tags$td(textInput(paste0(id,"_time"), NULL, placeholder="hh:mm", width="100%")),
                                            tags$td(textInput(paste0(id,"_why_not"),
                                                              NULL,
                                                              value = NA,
                                                              width="100%"))
                                          )
                                        })
                             )
                  )
         )
  ),

  # Right Column (~35%)
  column(width = 5,
         # Top Fluidrow - Labs
         fluidRow(
           tags$div(style="overflow-x:auto; width:100%; margin-bottom:10px;",
                    tags$table(class = "table table-bordered table-sm",
                               style="width:100%; table-layout: fixed; font-size:12px; background-color:white; border-collapse:collapse; text-align:center;",

                               tags$thead(
                                 tags$tr(
                                   tags$th("Labs", style="width:30%; text-align:left; background-color:#ccc;"),
                                   tags$th("Recommended", style="width:20%;"),
                                   tags$th("Performed", style="width:20%;"),
                                   tags$th("Result", style="width:30%;")
                                 )
                               ),

                               tags$tbody(
                                 tags$tr(
                                   tags$td("Urine Pregnancy Test", style="text-align:left; background-color:#eee;"),
                                   tags$td(radioButtons("lab_urine_rec", NULL, choices=c("Yes","No","Known Pregnant"), selected = character(0), inline=FALSE)),
                                   tags$td(radioButtons("lab_urine_perf", NULL, choices=c("Yes","No"), selected = character(0), inline=TRUE)),
                                   tags$td(radioButtons("lab_urine_res", NULL, choices=c("Negative","Positive"), selected = character(0), inline=FALSE))
                                 ),
                                 tags$tr(
                                   tags$td("HGB", style="text-align:left; background-color:#eee;"),
                                   tags$td(radioButtons("lab_hgb_rec", NULL, choices=c("Yes","No"), selected = character(0), inline=FALSE)),
                                   tags$td(radioButtons("lab_hgb_perf", NULL, choices=c("Yes","No"), selected = character(0), inline=FALSE)),
                                   tags$td("") # no result for HGB in screenshot
                                 ),
                                 tags$tr(
                                   tags$td("Blood Group", style="text-align:left; background-color:#eee;"),
                                   tags$td(radioButtons("lab_bg_rec", NULL, choices=c("Yes","No"), selected = character(0), inline=FALSE)),
                                   tags$td(radioButtons("lab_bg_perf", NULL, choices=c("Yes","No"), selected = character(0), inline=FALSE)),
                                   tags$td(selectInput("lab_bg_res", NULL, choices=c("A","B","AB","O"), width="100%", selected = NA))
                                 )
                               )
                    )
           )
         ),

         # Bottom Fluidrow - Disposition
         fluidRow(
           tags$div(style="overflow-x:auto; width:100%;",
                    tags$table(class = "table table-bordered table-sm",
                               style="width:100%; table-layout: fixed; font-size:12px; background-color:white; border-collapse:collapse; text-align:center;",

                               tags$thead(
                                 tags$tr(
                                   tags$th("Disposition", colspan=2, style="text-align:left; background-color:#ccc;")
                                 )
                               ),

                               tags$tbody(
                                 tags$tr(
                                   tags$td("Date", style="width:30%; text-align:left;"),
                                   tags$td(textInput("disp_date", NULL, placeholder="DD/MM/YYYY", width="100%"))
                                 ),
                                 tags$tr(
                                   tags$td("Time (24HR format)", style="text-align:left;"),
                                   tags$td(textInput("disp_time", NULL, placeholder="HH:MM", width="100%"))
                                 ),
                                 tags$tr(
                                   tags$td("Disposition", colspan=2,
                                           tags$div(style="text-align:left; padding:20px;",
                                                    checkboxGroupInput("disp_opts", NULL,
                                                                       choices=c("Discharged home to die"=0,
                                                                                 "Emergency ward observation"=1,
                                                                                 "Admitted to ward"=2,
                                                                                 "Admitted to ICU"=3,
                                                                                 "Directly to OR"=4,
                                                                                 "Died"=5,
                                                                                 "Left AMA"=6,
                                                                                 "Transferred"=7,
                                                                                 "Unknown"=99),
                                                                       inline=FALSE)))
                                 ),
                                 tags$tr(
                                   tags$td("Transfer reason", colspan=2,
                                           tags$div(style="text-align:left; padding:20px;",
                                                    checkboxGroupInput("transfer_reason", NULL,
                                                                       choices=c("Cost"=0,
                                                                                 "Higher Care"=1,
                                                                                 "Preference"=2,
                                                                                 "Other (specify)"=98,
                                                                                 "Unknown"=99),
                                                                       inline=FALSE))
                                   )
                                 )
                               )
                    )
           )
         )
  )
)




)
