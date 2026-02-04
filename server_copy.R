library(shiny)
library(shinyTime)
library(ctrdata)
library(readxl)
source("functions.R")
library(tidyr)

#Sys.setenv("RC_API_TOKEN" = readRDS(file.choose()), "RC_API_URL" = readRDS(file.choose()))

api_url = "https://rc.dsineafricaub.org/api/"


server <- function(input, output, session) {
  # Handle file upload
  observeEvent(input$upload_ids, {
    req(input$upload_ids)
    ext <- tools::file_ext(input$upload_ids$name)

    df <- switch(ext,
                 "csv" = read.csv(input$upload_ids$datapath, stringsAsFactors = FALSE),
                 "xlsx" = read_excel(input$upload_ids$datapath),
                 "xls" = read_excel(input$upload_ids$datapath),
                 {
                   showNotification("Unsupported file format", type = "error")
                   return(NULL)
                 }
    )

    if (!"unique_ctr_id" %in% names(df)) {
      showNotification("Missing 'unique_ctr_id' column", type = "error")
      return(NULL)
    }

    updateSelectInput(session, "select_ctr_id", choices = c("", unique(df$unique_ctr_id)))
  })


  # Sync dropdown to PDF and ID fields
  observeEvent(input$select_ctr_id, {
    req(input$select_ctr_id)
    updateTextInput(session, "ctr_prefix", value = substr(input$select_ctr_id, 1, 3))
    updateTextInput(session, "patient_ctr_id", value = substr(input$select_ctr_id, 5, nchar(input$select_ctr_id)))

    # ---------- PDF viewer ----------
    map_list <- list(BRH="Bertoua", CUY="Cury", HCP="Pouma", HDB="Bafia", HDK="Kribi",
                     HLD="Douala", HRB="Bafoussam", HRE="Edea", HRL="Limbe", HRM="Maroua")

    site_code <- substr(input$select_ctr_id, 1, 3)
    site_name <- map_list[[site_code]]
    if (is.null(site_name)) return()

    all_dirs <- list.dirs("www/CTR Data/", recursive = FALSE)
    match_index <- which(stringr::str_detect(tolower(all_dirs), tolower(site_name)))
    if (length(match_index) == 0) return()

    dir_path <- file.path(all_dirs[match_index[1]], "2025")
    if (!dir.exists(dir_path)) return()

    pdf_files <- list.files(path = dir_path, pattern = "\\.pdf$", recursive = TRUE, full.names = TRUE)
    matching_pdf <- pdf_files[grepl(input$select_ctr_id, pdf_files, ignore.case = TRUE)]

    if (length(matching_pdf) > 0) {
      relative_pdf_path <- sub("^www/", "", matching_pdf[1])
      output$pdf_viewer <- renderUI({
        tags$iframe(
          style = "height:200vh; width:100%; border:none;",
          src = paste0(relative_pdf_path, "#view=FitH&toolbar=1&navpanes=0")
        )
      })
    } else {
      output$pdf_viewer <- renderUI({ tags$p("PDF not found.") })
    }
  })


  ## Creating an object globally accesible
  df_load <- reactiveVal()

  # Load record from REDCap
  observeEvent(input$load_record, {
    req(input$select_ctr_id)

    # req(input$data_mode)
    # print(paste("Mode", input$data_mode))

    req(input$upload_rc_key)

    Sys.setenv("RC_API_TOKEN" = readRDS(input$upload_rc_key$datapath))

    Sys.setenv("RC_API_URL" = "https://rc.dsineafricaub.org/api/")


    ctrdata::rc_config(api_url = Sys.getenv("RC_API_URL"), api_token = Sys.getenv("RC_API_TOKEN"))

    df <- ctrdata::rc_export_multiple_record_with_groups(field_name = "unique_ctr_id", field_value = input$select_ctr_id)

    ## load it in df_load
    df_load(df)

    ## Transfer Reasons
    #transferreason <- combine_dummy_vars(df=df, var="transferreason")
    # medicalhx <- combine_dummy_vars(df=df, var="medicalhx")
    # medicalhx_chronic <- combine_dummy_vars(df=df, var="medicalhx_chronic")

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


    ##############
    #### CTR Page 2
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
    updateCheckboxGroupInput(session, "mechanism", selected = df$i_mechanism) # mapped

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

    ### CTR Page 3

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
    updateTextInput(session, "vitals1_temp", value = df$vitals1_tcelcius)
    updateTextInput(session, "vitals1_o2", value = df$vitals1_o2sat)
    updateTextInput(session, "vitals1_time", value = df$vitals1_time)

    # Vitals–2
    updateTextInput(session, "vitals2_sbp", value = df$vitals2_sbp)
    updateTextInput(session, "vitals2_dbp", value = df$vitals2_dbp)
    updateTextInput(session, "vitals2_hr", value = df$vitals2_hr)
    updateTextInput(session, "vitals2_rr", value = df$vitals2_rr)
    updateTextInput(session, "vitals2_temp", value = df$vitals2_tcelcius)
    updateTextInput(session, "vitals2_o2", value = df$vitals2_o2sat)
    updateTextInput(session, "vitals2_time", value = df$vitals2_time)

    # Vitals–3
    updateTextInput(session, "vitals3_sbp", value = df$vitals3_sbp)
    updateTextInput(session, "vitals3_dbp", value = df$vitals3_dbp)
    updateTextInput(session, "vitals3_hr", value = df$vitals3_hr)
    updateTextInput(session, "vitals3_rr", value = df$vitals3_rr)
    updateTextInput(session, "vitals3_temp", value = df$vitals3_tcelcius)
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
    updateRadioButtons(session, "c_intervention", selected = df$access)
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

    # CTR Form 4 fields
    source("ctr_form4_fields_update.R", local = TRUE)


  })

  ## Created the updated dataframe
  df_new <- reactiveVal()

  ## track updated field
  updated_fields <- reactiveVal(c())

###########
  observeEvent(input$submit, {
    df <- df_load()
    req(df)

    # Step 1: Get relevant column names from df
    input_names <- names(df)

    # Step 2: Safely extract inputs that are non-null
    input_values <- lapply(input_names, function(col) {
      val <- input[[col]]
      if (is.null(val) || length(val) == 0) return(NA)  # placeholder
      return(val)
    })
    names(input_values) <- input_names

    # Step 3: Create a one-row data frame (all NAs for missing)
    input_df <- as.data.frame(input_values, stringsAsFactors = FALSE)

    # Step 4: Match types with original df
    for (col in input_names) {
      if (is.factor(df[[col]])) {
        input_df[[col]] <- factor(input_df[[col]], levels = levels(df[[col]]))
      } else if (is.numeric(df[[col]])) {
        input_df[[col]] <- as.numeric(input_df[[col]])
      } else if (inherits(df[[col]], "Date")) {
        input_df[[col]] <- as.Date(input_df[[col]])
      } else {
        input_df[[col]] <- as.character(input_df[[col]])
      }
    }

    # Step 5: Compare values — handle NA correctly
    changed_fields <- input_names[
      mapply(function(old, new) {
        !(is.na(old) && is.na(new)) && !identical(old, new)
      }, df[, input_names], input_df[, input_names])
    ]

    # Step 6: Update df and store results
    df_updated <- df
    df_updated[, changed_fields] <- input_df[, changed_fields]

    #df_updated <- df_updated[,c("record_id", "unique_ctr_id", changed_fields)]

    df_new(df_updated)
    updated_fields(changed_fields)

    showNotification("Form submitted!", type = "message")
  })




##############
  output$df_preview <- DT::renderDataTable({

    req(df_new())
    req(df_load())

    # find the differing columns in the first row
    diff_idx <- which(df_load()[1, ] != df_new()[1, ])

    # subset both dataframes
    orig <- df_load()[, diff_idx, drop = FALSE]
    mod  <- df_new()[, diff_idx, drop = FALSE]

    # add the comparison column
    orig$comparison <- "Original"
    mod$comparison  <- "Modified"

    # bind and move comparison column to front
    res <- rbind(orig, mod)
    res <- res[, c("comparison", setdiff(names(res), "comparison"))]

    res


    #df <- df[,c("record_id", "unique_ctr_id", updated_fields())]

    #df

  }, options = list(
    scrollX = TRUE,       # horizontal scrolling
    pageLength = 10       # show 10 rows per page
  ))

}
