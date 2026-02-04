library(shiny)
library(shinyTime)
library(ctrdata)
library(readxl)
source("functions.R")
library(tidyr)
library(shinyjs)

api_url = "https://rc.dsineafricaub.org/api/"


server <- function(input, output, session) {

  ## Creating an object globally accesible
  df_load <- reactiveVal()

  df_load_selected <- reactiveVal() ## Selected value

  sorted_ids    <- reactiveVal() ## ids

  current_index <- reactiveVal(1) ## index

  # Handle file upload and load data from RC
  observeEvent(input$load_record, {
    req(input$upload_ids)
    req(input$upload_rc_key)

    Sys.setenv("RC_API_TOKEN" = readRDS(input$upload_rc_key$datapath))
    Sys.setenv("RC_API_URL"   = "https://rc.dsineafricaub.org/api/")

    ext <- tools::file_ext(input$upload_ids$name)

    df_ids <- switch(ext,
                     "csv"  = read.csv(input$upload_ids$datapath, stringsAsFactors = FALSE),
                     "xlsx" = read_excel(input$upload_ids$datapath),
                     "xls"  = read_excel(input$upload_ids$datapath),
                     {
                       showNotification("Unsupported file format", type = "error")
                       return(NULL)
                     }
    )

    if (!"unique_ctr_id" %in% names(df_ids)) {
      showNotification("Missing 'unique_ctr_id' column", type = "error")
      return(NULL)
    }

    ids <- sort(unique(df_ids$unique_ctr_id))


    updateSelectInput(
      session, "select_ctr_id",
      choices = c("", ids)
    )

    # ---- Load ALL REDCap records at once ----
    ctrdata::rc_config(
      api_url  = Sys.getenv("RC_API_URL"),
      api_token = Sys.getenv("RC_API_TOKEN")
    )

    data <- ctrdata::rc_export_multiple_record_with_groups(
      field_name = "unique_ctr_id",
      field_value = ids   #
    )

    df_load(data)  # Assigning dataset
    sorted_ids(ids) # Assigning ids


    showNotification("REDCap records loaded successfully", type = "message")
  })


  # Go to next ID
  observeEvent(input$next_id, {
    req(sorted_ids(), input$select_ctr_id)

    ## Update records
    # update_record()

    ## Moving to next record
    ids <- sorted_ids()
    idx <- which(ids == input$select_ctr_id)

    if (idx < length(ids)) {
      updateSelectInput(
        session,
        "select_ctr_id",
        selected = ids[idx + 1]
      )
      shinyjs::enable("prev_id")
    } else {
      shinyjs::disable("next_id")
      showNotification("Already at last record", type = "warning")
    }
  })

  observeEvent(input$prev_id, {
    req(sorted_ids(), input$select_ctr_id)

    df <- df_load()

    changed_cols <- get_changed_cols(df, input, input$select_ctr_id)


    # Updating df
    if (length(changed_cols) > 0) {
      idx <- which(df$unique_ctr_id == input$select_ctr_id)

      lapply(changed_cols, \(x) print(input[[x]]))

      # df[idx, changed_cols] <- lapply(changed_cols, \(x) input[[x]])

      df_load(df)   # save back into reactiveVal
    }


    # ---- Move to previous record ----
    ids <- sorted_ids()
    idx2 <- which(ids == input$select_ctr_id)

    if (idx2 > 1) {
      updateSelectInput(
        session,
        "select_ctr_id",
        selected = ids[idx2 - 1]
      )
      shinyjs::enable("next_id")
    } else {
      shinyjs::disable("prev_id")
      showNotification("Already on the first record", type = "warning")
    }
  })


# Load record from REDCap
  observeEvent(list(input$select_ctr_id, input$next_id, input$prev_id), {
    req(df_load(), sorted_ids(), input$select_ctr_id)

    df <- df_load() %>%
      dplyr::mutate(unique_ctr_id = as.character(unique_ctr_id)) %>%
      dplyr::filter(unique_ctr_id == as.character(input$select_ctr_id))

    df_load_selected(df) ## Loading selected record

    if (nrow(df) == 0) {
      showNotification("Selected ID not found in loaded REDCap dataset", type = "error")
      return()
    }


    ##############
    #### CTR Page 1
    source("ctr_form1_fields_update.R", local = TRUE)

    #### CTR Page 2
    source("ctr_form2_fields_update.R", local = TRUE)

    ### CTR Page 3
    source("ctr_form3_fields_update.R", local = TRUE)

    # CTR Form 4 fields
    source("ctr_form4_fields_update.R", local = TRUE)

    # Follow UP form
    # source("fu_page1_fields_update.R", local=TRUE)


  })


  # Loading the PDF and ID fields
  observeEvent(input$select_ctr_id, {
    req(input$select_ctr_id, df_load_selected())

    df_selected <- df_load_selected()

    year_collected <- substr(df_selected$date_survey,1,4)


    # ---------- PDF viewer ----------
    map_list <- list(BRH="Bertoua", CUY="Cury", HCP="Pouma", HDB="Bafia", HDK="Kribi",
                     HLD="Douala", HRB="Bafoussam", HRE="Edea", HRL="Limbe", HRM="Maroua")

    site_code <- substr(input$select_ctr_id, 1, 3)
    site_name <- map_list[[site_code]]
    if (is.null(site_name)) return()

    all_dirs <- list.dirs("www/CTR Data/", recursive = FALSE)
    match_index <- which(stringr::str_detect(tolower(all_dirs), tolower(site_name)))
    if (length(match_index) == 0) return()

    dir_path <- file.path(all_dirs[match_index[1]], year_collected)
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



  ## Created the updated dataframe
  df_new <- reactiveVal()

  ## track updated field
  updated_fields <- reactiveVal(c())

  df_orig_filtered <- reactiveVal()

###########
  observeEvent(input$submit, {
    df <- df_load()
    req(df, input$select_ctr_id)

    input_id <- input$select_ctr_id
    input_names <- input_names <- intersect(names(input), names(df))

    # print(input_names)

    # Step 1: Original row to compare
    old_row <- df[df$unique_ctr_id == input_id, , drop = FALSE]

    old_row <- old_row %>% dplyr::select(dplyr::any_of(c("record_id", "unique_ctr_id", input_names)))

    # print(paste("Original data dimension:", dim(old_row)))


    # Step 2: Safely extract user inputs
    input_values <- lapply(input_names, function(col) {
      val <- input[[col]]
      if (is.null(val) || length(val) == 0) return(NA)
      # if (is.null(val)) return(NA)
      return(val)
    })

    # input_values <- input_values[input_names]

    names(input_values) <- input_names


    # Step 3: One-row df from input
    input_df <- as.data.frame(input_values, stringsAsFactors = FALSE)

    # print(paste("Input data dimension:", dim(input_df)))

    # Step 4: Type match
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

    ## Adding the record id
    input_df <- as_tibble(input_df) %>%
      dplyr::mutate(record_id=old_row$record_id, unique_ctr_id=input$select_ctr_id) %>%
      dplyr::relocate(record_id, unique_ctr_id) %>%
      dplyr::distinct(record_id, .keep_all = TRUE)

    ## Updating input_df to match old_row columns and vice versa
    input_names <- intersect(names(old_row), names(input_df))

    input_df <- input_df[,input_names, drop = FALSE]
    tibble::as_tibble(input_df)
    # print(input_df)

    old_row <- old_row[,input_names, drop = FALSE]
    tibble::as_tibble(old_row)
    # print(old_row)


    # print("Original Data")
    # print(head(tibble::as_tibble(old_row)))
    #
    # print("Modified Data")
    # print(head(tibble::as_tibble(input_df)))


    # Step 5: Compare two rows only
    diff_indices <- get_diff_indices(old_row, input_df)

    # Step 6: Update reactive values only if changed
    if (nrow(diff_indices) > 0) {

      input_df <- input_df[unique(diff_indices[,1]), c(1,unique(diff_indices[,2]))]

      print("Updated dta")
      print(input_df)

      old_row <- old_row[,names(input_df)]

      print("Old data")
      print(old_row)

      df_new(input_df)
      df_orig_filtered(old_row)
      updated_fields(diff_indices)
      showNotification("Form submitted!", type = "message")
    } else {
      showNotification("No changes detected.", type = "warning")
    }
  })


##############
  output$df_preview <- DT::renderDataTable({

    req(df_orig_filtered(), df_new(), updated_fields())

    indices <- updated_fields()

    print(indices)

    if (nrow(indices) == 0)
      return(data.frame(Message = "No modified records found"))

    # Always include ID for context
    # if (!"unique_ctr_id" %in% names(df_new()))
    #   diff_cols <- c("unique_ctr_id", diff_cols)

    orig <- df_orig_filtered()
    # print(names(orig))
    # print(c(1,unique(indices[,2])))

    # orig <- orig[unique(indices[,1]), c(1,unique(indices[,2]))]
    # print(names(orig))

    # orig <- orig %>% dplyr::distinct(.keep_all = TRUE)
    # print(orig)
    mod  <- df_new()
    # mod <- mod[unique(indices[,1]), c(1,unique(indices[,2]))]

    # print(mod)
    # print(names(mod))

    mod <- tibble::as_tibble(mod)
    # orig <- mod[indices[,1], c(which(names(mod) %in% c("record_id", "unique_ctr_id")),unique(indices[,2]))]


    # print(mod)

    # orig_sub <- orig[, diff_cols, drop = FALSE]
    # mod_sub  <- mod[,  diff_cols, drop = FALSE]

    # orig_sub$comparison <- "Original"
    # mod_sub$comparison  <- "Modified"

    # res <- rbind(orig_sub, mod_sub)
    # res <- res[, c("comparison", diff_cols)]
    # res <- tibble::as_tibble(res)

    out <- data.table::rbindlist(
      list(dplyr::mutate(mod, source = "Updated"),
      dplyr::mutate(orig, source = "Original")), fill = T
    ) %>%
      dplyr::relocate(source)

    dt <- DT::datatable(
      out,
      rownames = FALSE,
      options = list(
        scrollX = TRUE,
        pageLength = 10
      )
    )

   # # ---- Highlight ONLY changed fields ----
   #  for (col in unique(names(out))) {
   #
   #    if (col %in% c("source","unique_ctr_id")) next
   #
   #    changed <- !isTRUE(
   #      all.equal(as.character(orig[[col]]), as.character(mod[[col]]), check.attributes = FALSE)
   #    )
   #
   #    dt <- dt %>%
   #      DT::formatStyle(
   #        columns = col,
   #        backgroundColor = DT::styleEqual(
   #          c(TRUE, FALSE),
   #          c("yellow", NA)
   #        )
   #      )
   #  }

    dt
  })


}
