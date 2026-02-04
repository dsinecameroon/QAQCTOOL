combine_dummy_vars <- function(df, var){

  # Pivot all dummy columns into long format
  df_in <- df %>%
    dplyr::select(matches(paste0(var, "___"))) %>%
    tidyr::pivot_longer(cols = everything(),
                        names_to = "name",
                        values_to = "flag") %>%
    dplyr::filter(flag == 1)

  # If exactly one is selected, extract its code
  if (nrow(df_in) == 1) {
    code <- stringr::str_remove(df_in$name, paste0(var, "___"))
    out = code

  } else if (nrow(df_in) == 0) {
    out <- NA

  } else {
    # Multiple selected -> collapse into comma-separated string
    codes <- stringr::str_remove(df_in$name, paste0(var, "___"))
    out <- codes

  }

  return(out)
}


combine_location_vars <- function(df){

  # injury area

    row <- dplyr::select(matches("inj_loc_"))


  # If exactly one is selected, extract its code
  if (nrow(df_in) == 1) {
    code <- stringr::str_remove(df_in$name, paste0(var, "___"))
    out = code

  } else if (nrow(df_in) == 0) {
    out <- NA

  } else {
    # Multiple selected -> collapse into comma-separated string
    codes <- stringr::str_remove(df_in$name, paste0(var, "___"))
    out <- codes

  }

  return(out)
}



# get_changed_fields <- function(df, id, id_col = "unique_ctr_id", input) {
#   old_row <- df[df[[id_col]] == id, , drop = FALSE]
#
#   cols <- names(old_row)
#
#   cols[sapply(cols, function(col) {
#     old <- old_row[[col]]
#     new <- input[[col]]
#
#     if (is.null(new)) return(FALSE)
#     if (is.na(old) && is.na(new)) return(FALSE)
#
#     !identical(old, new)
#   })]
# }

# get_changed_cols <- function(df, input, id, id_col = "unique_ctr_id") {
#
#   # extract original 1-row record
#   old_row <- df[df[[id_col]] == id, , drop = FALSE]
#
#   # ensure record exists
#   if (nrow(old_row) != 1) return(character(0))
#
#   cols <- names(old_row)
#
#   # compare each input value with original
#   changed <- cols[sapply(cols, function(col) {
#     new <- input[[col]]
#
#     # skip if UI doesn't contain this input
#     if (is.null(new)) return(FALSE)
#
#     old <- old_row[[col]]
#
#     # treat both NA as unchanged
#     if (is.na(old) && is.na(new)) return(FALSE)
#
#     !identical(old, new)
#   })]
#
#   return(changed)
# }

#'@param df1 source dataset
#'@param df2 destination dataset
#'@example path.R indices <- get_diff_indices(new_test_data, test_data)

get_diff_indices <- function(df1, df2) {
  stopifnot(nrow(df1) == nrow(df2), ncol(df1) == ncol(df2))

  df1 <- as.data.frame(lapply(df1, as.character), stringsAsFactors = FALSE)
  df2 <- as.data.frame(lapply(df2, as.character), stringsAsFactors = FALSE)

  mismatch_matrix <- mapply(function(x, y) {

    # treat NA and "" as equivalent
    x_empty <- is.na(x) | x == ""
    y_empty <- is.na(y) | y == ""

    # no mismatch if both are empty
    ifelse(x_empty & y_empty, FALSE, x != y)

  }, df1, df2)

  # Ensure matrix shape for single-row case
  if (is.null(dim(mismatch_matrix))) {
    mismatch_matrix <- matrix(mismatch_matrix, nrow = 1)
  }

  which(mismatch_matrix, arr.ind = TRUE)
}

# get_diff_indices <- function(df1, df2) {
#   stopifnot(nrow(df1) == nrow(df2), ncol(df1) == ncol(df2))
#
#   df1 <- as.data.frame(lapply(df1, as.character), stringsAsFactors = FALSE)
#   df2 <- as.data.frame(lapply(df2, as.character), stringsAsFactors = FALSE)
#
#   mismatch_matrix <- mapply(function(x, y) {
#     !(is.na(x) & is.na(y)) & x != y
#   }, df1, df2)
#
#   if (is.null(dim(mismatch_matrix))) {
#     mismatch_matrix <- matrix(mismatch_matrix, nrow = 1)
#   }
#
#   which(mismatch_matrix, arr.ind = TRUE)
# }


