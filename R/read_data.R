#' Read SAGES I data from network
#'
#' This function reads in the SAGES I data that is saved on the network. It
#' will read in either the frozen or non-frozen data.  If the frozen data is selected
#' it can either read in the latest freeze or from a particular date.
#'
#' You must be on the Brown network to use this function.
#'
#' @param x String Abbreviation of the file to read in.
#'  '560' = The file identifying the n=560 sample
#'  'si' = Subject interview
#'  'hi' = Hospital interview
#'  'mr' = Medical record
#'  'cg' = Caregiver interview
#' @param frozen Logical Should a frozen file be used?
#' @param frozen_date String "YYYY-MM-DD" If frozen=TRUE, this is the date of the frozen file to use.  If unspecified, it will use
#' the latest frozen file.  The frozen dates are: "2019-04-23", "2021-05-03". If frozen=FALSE, this is the date of the
#' current file to use.  If unspecified, it will use the latest current file.  The current dates are: "2022-04-11", "2022-04-20".
#'
#'
#' @return Returns a tibble
#' @export
#'
#' @examples
#'
#' \dontrun{
#'   sages_data("si", frozen = TRUE, frozen_date = "2021-05-03")
#' }
#'
sages_data <- function(x, frozen=FALSE, frozen_date=NULL) {

  if (x=="cg") {
    file_name <- "SAGES-Caregiver-Interview-Data-Analysis-File.dta"
  } else if (x=="hi") {
    file_name <- "SAGES-Hospital-Interview-Analysis-File.dta"
  } else if (x=="mr") {
    file_name <- "SAGES-Medical-Review-Data-Analysis-File.dta"
  } else if (x=="si") {
    file_name <- "SAGES-Subject-Interview-Data-Analysis-File.dta"
  } else if (x=="560") {
    file_name <- "N560.dta"
  } else {
    stop("Please specify the data file. Either '560', si', 'mr', 'hi', or 'cg'")
  }


  data_path <- fs::path(network_path(), "STUDIES", "DATA_MANAGEMENT", "SAGES-I", "DATA", "SOURCE", "CLEAN")

  if (frozen==FALSE) {

    # If the frozen date isn't specified, use the most recent current data
    if (is.null(frozen_date)) {
      frozen_folder_names <- fs::dir_ls(fs::path(data_path, "FROZENFILES"))
      frozen_folder_df <- dplyr::tibble(frozen_folder_names)
      use_frozen_date <- frozen_folder_df %>%
        dplyr::mutate(folder_type = stringr::str_sub(frozen_folder_names, -15, -12),
                      folder_dates = stringr::str_sub(frozen_folder_names, -10, -1)) %>%
        dplyr::filter(folder_type == "rent") %>%
        dplyr::summarise(d = max(folder_dates)) %>%
        dplyr::pull(d)

    }
    # As more current data files are added, add them to this list
    if (!is.null(frozen_date)) {
      if (frozen_date %in% c("2022-04-11", "2022-04-20")) {
        use_frozen_date <- frozen_date
      } else {
        stop("The date of the current file is misspecified")
      }
    }


    full_path <- fs::path(data_path, "FROZENFILES", stringr::str_c("current_", use_frozen_date))
  }
  if (frozen==TRUE) {
    # If the frozen date isn't specified, use the most current data freeze
    if (is.null(frozen_date)) {
      frozen_folder_names <- fs::dir_ls(fs::path(data_path, "FROZENFILES"))
      frozen_folder_df <- dplyr::tibble(frozen_folder_names)
      use_frozen_date <- frozen_folder_df %>%
        dplyr::mutate(folder_type = stringr::str_sub(frozen_folder_names, -15, -12),
                      folder_dates = stringr::str_sub(frozen_folder_names, -10, -1)) %>%
        dplyr::filter(folder_type == "eeze") %>%
        dplyr::summarise(d = max(folder_dates)) %>%
        dplyr::pull(d)

    }
    # As more data freezes are performed, add them to this list
    if (!is.null(frozen_date)) {
      if (frozen_date %in% c("2019-04-23", "2021-05-03")) {
        use_frozen_date <- frozen_date
      } else {
        stop("The date of the frozen file is misspecified")
      }
    }

    full_path <- fs::path(data_path, "FROZENFILES", stringr::str_c("freeze_", use_frozen_date))
  }


  if(fs::dir_exists(full_path)==FALSE) {
    stop("There is an error with the folder path.  Either you're not connected to the network, or the folder is misspecified.")
  }

  df <- haven::read_dta(fs::path(full_path, file_name))
  df

}


#' Read SAGES II data from network
#'
#' This function reads in the SAGES II data that is saved on the network. It
#' will read in either the frozen or non-frozen data.  If the frozen data is selected
#' it can either read in the latest freeze or from a particular date.
#'
#' You must be on the Brown network to use this function.
#'
#' @param x String Abbreviation of the file to read in.
#'  'si' = Subject interview
#'  'hi' = Hospital interview
#'  'mr' = Medical record
#'  'cg' = Caregiver interview
#' @param frozen Logical Should a frozen file be used?
#' @param frozen_date String "YYYY-MM-DD" If frozen=TRUE, this is the date of the frozen file to use.  If unspecified, it will use
#' the latest frozen file.  The frozen dates are: "2022-09-19", "2022-10-05".
#'
#' @return Returns a tibble
#' @export
#'
#' @examples
#'
#' \dontrun{
#'   sagesII_data("si", frozen = TRUE, frozen_date = "2022-10-05")
#' }
#'
sagesII_data <- function(x, frozen=FALSE, frozen_date=NULL) {

  if (x=="cg") {
    file_name <- "SAGESII-Caregiver-Interview-Data-Analysis-File.dta"
  } else if (x=="hi") {
    file_name <- "SAGESII-Hospital-Interview-Analysis-File.dta"
  } else if (x=="mr") {
    file_name <- "SAGESII-Medical-Review-Data-Analysis-File.dta"
  } else if (x=="si") {
    file_name <- "SAGESII-Subject-Interview-Data-Analysis-File.dta"
  } else {
    stop("Please specify the data file. Either 'si', 'mr', 'hi', or 'cg'")
  }


  data_path <- fs::path(network_path(), "STUDIES", "DATA_MANAGEMENT", "SAGES-II", "DATA", "SOURCE", "CLEAN")

  if (frozen==FALSE) {
    full_path <- fs::path(data_path, "Preprocessing")
  }
  if (frozen==TRUE) {
    # If the frozen date isn't specified, use the most current data freeze
    if (is.null(frozen_date)) {
      frozen_folder_names <- fs::dir_ls(fs::path(data_path, "FROZENFILES"))
      folder_dates <- stringr::str_sub(frozen_folder_names, -10, -1)
      use_frozen_date <- base::max(folder_dates)
    }
    # As more data freezes are performed, add them to this list
    if (!is.null(frozen_date)) {
      if (frozen_date %in% c("2022-09-19", "2022-10-05")) {
        use_frozen_date <- frozen_date
      } else {
        stop("The date of the frozen file is misspecified")
      }
    }

    full_path <- fs::path(data_path, "FROZENFILES", stringr::str_c("freeze_", use_frozen_date))
  }


  if(fs::dir_exists(full_path)==FALSE) {
    stop("There is an error with the folder path.  Either you're not connected to the network, or the folder is misspecified.")
  }

  df <- haven::read_dta(fs::path(full_path, file_name))
  df

}

