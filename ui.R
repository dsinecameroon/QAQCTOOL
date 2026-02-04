library(shiny)
library(shinyTime)
library(ctrdata)
library(readxl)
source("functions.R")
library(tidyr)
library(shinyjs)


api_url = "https://rc.dsineafricaub.org/api/"

transfer_choices <- c("No" = 0, "Yes" = 1, "Unknown" = 99)

transfer_reason_choices <- c(
  "Increased Level of Care" = 0,
  "Patient Preference" = 1,
  "Other, specify" = 98,
  "Unknown" = 99
)

specs <- c("General/Visceral Surgery",
           "Orthopedic/Trauma Surgery",
           "Neurosurgery",
           "Vascular",
           "ENT",
           "Plastic Surgery",
           "Other specialist (Specify):")

ids <- c("gensurg","ortho","neuro","vasc","ent","plastic","other")


specs_med <- c(
  "Analgesic",
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
  "Urinary Catheter Placement"
)

ids_med <- c(
  "treat_analgesic",
  "treat_anticoagulant",
  "treat_antitetanus",
  "treat_antibiotic",
  "treat_crystalloid",
  "treat_colloid",
  "treat_blood",
  "treat_tranexacid",
  "treat_ppi",
  "treat_other",
  "treat_split",
  "treat_reduct",
  "treat_debride",
  "treat_nasogastric",
  "treat_catheter"
)


ui <- fluidPage(

  useShinyjs(),

  # 🔹 Add CSS here
  tags$style(HTML("
    .section-title {
      background-color: black;
      color: white;
      padding: 6px;
      font-weight: bold;
      margin-bottom: 10px;
    }

        /* strip borders/box lines for anything inside .no-lines */
    .no-lines,
    .no-lines * {
      border: none !important;
      box-shadow: none !important;
    }

    /* keep input borders (so your text boxes still look normal) */
    .no-lines input.form-control,
    .no-lines textarea.form-control,
    .no-lines select.form-control {
      border: 1px solid #ccc !important;
      box-shadow: none !important;
      background: #fff !important;
    }

        /* Reduce vertical spacing between stacked Shiny inputs */
    .tight-input .form-group {
      margin-bottom: 4px !important;   /* default is ~15px */
    }

    /* Align checkbox rows with input rows */
    .tight-row {
      display: flex;
      align-items: center;
      min-height: 38px;  /* matches textInput height */
    }

    /* Optional: slightly reduce input height */
    .tight-input input.form-control {
      height: 34px;
    }



        /* ---- Add these rules (question row layout) ---- */
      .q-row {
        display: flex;
        align-items: center;
        justify-content: space-between;
        gap: 12px;
        padding: 5px 5px;
      }

      .q-row .q-text {
        font-weight: 600;
        flex: 1;
        margin-right: 0;
        border:0;
      }

      .q-row .q-opts {
        display: flex;
        align-items: center;
        justify-content: flex-end;
      }

      .q-row .q-opts .radio-inline {
        margin-right: 10px;
      }

      .q-row .q-opts .radio-inline:last-child {
        margin-right: 0;
      }
    /*End of q-row */

      input[type='text'] {
    padding: 0px 2px !important;  /* minimal inner spacing */
    margin: 0px !important;       /* remove outer spacing */
    box-sizing: border-box;       /* makes width include borders */
    text-align: center;
    font-size:14;
  }

# table {
#   table-layout: fixed;
#   width: 100%;
#   border-collapse: collapse;
# }

# table th, table td {
#   padding: 0 !important;
#   margin: 0 !important;
#   text-align: center;
#   width: 25px; /* same for all columns */
#   height: 25px;
# }
#
# table th:first-child, table td:first-child {
#   width: 120px !important; /* fixed width for Injury Matrix column */
#   text-align: left;
# }

# table input[type='checkbox'] {
#   margin: 0 auto !important; /* perfectly center checkboxes */
#   padding: 0 !important;
#   display: block;
#   width: 12px;
#   height: 12px;
# }


    .container-fluid {
      padding-left: 5px;
      padding-right: 5px;
    }

    .container-fluid .row {
      margin-left: 2px;
      margin-right: 2px;
      border: 1px solid black;
      padding-left: 5px;
      padding-right: 5px;
    }

  .tight-row {
    margin-left: 5 !important;
    margin-right: 5 !important;
  }
  .tight-row > [class*='col-'] {
    padding-left: 5px !important;
    padding-right: 5px !important;
  }

    background-color: black;
      color: white;
      padding: 6px;
      font-weight: bold;
      margin-bottom: 10px;
    }
    .boxed {
      border: 1px solid #ccc;
      padding: 10px;
      font-size: 12px;
      margin-bottom: 10px;
    }
      .boxed .shiny-options-group label {
    font-size: 12px;   /* Adjust size */
    line-height: 1.2;
  }
      .boxed .control-label {
    font-size: 13px;   /* Question titles */
    font-weight: bold;
      }

    .shiny-options-group label {
    font-size: 12px;
    padding: 2px 0;
  }
  .radio-inline, .checkbox-inline {
    margin-right: 20px;
    marging-left:20px;
    white-space:nowrap;}
  ")),

  titlePanel("National Trauma Registry - Data Entry Form"),

  fluidRow(
    column(2, fileInput("upload_ids", "Upload Patient List (.csv or .xlsx)", accept = c(".csv", ".xlsx"))),
    column(2, fileInput("upload_rc_key", "RedCap Token (.rds)", accept = c(".rds"))),
    column(2, selectInput("select_ctr_id", "Select REDCap ID", choices = "", selected = "")),
    # column(2, radioButtons("data_mode", "Data Load:", choices = c("Online"=1, "Offline"=0), inline = TRUE)),
    # column(2, radioButtons("show_fu_tabs", "Follow-Up On", choices = c("No"=0, "Yes"=1), selected = 0, inline = TRUE)),
    column(2, actionButton("load_record", "Load Record"),actionButton("prev_id", "◀ Previous"), actionButton("next_id", "Next ▶")),
    column(2, actionButton("submit", "Update Record", class = "btn-primary"))
  ),

  fluidRow(
    column(6,
           tabsetPanel(
             tabPanel("CTR Page 1",

                      fluidRow(
                        column(4, textInput("patientname", "Patient Name")),
                        column(2, textInput("patient_ctr_id", "Patient ID")),
                        column(2, textInput("site_id", "Hospital ID")),
                        column(2, textInput("phonenumber", "Phone")),
                        column(2, textInput("phonenumber_2", "Alt. Phone"))
                      ),
                      fluidRow(

                      ),
                      fluidRow(
                        column(3, dateInput("arrivaldate", "Arrival Date", value = "")),
                        column(3, textInput("arrivaltime", "Arrival Time")),
                        column(3, radioButtons("transfer", "Transfered", choices = c("No" = 0, "Yes" = 1, "Unknown" = 99), selected="", inline = TRUE)),
                        column(3, checkboxGroupInput("transferreason", "Transfer Reason", choices = transfer_reason_choices))
                      ),

                      ## Stating the section
                      div(class = "section-title", "DEMOGRAPHICS"),

                      # 🔹 Row 1: Age, Sex, Marital Status
                      fluidRow(
                        column(2, textInput("age", "Age (years):", value = "")),
                        column(3, radioButtons("sex", "Sex", choices = c("Female" = 0, "Male" = 1), selected="", inline = TRUE)),
                        column(7, radioButtons("marital_status", "Marital status",
                                               choices = c("Single" = 0, "Living with partner" = 1,
                                                           "Married" = 2, "Divorced/separated" = 3,
                                                           "Widowed" = 4, "Unknown" = 99), selected="", inline = TRUE))
                      ),

                      # 🔹 Row 2: Education and Household
                      fluidRow(
                        column(4,
                               div(class = "boxed",

                               )
                        ),
                        column(12,
                               div(class = "boxed",
                                   fluidRow(
                                     column(2,
                                            radioButtons("education", "Education",
                                                         choices = c("No formal education" = 0,
                                                                     "Primary School" = 1,
                                                                     "Secondary/High School" = 2,
                                                                     "University" = 3,
                                                                     "Other (Specify)" = 98,
                                                                     "Unknown" = 99),
                                                         selected=""
                                            )
                                     ),
                                     column(2,
                                            radioButtons("urban", "Is the household?",
                                                         choices = c("Rural" = 0, "Urban" = 1, "Unknown" = 99),
                                                         selected="",
                                                         inline = FALSE   # vertical options
                                            )
                                     ),
                                     column(2,
                                            radioButtons("cellphone", "Does anyone in your household own a cellphone?",
                                                         choices = c("No" = 0, "Yes" = 1, "Unknown" = 99),
                                                         selected="",
                                                         inline = FALSE
                                            )
                                     ),
                                     column(1,
                                            radioButtons("tv", "Does your household have: A television",
                                                         choices = c("No" = 0, "Yes" = 1, "Unknown" = 99),
                                                         selected="",
                                                         inline = FALSE
                                            )
                                     ),
                                     column(2,
                                            radioButtons("cable", "Cable TV or satellite",
                                                         choices = c("No" = 0, "Yes" = 1, "Unknown" = 99),
                                                         selected="",
                                                         inline = FALSE
                                            )
                                     ),
                                     column(1,
                                            radioButtons("mixer", "A Mixer",
                                                         choices = c("No" = 0, "Yes" = 1, "Unknown" = 99),
                                                         selected="",
                                                         inline = FALSE
                                            )
                                     ),
                                     column(2,
                                            radioButtons("fuel", "Type of cooking fuel primarily used in household",
                                                         choices = c("Wood" = "wood", "Charcoal" = "charcoal",
                                                                     "LPG (Liquid Petroleum Gas)" = "lpg",
                                                                     "Kerosene" = "kerosene",
                                                                     "N/A" = "Not applicable",
                                                                     "Other (Specify)" = "other"),
                                                         selected="",
                                                         inline = FALSE
                                            )
                                     )
                                   ),

                                   # 🔹 Row 3: Occupation
                                   fluidRow(column(2,
                                                   radioButtons("education_complete", "Did the patient complete that level of schooling?",
                                                                choices = c("No/Incomplete" = 0,
                                                                            "Yes/Complete" = 1,
                                                                            "Unknown" = 99), selected="")),
                                            column(10,
                                                   div(class = "boxed",
                                                       radioButtons("occupation", "Occupation (select one)",
                                                                    choices = c("Professional/technical/managerial" = 0,
                                                                                "Clerical/administrative" = 1,
                                                                                "Sales" = 2,
                                                                                "Services" = 3,
                                                                                "Farmer/Agricultural Worker" = 4,
                                                                                "Skilled manual labor" = 5,
                                                                                "Unskilled manual labor" = 6,
                                                                                "Unemployed (able to work)" = 7,
                                                                                "Unemployed (unable to work)" = 8,
                                                                                "Housewife" = 9,
                                                                                "Student" = 10,
                                                                                "Retired" = 11,
                                                                                "Other (Specify)" = 98,
                                                                                "Unknown" = 99),
                                                                    selected="",
                                                                    inline = TRUE)
                                                   )

                                            ))
                               )
                        )
                      ),

                      # 🔹 Title Bar
                      div(class = "section-title", "PATIENT MEDICAL HISTORY"),

                      fluidRow(
                        column(4,
                               div(class = "boxed",
                                   checkboxGroupInput("medicalhx", "Select all that apply",
                                                      choices = c(
                                                        "No active problems" = 0,
                                                        "Active acute illness" = 1,
                                                        "Chronic illness*" = 2,
                                                        "Mental/psychiatric illness" = 3,
                                                        "Prior surgery (specify)" = 4,
                                                        "Unknown: Patient cannot respond and no family present" = 5
                                                      ), selected=""
                                   )
                               )
                        ),
                        column(8,
                               div(class = "boxed",
                                   checkboxGroupInput("medicalhx_chronic", "*If chronic illness, select all that apply",
                                                      choices = c(
                                                        "Diabetes – insulin dependent" = 0,
                                                        "Diabetes – not insulin dependent" = 1,
                                                        "Hypertension" = 2,
                                                        "HIV/AIDS (on ART)" = 3,
                                                        "HIV/AIDS (not on ART)" = 4,
                                                        "Liver Diseases/Cirrhosis" = 5,
                                                        "Stroke/TIA" = 6,
                                                        "Chronic Kidney Disease" = 7,
                                                        "Heart Disease (CHF, ischaemic or valve disease)" = 8,
                                                        "Cancer" = 9,
                                                        "Asthma/COPD" = 10,
                                                        "Epilepsy/convulsions" = 11,
                                                        "Other (Specify)" = 98
                                                      ), inline = TRUE
                                   )
                               )
                        )),

                      fluidRow(column(4,
                                      div(class = "boxed",
                                          radioButtons("pregnant", "Pregnant",
                                                       choices = c("No" = 0, "Yes" = 1, "Not applicable" = 97, "Unknown" = 99),
                                                       selected="",
                                                       inline = TRUE
                                          ))),
                               column(4, textInput("gest_age", "*If Yes, gestational age (Weeks)")),
                               column(4, dateInput("lmp", "Last Menstrual Period (LMP)", value = ""))
                      ),

                      fluidRow(
                        column(3,
                               div(class = "boxed",
                                   radioButtons("prior_injury", "Injury in the last 12 months requiring medical care?",
                                                choices = c("No" = 0, "Yes" = 1, "Unknown" = 99),
                                                selected=""
                                   ),
                                   radioButtons("prior_injury_violence", "*Was the injury violence-related?",
                                                choices = c("No" = 0, "Yes" = 1, "Unknown" = 99),
                                                selected=""
                                   )
                               )
                        ),
                        column(3,
                               div(class = "boxed",
                                   radioButtons("alcoholuse", "How often did the patient have six or more alcoholic drinks on one occasion in the past year?",
                                                choices = c(
                                                  "Never" = 0,
                                                  "Less than Monthly" = 1,
                                                  "Monthly" = 2,
                                                  "Weekly" = 3,
                                                  "Daily" = 4,
                                                  "Unknown" = 99
                                                ), selected="",
                                                inline = TRUE
                                   ),
                                   radioButtons("tobaccouse", "Does the patient smoke cigarettes/tobacco?",
                                                choices = c(
                                                  "Never" = 0,
                                                  "Current" = 1,
                                                  "Former/Quit" = 2,
                                                  "Unknown" = 99
                                                ), selected="",
                                                inline = TRUE
                                   )
                               )
                        ),
                        column(3,
                               div(class = "boxed",
                                   radioButtons("phq_depression", "In the last 2 weeks, how often has the patient: Had little interest or pleasure in doing things?",
                                                choices = c(
                                                  "Not at all" = 0,
                                                  "Several days" = 1,
                                                  "More than half of the days" = 2,
                                                  "Nearly every day" = 3,
                                                  "Unable to ask patient directly" = 99
                                                ), selected="",
                                                inline = TRUE
                                   ),
                                   radioButtons("phq_depression_2", "Felt down, depressed, or hopeless?",
                                                choices = c(
                                                  "Not at all" = 0,
                                                  "Several days" = 1,
                                                  "More than half of the days" = 2,
                                                  "Nearly every day" = 3,
                                                  "Unable to ask patient directly" = 99
                                                ), selected="",
                                                inline = TRUE
                                   )
                               )
                        ),
                        column(3,
                               div(class = "boxed",
                                   radioButtons("tetanus", "Tetanus Status: Has the patient received a tetanus shot in the last 5 years?",
                                                choices = c("No" = 0, "Yes" = 1, "Unknown" = 99),
                                                selected=""
                                   ),
                                   radioButtons("tetanus_wound", "Did the current injury involve a dirty, penetrating wound?",
                                                choices = c("No" = 0, "Yes" = 1, "Unknown" = 99),
                                                selected=""
                                   )
                               )
                        )
                      ),

                      fluidRow(column(12,

                                      radioButtons(
                                        inputId = "consentprovider",
                                        label = "Consent Provider",
                                        choices = c(
                                          "Patient" = 0,
                                          "Surrogate" = 1,
                                          "Minor" = 2,
                                          "Parent/Guardian" = 3
                                        ),
                                        selected = character(0),  # No default selection
                                        inline = TRUE
                                      )

                      ))

             ),

             tabPanel("CTR Page 2",

                      # ---- Context of Injury ----
                      fluidRow(
                        column(3, textInput("injurydate", "Date of Injury", value = NULL)),
                        column(3, textInput("injurytime", "Time of Injury (24H)", value = NULL)),
                        column(3, textInput("injury_health_area", "Health Area")),
                        column(3, textInput("traveldistance", "Distance to Hospital (km)", value = NULL))
                      ),

                      fluidRow(
                        column(3, textInput("injurytown", "Town/City")),
                        column(3, textInput("injury_district", "Health District")),
                        column(3, textInput("injury_neighborhood", "Neighborhood")),
                        column(3, textInput("injuryregion", "Region"))
                      ),

                      # ---- Injury Place and Activity ----
                      fluidRow(
                        column(6,
                               checkboxGroupInput("i_loc", "Injury Place",
                                                  choices = c(
                                                    "Private House/Home" = 0,
                                                    "Residential Institution" = 1,
                                                    "Medical Service Area" = 2,
                                                    "Street/Highway/Road" = 3,
                                                    "Railway Line/Station" = 4,
                                                    "Trade/Service Area" = 5,
                                                    "Industrial Construction Area" = 6,
                                                    "Farm/Place of Primary Production" = 7,
                                                    "Sea/Lake/River/Well/Other body of water" = 8,
                                                    "Sports/Athletic Area" = 9,
                                                    "School/Institution/Educational Area" = 10,
                                                    "Public/Administrative Area" = 11,
                                                    "Open/Land/Beach/Forest/Desert" = 12,
                                                    "Other (Specify)" = 98,
                                                    "Unknown" = 99
                                                  ),
                                                  selected = character(0),
                                                  inline = TRUE
                               )
                        ),
                        column(3,
                               radioButtons("i_activity", "Injury Activity",
                                            choices = c(
                                              "Work" = 0,
                                              "Education" = 1,
                                              "Sports" = 2,
                                              "Leisure/Play" = 3,
                                              "Traveling" = 4,
                                              "Domestic activity" = 5,
                                              "Other (Specify)" = 98,
                                              "Unknown" = 99
                                            ),
                                            selected = character(0)
                               )
                        ),
                        column(3,
                               radioButtons("i_alcohol_patient", "Patient consumed alcohol in 6 hours preceding injury?",
                                            choices = c("No" = 0, "Yes" = 1, "Unknown" = 99),
                                            selected = character(0),
                                            inline = TRUE
                               ),
                               radioButtons("i_alcohol_perpretrator", "Perpetrator/driver consumed alcohol?",
                                            choices = c("No" = 0, "Yes" = 1, "Unknown" = 99),
                                            selected = character(0),
                                            inline = TRUE
                               )
                        )
                      ),

                      # ---- Injury Mechanism ----
                      fluidRow(
                        column(12,
                               checkboxGroupInput("i_mechanism", "Mechanism",
                                                  choices = c(
                                                    "Road traffic injury (RTI)" = 0,
                                                    "Struck/hit by person/animal/object" = 1,
                                                    "Fall" = 2,
                                                    "Stab/Cut" = 3,
                                                    "Animal bite" = 4,
                                                    "Drowning/Submersion" = 5,
                                                    "Burn (smoke/fire/flames)" = 6,
                                                    "Scald" = 7,
                                                    "Poisoning" = 8,
                                                    "Suffocation/Choking/Hanging" = 9,
                                                    "Electrocution" = 10,
                                                    "Firearm/Gunshot" = 11,
                                                    "Explosive Blast" = 12,
                                                    "Other (Specify)" = 98,
                                                    "Unknown" = 99
                                                  ),
                                                  selected = character(0),
                                                  inline = TRUE
                               )
                        )
                      ),

                      # ---- Safety Equipment ----
                      fluidRow(
                        column(12,
                               column(2,
                                      radioButtons("i_rtirole_patient", "If RTI, specify role of patient",
                                                   choices = c(
                                                     "None" = 0,
                                                     "Pedestrian" = 1,
                                                     "Private Car" = 2,
                                                     "Taxi" = 3,
                                                     "Motorcycle" = 4,
                                                     "Mototaxi" = 5,
                                                     "Truck" = 6,
                                                     "Minivan or Minibus" = 7,
                                                     "Bus" = 8,
                                                     "Train" = 9,
                                                     "Other (Specify)" = 98,
                                                     "Unknown" = 99
                                                   ),
                                                   selected = character(0)
                                      )),
                               column(2,
                                      radioButtons("i_counterpart", "Role of counterpart",
                                                   choices = c(
                                                     "None" = 0,
                                                     "Pedestrian" = 1,
                                                     "Private Car" = 2,
                                                     "Taxi" = 3,
                                                     "Motorcycle" = 4,
                                                     "Mototaxi" = 5,
                                                     "Truck" = 6,
                                                     "Minivan or Minibus" = 7,
                                                     "Bus" = 8,
                                                     "Train" = 9,
                                                     "Other (Specify)" = 98,
                                                     "Unknown" = 99
                                                   ),
                                                   selected = character(0)
                                      )),
                               column(8,
                                      column(2,
                                             radioButtons("i_seatbelt", "Seatbelt used?",
                                                          choices = c("Available, not used" = 0, "Available, used" = 1,
                                                                      "Not Available" = 2, "Not Applicable" = 97, "Unknown" = 99),
                                                          selected = character(0))),
                                      column(2,
                                             radioButtons("i_carseat", "Car seat used?",
                                                          choices = c("Available, not used" = 0, "Available, used" = 1,
                                                                      "Not Available" = 2, "Not Applicable" = 97, "Unknown" = 99),
                                                          selected = character(0))
                                      ),

                                      column(2,

                                             radioButtons("i_helmet", "Helmet used?",
                                                          choices = c("Available, not used" = 0, "Available, used" = 1,
                                                                      "No Helmet" = 2, "Not Applicable" = 97, "Unknown" = 99),
                                                          selected = character(0))),
                                      column(2,
                                             radioButtons("i_airbag", "Airbag deployed?",
                                                          choices = c("No" = 0, "Yes" = 1, "No Airbags" = 2,
                                                                      "Not Applicable" = 97, "Unknown" = 99),
                                                          selected = character(0))),
                                      column(1,

                                             radioButtons("overloading", "Did overloading likely contribute to the injury?",
                                                          choices = c("No" = 0, "Yes" = 1, "Not Applicable" = 97, "Unknown" = 99),
                                                          selected = character(0))
                                      ),
                               ))),

                      #----
                      fluidRow(
                        column(4,
                               radioButtons("i_intent", "Intent",
                                            choices = c(
                                              "Unintentional" = 0,
                                              "Intentional (self-harm/suicide)" = 1,
                                              "Intentional (assault/homicide)" = 2,
                                              "Police/Legal intervention" = 3,
                                              "Events Unclear" = 98,
                                              "Unknown" = 99
                                            ),
                                            selected = character(0)
                               ),
                               column(6,
                                      radioButtons("i_intentperp", "If Intentional, specify perpetrator",
                                                   choices = c(
                                                     "Partner/Ex-partner" = 0,
                                                     "Parent" = 1,
                                                     "Other relative" = 2,
                                                     "Friend/Acquaintance" = 3,
                                                     "Stranger" = 4,
                                                     "Police/Military" = 5,
                                                     "Other (Specify)" = 98,
                                                     "Unknown" = 99
                                                   ),
                                                   selected = character(0)
                                      )
                               ),
                               column(6,
                                      checkboxGroupInput("i_intentcontext", "Context (check all that apply)",
                                                         choices = c(
                                                           "Assault/Mugging" = 0,
                                                           "Home Invasion/Robbery" = 1,
                                                           "Sexual Assault/Rape/Attempted Rape" = 2,
                                                           "Taxi-related assault" = 3,
                                                           "Mob/Population Justice" = 4,
                                                           "Other (Specify)" = 98,
                                                           "Unknown" = 99
                                                         ),
                                                         selected = character(0)
                                      )
                               )

                        ),
                        column(8,
                               div(class = "section-title", "PRE-HOSPITAL CARE"),

                               # 🔹 Row 1: 3 columns
                               fluidRow(
                                 column(4,
                                        div(class = "boxed",
                                            radioButtons("scenecare", "Scene Care Performed?",
                                                         choices = c("No" = 0, "Yes" = 1, "Unknown" = 99),
                                                         selected = character(0), inline = TRUE
                                            ),

                                            checkboxGroupInput("transport", "Transport to Hospital",
                                                               choices = c(
                                                                 "Walked in" = 0,
                                                                 "Ambulance" = 1,
                                                                 "Private Car" = 2,
                                                                 "Taxi" = 3,
                                                                 "Motorcycle (private)" = 4,
                                                                 "Mototaxi" = 5,
                                                                 "Police/Firefighter" = 6,
                                                                 "Other Public Transport" = 7,
                                                                 "Other (Specify)" = 98,
                                                                 "Unknown" = 99
                                                               ),
                                                               selected = character(0)
                                            )

                                        )
                                 ),
                                 column(4,
                                        div(class = "boxed",
                                            checkboxGroupInput("scenecaregiven", "Care Given* (check all that apply)",
                                                               choices = c(
                                                                 "C-spine immobilization" = 0,
                                                                 "Fracture immobilization" = 1,
                                                                 "Back Board" = 2,
                                                                 "CPR" = 3,
                                                                 "Recovery Position" = 4,
                                                                 "Tourniquet Placed" = 5,
                                                                 "IV Fluids" = 6,
                                                                 "Controlled Bleeding (pressure)" = 7,
                                                                 "Topical Burn Treatment" = 8,
                                                                 "Other (Specify)" = 98,
                                                                 "Unknown" = 99
                                                               ),
                                                               selected = character(0)
                                            )
                                        )
                                 ),
                                 column(4,
                                        div(class = "boxed",
                                            checkboxGroupInput("careprovider", "Care Provider* (check all that apply)",
                                                               choices = c(
                                                                 "Person involved in injury" = 0,
                                                                 "Bystander" = 1,
                                                                 "Relative/Friend" = 2,
                                                                 "Police/Firefighter" = 3,
                                                                 "Medic" = 4,
                                                                 "Driver/Transport Personnel" = 5,
                                                                 "Other (Specify)" = 98,
                                                                 "Unknown" = 99
                                                               ),
                                                               selected = character(0)
                                            )
                                        )
                                 )
                               ),

                               # 🔹 Row 2: Care Seeking
                               fluidRow(
                                 column(12,
                                        div(class = "boxed",
                                            radioButtons("priorcare", "Care sought elsewhere prior to arrival?",
                                                         choices = c("No" = 0, "Yes" = 1, "Unknown" = 99),
                                                         selected = character(0), inline = TRUE
                                            ),
                                            checkboxGroupInput("priorcareloc", "If yes**, where?",
                                                               choices = c(
                                                                 "Home" = 0,
                                                                 "Traditional Healer" = 1,
                                                                 "Regional Hospital" = 2,
                                                                 "Health Center" = 3,
                                                                 "Sub-Divisional Medical Center" = 4,
                                                                 "Central Hospital" = 5,
                                                                 "Private Health Center/Hospital" = 6,
                                                                 "District Hospital" = 7,
                                                                 "Military Hospital" = 8,
                                                                 "Dispensary/Pharmacy" = 9,
                                                                 "Other (Specify)" = 98,
                                                                 "Unknown" = 99
                                                               ),
                                                               selected = character(0),
                                                               inline = TRUE
                                            )
                                        )
                                 )
                               ),

                               # 🔹 Row 3: Injury Condition
                               fluidRow(
                                 column(12,
                                        div(class = "boxed",
                                            checkboxGroupInput("severity_ind", "On the day of the injury, did the injured person (select all that apply)",
                                                               choices = c(
                                                                 "None" = 0,
                                                                 "Stop breathing?" = 1,
                                                                 "Lose consciousness?" = 2,
                                                                 "Act confused?" = 3,
                                                                 "Forget the injury?" = 4,
                                                                 "Need to be carried to leave the injury site?" = 5,
                                                                 "Unknown" = 99
                                                               ),
                                                               selected = character(0),
                                                               inline = TRUE
                                            )
                                        )
                                 )
                               ))),


             ),
             tabPanel("CTR Page 3",

                      # ARRIVAL SECTION
                      fluidRow(class = "tight-row",
                        # First row: Signs of life, Respiration, CPR, Vital Signs
                        column(3,
                               radioButtons("lifesigns", "Signs of life on arrival?",
                                            choices = c("No" = 0, "Yes" = 1), inline = TRUE,
                                            selected = character(0))
                        ),
                        column(3,
                               radioButtons("respirationassist", "Respiration assisted?",
                                            choices = c("No" = 0, "Yes" = 1), inline = TRUE,
                                            selected = character(0))
                        ),
                        column(3,
                               radioButtons("cpr", "Cardiopulmonary resuscitation (CPR)?",
                                            choices = c("No" = 0, "Yes" = 1), inline = TRUE,
                                            selected = character(0))
                        ),
                        column(3,
                               radioButtons("vitalstaken", "Vital signs taken?",
                                            choices = c("No" = 0, "Yes" = 1), inline = TRUE,
                                            selected = character(0))
                        )
                      ),

                      fluidRow(class = "tight-row",
                        # Second row: Vitals and Why not taken
                        column(4,
                               tags$h3("Vitals–1"),
                               div(style = "display: flex; gap: 1px;",
                                   textInput("vitals1_sbp", "SBP", width = "50px"),
                                   textInput("vitals1_dbp", "DBP", width = "50px"),
                                   textInput("vitals1_hr", "HR", width = "50px"),
                                   textInput("vitals1_rr", "RR", width = "50px"),
                                   textInput("vitals1_tcelcius", "T (C)", width = "50px"),
                                   textInput("vitals1_o2", "O₂Sat", width = "50px")
                               ),
                               div(style = "margin-top: 1px;",
                                   textInput("vitals1_time", "Time (24 hrs) (hh:mm)", width = "100%"))
                        ),

                        column(4,
                               tags$h3("Vitals–2"),
                               div(style = "display: flex; gap: 1px;",
                                   textInput("vitals2_sbp", "SBP", width = "50px"),
                                   textInput("vitals2_dbp", "DBP", width = "50px"),
                                   textInput("vitals2_hr", "HR", width = "50px"),
                                   textInput("vitals2_rr", "RR", width = "50px"),
                                   textInput("vitals2_tcelcius", "T (C)", width = "50px"),
                                   textInput("vitals2_o2", "O₂Sat", width = "50px")
                               ),
                               div(style = "margin-top: 1px;",
                                   textInput("vitals2_time", "Time (24 hrs) (hh:mm)", width = "100%"))
                        ),

                        column(4,
                               tags$h3("Vitals–3"),
                               div(style = "display: flex; gap: 1px;",
                                   textInput("vitals3_sbp", "SBP", width = "50px"),
                                   textInput("vitals3_dbp", "DBP", width = "50px"),
                                   textInput("vitals3_hr", "HR", width = "50px"),
                                   textInput("vitals3_rr", "RR", width = "50px"),
                                   textInput("vitals3_tcelcius", "T (C)", width = "50px"),
                                   textInput("vitals3_o2", "O₂Sat", width = "50px")
                               ),
                               div(style = "margin-top: 1px;",
                                   textInput("vitals3_time", "Time (24 hrs) (hh:mm)", width = "100%"))
                        ),
                        column(12,
                               checkboxGroupInput("vitalsnottaken", "*Why not taken?",
                                                  choices = c("No staff available" = 0,
                                                              "No working equipment" = 1,
                                                              "Dead on arrival" = 2,
                                                              "Other (Specify)" = 98,
                                                              "Unknown" = 99),
                                                  inline = TRUE,
                                                  selected = character(0)))
                      ),

                      # PRIMARY SURVEY
                      fluidRow(class = "tight-row",
                               column(6,
                                             #tags$h5("Spontaneous Respiration?"),
                                             radioButtons("airway", "Airway Patent?",
                                                          choices = c("No" = 0, "Yes" = 1, "Not Examined"=96),
                                                          inline = FALSE, selected = character(0))
                               ),
                               column(4,
                                      #tags$h4("Airway Intervention"),
                                      checkboxGroupInput("a_intervention", "Airway Intervention (check all that apply)",
                                                         choices = c(
                                                           "No intervention performed" = 0,
                                                           "Repositioning" = 1,
                                                           "Suctioning" = 2,
                                                           "Non-invasive Airway" = 3,
                                                           "Endotracheal Intubation" = 4,
                                                           "Cricothyroidotomy" = 5
                                                         ),
                                                         selected = character(0)
                                      ),
                                      #tags$h5("*Specify reason"),
                                      radioButtons("needlereason", "*Specify reason",
                                                   choices = c("Pneumothorax" = 0, "Hemothorax" = 1),
                                                   inline = TRUE, selected = character(0))
                               ),
                               column(2,
                                      textInput("b_time1", "Time (24 hr) hh:mm", width = "100%"),
                                      textInput("b_time2", "Time (24 hr) hh:mm", width = "100%")
                               )
                      ),
                      fluidRow(class = "tight-row",
                        column(6,
                               column(6,
                                      #tags$h5("Spontaneous Respiration?"),
                                      radioButtons("respirations", "Spontaneous Respiration?",
                                                   choices = c("No" = 0, "Yes, Normal" = 1, "Yes, Abnormal" = 2, "Not Examined"=96),
                                                   inline = FALSE, selected = character(0)),
                                      #tags$h5("Tracheal Deviation?"),
                                      radioButtons("trachealdeviation", "Tracheal Deviation?",
                                                   choices = c("Midline" = 0, "Deviated" = 1, "Not Examined"=96),
                                                   inline = FALSE, selected = character(0))
                               ),
                               column(6,
                                      #tags$h5("Chest Movement?"),
                                      radioButtons("chestrise", "Chest Movement?",
                                                   choices = c("No" = 0, "Yes, Normal" = 1, "Yes, Abnormal" = 2, "Not Examined"=96),
                                                   inline = FALSE, selected = character(0)),
                                      #tags$h5("Breath Sounds?"),
                                      radioButtons("breath", "Breath Sounds?",
                                                   choices = c("Unequal/Abnormal" = 0, "Equal/Bilateral" = 1, "Not Examined"=96),
                                                   inline = FALSE, selected = character(0))

                                      )
                        ),
                        column(4,
                               #tags$h4("Breathing Intervention"),
                               checkboxGroupInput("b_intervention", "Breathing Intervention (check all that apply)",
                                                  choices = c(
                                                    "No intervention performed" = 0,
                                                    "Oxygen (non-BVM)" = 1,
                                                    "Bag Valve mask (BVM)" = 2,
                                                    "Needle thoracostomy*" = 3,
                                                    "Chest tube/tube thoracostomy*" = 4
                                                  ),
                                                  selected = character(0)
                               ),
                               #tags$h5("*Specify reason"),
                               radioButtons("needlereason", "*Specify reason",
                                            choices = c("Pneumothorax" = 0, "Hemothorax" = 1),
                                            inline = TRUE, selected = character(0))
                        ),
                        column(2,
                               textInput("b_time1", "Time (24 hr) hh:mm", width = "100%"),
                               textInput("b_time2", "Time (24 hr) hh:mm", width = "100%")
                        )
                      ),

                      # ==== Row 3: Circulation ====
                      fluidRow(class = "tight-row",
                        column(6,
                               column(6,
                                      radioButtons("palpablepulse", "Palpable Pulse?",
                                                   choices = c("No" = 0, "Yes" = 1, "Not Examined"),
                                                   inline = FALSE, selected = character(0)),
                                      radioButtons("externalbleeding", "Signs of External Bleeding?",
                                                   choices = c("No" = 0, "Yes" = 1, "Not Examined"),
                                                   inline = FALSE, selected = character(0))
                               ),
                               column(6,
                                      radioButtons("fast", "FAST",
                                                   choices = c("Negative" = 0, "Positive" = 1,
                                                               "Indeterminate" = 2, "Not Done" = 3),
                                                   inline = FALSE, selected = character(0)),
                                      radioButtons("peritoneallavage", "Diagnostic Peritoneal Lavage",
                                                   choices = c("Negative" = 0, "Positive" = 1,
                                                               "Indeterminate" = 2, "Not done" = 3),
                                                   inline = FALSE, selected = character(0))
                               )
                        ),
                        column(4,
                               checkboxGroupInput("access", "Circulation Intervention",
                                                  choices = c("No intervention" = 0,
                                                              "Peripheral IV" = 1,
                                                              "Intraosseous line placed" = 2,
                                                              "Central Venous line place" = 3,
                                                              "Blood transfusion initiated" = 4,
                                                              "Tourniquet placed" = 5,
                                                              "Tourniquet removed" = 6),
                                                  selected = character(0))
                        ),
                        column(2,
                               textInput("c_time1", "Time (24 hr) hh:mm", width = "100%"),
                               textInput("c_time2", "Time (24 hr) hh:mm", width = "100%"),
                               textInput("c_time3", "Time (24 hr) hh:mm", width = "100%")
                        )
                      ),

                      fluidRow(class = "tight-row",

                             fluidRow(
                               column(6,
                                     radioButtons("pupils", "Pupils",
                                                  choices = c("Normal" = 1,
                                                              "Abnormal" = 2), inline = TRUE)
                              ),
                              column(6,
                                     checkboxGroupInput("c_collar", "Cervical immobilization",
                                                        choices = c("No, not indicated" = 0,
                                                                    "Yes, in place on arrival" = 1,
                                                                    "Placed in ED" = 2,
                                                                    "Indicated, not done" = 3), inline = TRUE)
                              )),

                            # Glasgow Coma Score - Eyes, Verbal, Motor
                            fluidRow(class = "tight-row",
                              column(4,
                                     radioButtons("gcs_eyes", "GCS - Eyes",
                                                  choices = c("4 - Spontaneous eye opening" = 4,
                                                              "3 - Eye opening to verbal stimulus" = 3,
                                                              "2 - Eye opening to painful stimulus" = 2,
                                                              "1 - No eye opening" = 1), selected = character(0)),
                                     radioButtons("gsc_missing", "GCS Missing",
                                                  choices = c("96 - GCS Missing" = 96), selected = character(0))
                              ),
                              column(4,
                                     radioButtons("gcs_verbal", "GCS - Verbal",
                                                  choices = c("5 - Oriented" = 5,
                                                              "4 - Confused/disoriented" = 4,
                                                              "3 - Inappropriate words" = 3,
                                                              "2 - Incomprehensible sounds" = 2,
                                                              "1 - No verbal response" = 1,
                                                              "Patient intubated" = 98), selected = character(0))
                              ),
                              column(4,
                                     radioButtons("gcs_motor", "GCS - Motor",
                                                  choices = c("6 - Obeys commands" = 6,
                                                              "5 - Localizes to painful stimulus" = 5,
                                                              "4 - Withdrawal from painful stimulus" = 4,
                                                              "3 - Flexion to painful stimulus" = 3,
                                                              "2 - Extension to painful stimulus" = 2,
                                                              "1 - No response" = 1), selected = character(0))
                              )
                            ),

                            fluidRow(class = "tight-row",
                              column(6,
                                     radioButtons("gcs_qualifier", "GCS Qualifier",
                                                  choices = c("0 - None-valid GCS" = 0,
                                                              "1 - Obstruction to patient's eye" = 1,
                                                              "2 - Patient intubated" = 2,
                                                              "3 - Patient chemically sedated/paralyzed" = 3))
                              ),
                              column(6,
                                     radioButtons("gcs_qualifier_other", "GCS Qualifier Other:",
                                                  choices = c("98 - Other (Specify)" = 98), selected = character(0)),
                                     textInput("gcs_qualifier_other_specify", "Specify", "")
                              )
                            ),

                            # Patient disrobed
                            fluidRow(class = "tight-row",
                              column(6,
                                     radioButtons("patientdisrobe", "Patient disrobed for exam?",
                                                  choices = c("No" = 0,
                                                              "Yes, partially disrobed" = 1,
                                                              "Yes, completely disrobed" = 2))
                              ),
                              column(6,
                                     radioButtons("tempcontrol", "Warming measures initiated?",
                                                  choices = c("No" = 0,
                                                              "Yes" = 1,
                                                              "Not Applicable" = 97))
                              )
                            ),
                        fluidRow(
                               h5("Secondary Survey", style="color:black; padding:5px;"),
                               tags$div(
                                 style = "overflow-x:auto; width:100%;",
                                 tags$table(
                                   class = "table table-bordered table-sm",
                                   style = "width:100%;
                                            color:black;
                                            border-color:black;
                                            text-align:center;
                                            table-layout: fixed;
                                            border-collapse: collapse;
                                            border-spacing: 0;",

                                   # Header row with rotated labels
                                   tags$thead(
                                     tags$tr(
                                       tags$th(
                                         "Injury Matrix",
                                         style = "width:120px; color:black; border:1px solid black; padding:2px; font-size:14px; text-align:left;"
                                       ),
                                       lapply(
                                         c("Head","Neck","Face","Chest","Abd","UroG","Pelvis",
                                           "C_Sp","T_Sp","L_Sp","LUE","RUE","LLE","RLE"),
                                         function(region) {
                                           tags$th(
                                             style = "width:30px; border:1px solid white; color:black; vertical-align:bottom; padding:0; font-size:12px;",
                                             tags$div(
                                               style = "display:flex;
                                                        align-items:center;
                                                        justify-content:center;
                                                        transform: rotate(-90deg);
                                                        transform-origin:center center;
                                                        white-space:nowrap;
                                                        height:70px;
                                                        line-height:1;",
                                               region
                                             )
                                           )
                                         }
                                       )
                                     )
                                   ),

                                   # Rows for injuries
                                   tags$tbody(
                                     Map(
                                       function(label, injury) {
                                         tags$tr(
                                           tags$td(
                                             injury,
                                             style = "width:120px; border:1px solid black; color:black;text-align:left; padding:2px; font-size:14px; white-space:nowrap;"
                                           ),
                                           lapply(
                                             c("Head","Neck","Face","Chest","Abd","UroG","Pelvis",
                                               "C_Sp","T_Sp","L_Sp","LUE","RUE","LLE","RLE"),
                                             function(region) {
                                               # Generate IDs like inj_lacdeep_rle
                                               id <- paste0(
                                                 "inj_", label, "_", tolower(gsub("_", "", region))
                                               )
                                               tags$td(
                                                 style = "width:30px; border:1px solid black; color:black; text-align:center; padding:0; margin:0;",
                                                 textInput(
                                                   inputId = id,
                                                   label = NULL,
                                                   value = "",
                                                   width = "40px"
                                                 )
                                               )
                                             }
                                           )
                                         )
                                       },
                                       label = c(
                                         "bruise","sprain","bullet","lacsuper","lacdeep","avulsion","amputation",
                                         "fractureclosed","fractureopen","dislocation","burn","visceraexpose",
                                         "hematoma","neurodef","diminishpulse","other"
                                       ),
                                       injury = c(
                                         "Bruise/abrasion","Sprain/strain","Bullet entry/exit","Superficial laceration",
                                         "Deep laceration","Avulsion/Degloving","Amputation","Closed fracture",
                                         "Open fracture","Dislocation","Burn","Viscera exposed",
                                         "Hematoma/internal bleeding","Neurologic deficit","Diminished pulse",
                                         "Other (specify)"
                                       )
                                     )
                                   )
                                 )
                               )



                        )
                      ),

                      fluidRow(
                        column(2,
                               numericInput("gen_heais",
                                            label = tags$span("General", style="font-size:12px;"),
                                            value = NA, min = 0, max = 6, step = 1, width = "100%")),
                        column(2,
                               numericInput("face_heais",
                                            label = tags$span("Face", style="font-size:12px;"),
                                            value = NA, min = 0, max = 6, step = 1, width = "100%")),
                        column(2,
                               numericInput("hncs_heais",
                                            label = tags$span("Head/Neck/C-Spine", style="font-size:12px;"),
                                            value = NA, min = 0, max = 6, step = 1, width = "100%")),
                        column(2,
                               numericInput("chestts_heais",
                                            label = tags$span("Torso/T-Spine", style="font-size:12px;"),
                                            value = NA, min = 0, max = 6, step = 1, width = "100%")),
                        column(2,
                               numericInput("abpells_heais",
                                            label = tags$span("Abd/Pelv/Uro/L-Sp", style="font-size:12px;"),
                                            value = NA, min = 0, max = 6, step = 1, width = "100%")),
                        column(2,
                               numericInput("ex_heais",
                                            label = tags$span("Extremities", style="font-size:12px;"),
                                            value = NA, min = 0, max = 6, step = 1, width = "100%"))
                      )



             ),
             tabPanel("CTR Page 4",

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
                                              lapply(c("Xray","Ultra","CT Scan","MRI"), function(modality){
                                                tags$tr(
                                                  tags$td(modality,
                                                          style="width:120px; border:1px solid black; background-color:#f0f0f0; color:black; text-align:left; padding:2px; font-size:12px; white-space:nowrap;"),
                                                  lapply(c("head","neck","chest","abd","spine",
                                                           "pelvisobs","pelvisuro","pelvisother",
                                                           "lue","rue","lle","rle","vasc"), function(region){
                                                             inputId <- paste0("radio_", gsub(" ", "", tolower(modality)), "_", region)
                                                             tags$td(
                                                               style="width:60px; border:1px solid black; background-color:white; color:black; text-align:center; padding:2px;",
                                                               textInput(inputId, label = NULL, value = NA, width = "60px")
                                                             )
                                                           })
                                                )
                                              })
                                            )
                                 )
                        )
                      ), #--- end of fluid row
                      fluidRow(
                        column(12,
                               tags$h5("If 1+ study was recommended but not performed, which of the following contributed?"),
                               checkboxGroupInput("diagnostic_notperformed", NULL,
                                                  choices = list(
                                                    "Inability to pay" = 0,
                                                    "Patient Preference" = 1,
                                                    "Long wait time" = 2,
                                                    "Patient left AMA" = 3,
                                                    "No Staff" = 4,
                                                    "Equipment not available or not functional" = 5,
                                                    "Other (Specify)" = 98
                                                  ),
                                                  inline = TRUE),

                               conditionalPanel(
                                 condition = "input.diagnostic_notperformed.includes('98')",
                                 textInput("diagnostic_notperformedother", "Specify other reason:", width = "50%")
                               )
                        )
                      ), #--- end of fluid row



                      fluidRow(class="tight-row",

                        column(12,

                        tags$div(style="overflow-x:auto; width:100%;",
                                 tags$table(class = "table table-bordered table-sm",
                                            style="width:100%; table-layout: fixed; font-size:10; background-color:white; border-collapse:collapse; text-align:center; border-spacing: 0;",

                                            # Header
                                            tags$thead(
                                              tags$tr(
                                                tags$th("Consultants", style="width:15%; font-size:10; text-align:left; background-color:#ccc;"),
                                                tags$th("Recommended?", style="width:17%; font-size:10;"),
                                                tags$th("Called?", style="width:10%; font-size:10;"),
                                                tags$th("*If called, Date and Time", colspan=2, style="width:20%; font-size:10;"),
                                                tags$th("Arrived?", style="width:10%; font-size:13;"),
                                                tags$th("*If arrived, Date and Time", colspan=2, style="width:20%; font-size:10;")
                                              )
                                            ),

                                            # Consultant rows
                                            tags$tbody(
                                              lapply(seq_along(specs), function(i){
                                                spec <- specs[i]
                                                id <- ids[i]
                                                tags$tr(
                                                  tags$td(spec, style="text-align:left; background-color:#eee;"),

                                                  # Recommended Radio button
                                                  tags$td(
                                                    style = "padding:1px; text-align:center;",
                                                    div(style = "display: inline-block; margin-right:1px;",
                                                        radioButtons(paste0("consult_", id, "___recom_no"), NULL, choices = c("No" = 1), selected = character(0), inline = TRUE)),
                                                    div(style = "display: inline-block;",
                                                        radioButtons(paste0("consult_", id, "___recom_yes"), NULL, choices = c("Yes" = 1), selected = character(0), inline = TRUE))
                                                  ),


                                                  # Called Radio button
                                                  tags$td(
                                                    style = "padding:1px; text-align:center;",
                                                    div(style = "display: inline-block; margin-right:1px;",
                                                        radioButtons(paste0("consult_", id, "___called_no"), NULL, choices = c("No" = 1), selected = character(0), inline = TRUE)),
                                                    div(style = "display: inline-block;",
                                                        radioButtons(paste0("consult_", id, "___called_yes"), NULL, choices = c("Yes" = 1), selected = character(0), inline = TRUE))
                                                  ),

                                                  # Called Date and Time
                                                  tags$td(textInput(paste0("consult_", id, "called_date"), "Date:", width="120px")),
                                                  tags$td(textInput(paste0("consult_", id, "called"), "Time (24hr):", width="120px")),

                                                  # Arrived Radio button
                                                  tags$td(
                                                    style = "padding:1px; text-align:center;",
                                                    div(style = "display: inline-block; margin-right:1px;",
                                                        radioButtons(paste0("consult_", id, "___arrived_no"), NULL, choices = c("No" = 1), selected = character(0), inline = TRUE)),
                                                    div(style = "display: inline-block;",
                                                        radioButtons(paste0("consult_", id, "___arrived_yes"), NULL, choices = c("Yes" = 1), selected = character(0), inline = TRUE))
                                                  ),

                                                  # Arrived Date and Time
                                                  tags$td(textInput(paste0("consult_", id, "arrived_date"), "Date:", width="120px")),
                                                  tags$td(textInput(paste0("consult_", id, "arrived"), "Time (24hr):", width="120px"))
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
                                                   style="width:100%; table-layout:fixed; font-size:12px; background-color:white; border-collapse:collapse; text-align:center; border-spacing:0; padding:1;",

                                                   # Header Row
                                                   tags$thead(
                                                     tags$tr(style = "padding:1px; text-align:center; border:1px solid black;",
                                                       tags$th("Medications/Sedation & Procedures", style="width:30%; padding:1px;"),
                                                       tags$th("Recommended?", style="width:15%; padding:1px;"),
                                                       tags$th("Received?", style="width:15%; padding:1px;"),
                                                       tags$th("If received, time (hh:mm)", style="width:20%; padding:1px;"),
                                                       tags$th("If recommended but NOT received, why?", style="width:20%; padding:1px;")
                                                     )
                                                   ),

                                                   # Rows for Medications and Procedures
                                                   tags$tbody(
                                                     lapply(seq_along(specs), function(i){
                                                       spec <- specs_med[i]
                                                       id <- ids_med[i]
                                                       tags$tr(style="width:25%; padding:1px;",
                                                         tags$td(
                                                           style = "text-align:left; background-color:#eee; padding:1px;",
                                                           spec,
                                                           if (stringr::str_detect(tolower(spec), "antibiotic|other")) {
                                                             list(
                                                               textInput(paste0("consult_", gsub("[^A-Za-z]", "", tolower(spec)), "_specify"), "Specify", value = "")
                                                             )
                                                           } else if(stringr::str_detect(tolower(spec), "crystalloid|colloid|^blood")){

                                                             textInput(paste0("consult_", gsub("[^A-Za-z]", "", tolower(spec)), "_litres"), "Litres", value = "")


                                                           }
                                                         ),

                                                         # Recommended Yes/No
                                                         tags$td(
                                                           radioButtons(paste0(id, "___recom_yes"), NULL, choices=c("Yes"=1), selected=character(0), inline=FALSE),
                                                           radioButtons(paste0(id, "___recom_no"), NULL, choices=c("No"=1), selected=character(0), inline=FALSE)
                                                         ),

                                                         # Received Yes/No
                                                         tags$td(
                                                           radioButtons(paste0(id, "___received_yes"), NULL, choices=c("Yes"=1), selected=character(0), inline=FALSE),
                                                           radioButtons(paste0(id, "___received_no"), NULL, choices=c("No"=1), selected=character(0), inline=FALSE)
                                                         ),

                                                         # Time
                                                         tags$td(textInput(paste0(id, "time"), NULL, placeholder="hh:mm", width="100%")),

                                                         # Why Not Received
                                                         tags$td(textInput(paste0(id, "notreceived"), NULL, placeholder="Reason", width="100%"))
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
                                 tags$div(style="overflow-x:auto; width:100%; margin-bottom:2px; padding:1px; spacing:1px",
                                          tags$table(class = "table table-bordered table-sm",
                                                     style="width:100%; height:300px ; table-layout: fixed; font-size:12px; background-color:white; border-collapse:collapse; text-align:center; padding:1px; spacing:0px",

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
                                                         tags$td(radioButtons("upt_recommend", NULL, choices=c("Yes","No","Known Pregnant"), selected = character(0), inline=FALSE)),
                                                         tags$td(radioButtons("upt_performed", NULL, choices=c("Yes","No"), selected = character(0), inline=TRUE)),
                                                         tags$td(radioButtons("upt_result", NULL, choices=c("Negative","Positive"), selected = character(0), inline=FALSE))
                                                       ),
                                                       tags$tr(
                                                         tags$td("HGB", style="text-align:left; background-color:#eee;"),
                                                         tags$td(radioButtons("hgb_recommend", NULL, choices=c("Yes","No"), selected = character(0), inline=FALSE)),
                                                         tags$td(radioButtons("hgb_performed", NULL, choices=c("Yes","No"), selected = character(0), inline=FALSE)),
                                                         tags$td(textInput("hgb_result", NULL, value = "")) # no result for HGB in screenshot
                                                       ),
                                                       tags$tr(
                                                         tags$td("Blood Group", style="text-align:left; background-color:#eee;"),
                                                         tags$td(radioButtons("bg_recommend", NULL, choices=c("Yes","No"), selected = character(0), inline=FALSE)),
                                                         tags$td(radioButtons("bg_performed", NULL, choices=c("Yes","No"), selected = character(0), inline=FALSE)),
                                                         tags$td(radioButtons("bg_result", NULL, choices=c("A","B","AB","O"), width="100%", selected = character(0), inline=FALSE))
                                                       )
                                                     )
                                          )
                                 )
                               ),

                               # Bottom Fluidrow - Disposition
                               fluidRow(
                                 tags$div(style="overflow-x:auto; width:100%; padding:1px; spacing:1px",
                                          tags$table(class = "table table-bordered table-sm",
                                                     style="width:100%; table-layout: fixed; font-size:12px; background-color:white; border-collapse:collapse; text-align:center; padding:1px; spacing:1px",

                                                     tags$thead(
                                                       tags$tr(
                                                         tags$th("Disposition", colspan=2, style="text-align:left; background-color:#ccc;")
                                                       )
                                                     ),

                                                     tags$tbody(
                                                       tags$tr(
                                                         tags$td("Date", style="width:30%; text-align:left;"),
                                                         tags$td(textInput("dispo_date", NULL, placeholder="DD/MM/YYYY", width="100%"))
                                                       ),
                                                       tags$tr(
                                                         tags$td("Time (24HR format)", style="text-align:left;"),
                                                         tags$td(textInput("dispo_time", NULL, placeholder="HH:MM", width="100%"))
                                                       ),
                                                       tags$tr(
                                                         tags$td("Disposition", colspan=2,
                                                                 tags$div(style="text-align:left; padding:20px;",
                                                                          radioButtons("disposition", NULL,
                                                                                    choices=c("Discharged home to die"=0,
                                                                                              "Emergency ward observation"=1,
                                                                                              "Admitted to ward"=2,
                                                                                              "Admitted to ICU"=3,
                                                                                              "Directly to OR"=4,
                                                                                              "Died"=5,
                                                                                              "Left AMA"=6,
                                                                                              "Transferred"=7,
                                                                                              "Unknown"=99),
                                                                                    inline=FALSE, selected = character(0))))
                                                       ),
                                                       tags$tr(
                                                         tags$td("Transfer reason", colspan=2,
                                                                 tags$div(style="text-align:left; padding:20px;",
                                                                 radioButtons("disposition_transfer", NULL,
                                                                                    choices=c("Cost"=0,
                                                                                              "Higher Care"=1,
                                                                                              "Preference"=2,
                                                                                              "Other (specify)"=98,
                                                                                              "Unknown"=99),
                                                                                    inline=FALSE, selected = character(0)))
                                                                 )
                                                       )
                                                     )
                                          )
                                 )
                               ) #--- end of fluid row
                        )
                      ), #--- end of fluid row

                      fluidRow(

                        # Left Column – Method of payment
                        column(7,
                               tags$h4("Cost of treatment (CFA)"),

                               textInput("dispo_cost", "Cost of Treatment", value = ""),

                               checkboxGroupInput("dispo_payment", "Method of payment (check all that apply):",
                                                  choices = list(
                                                    "Self-pay (cash)" = 0,
                                                    "Family Assistance" = 1,
                                                    "Government Assistance" = 2,
                                                    "NGO Assistance" = 3,
                                                    "Insurance" = 4,
                                                    "Perpetrator" = 5,
                                                    "Other (Specify)" = 98,
                                                    "Unknown" = 99
                                                  ),
                                                  inline = TRUE),

                               conditionalPanel(
                                 condition = "input.dispo_payment.includes('98')",
                                 textInput("dispo_paymentother", "Other (Specify):")
                               )
                        ),

                        # Right Column – Related questions
                        column(5,
                               radioButtons("dispo_costcareimpede", "Did cost interfere with care?",
                                            choices = c("No" = 0, "Yes" = 1, "Unknown" = 99),
                                            inline = TRUE, selected = character(0)),

                               radioButtons("emergency_finassist", "Was emergency financial assistance offered?",
                                            choices = c("No" = 0, "Yes*" = 1, "Unknown" = 99),
                                            inline = TRUE, selected = character(0)),

                               radioButtons("emerg_finassist_used", "*If yes, was it used?",
                                            choices = c("No" = 0, "Yes" = 1, "Refused by family" = 2, "Unknown" = 99),
                                            inline = TRUE, selected = character(0)),

                               radioButtons("emerg_finassist_improve", "*Did the financial assistance improve care?",
                                            choices = c("No" = 0, "Yes" = 1, "Unknown" = 99),
                                            inline = TRUE, selected = character(0))
                        )
                      ) #--- end of fluid row





                      )
             # ,
             # tabPanel("FU Page 1",
             #
             #          source("fu_page1_v2.R", local = TRUE)
             #
             #          )
           )

    ),

    column(6,
           tabsetPanel(
             tabPanel("Patient PDF",
                      uiOutput("pdf_viewer", style = "width: 100%; height: 200vh;")
             ),
             tabPanel("Review Record",
                      div(style = "overflow-x: auto; width: 100%;",
                          DT::dataTableOutput("df_preview")
                      )

             )
           )
    )

  )
)

