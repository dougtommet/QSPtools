


#'Check the values of variables used as inputs into a created variable
#'
#'This function creates a summary data frame showing each value of a created
#'variable, followed by each unique combinations of values of the component
#'varables used to create it. The frequency of each combination is reported.
#'
#'The summary table is more useful if the created and component variables are
#'discrete and have few levels.
#'@param df The dataframe in which the new variable was created
#'@param created_var The name of the created varaiable
#'@param ... The names of the component variables
#'
#'@return a data frame of summary values
#'@export
#'
#' @examples
#' df <- tibble::tibble(a = c(rep(1, 10), rep(2, 10)),
#'                      b = c(rep(1, 5), rep(2, 10), rep(3, 5)))
#' df <- df %>%
#'   dplyr::mutate(new_var = a + b)
#' df %>%
#'   checkvar(new_var, a, b)

checkvar <- function(df, created_var, ...) {
  df %>%
    dplyr::group_by({{created_var}}, ...) %>%
    dplyr::count() %>%
    dplyr::ungroup()
}
