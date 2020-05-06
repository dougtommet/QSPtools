

#' Create a Path to the QSP Network Drive
#'
#' This function creates a path to the QSP directory on the network drive. It
#' will automatically determine if the local machine runs Windows or MacOS, and
#' set the appropriate start of the network path.  This is not yet set up for
#' Linux machines.
#'
#' This function will create the path object.  To use it, you must either be on
#' the Brown network or VPN into it.
#'
#' @param windows_path The path to use on Windows machines.
#' @param mac_path The path to use on Macs.
#'
#' @return a fs::path() object
#' @export
#'
#' @examples
#' my_path <- network_path()
#' my_project <- fs::path(network_path(), "Projects", "My_Project")
#'
network_path <- function(windows_path = fs::path("R:"), mac_path = fs::path("/Volumes", "Research")) {
  # Need to add a condition for linux users
  windows_machine <- ifelse(grepl("windows", Sys.info()['sysname'], ignore.case=T), 1, 0)
  if(windows_machine==1) {
    # For Windows machines
    if (is.null(windows_path)) {
      stop("Needs a path to the network directory.")
    }
    network_start <- windows_path
  } else {
    # For Macs
    if (is.null(mac_path)) {
      stop("Needs a path to the network directory.")
    }
    network_start <- mac_path
  }
  networkpath <- fs::path(network_start, "BM_QuantitativeSciencesPrg")
  networkpath
}

