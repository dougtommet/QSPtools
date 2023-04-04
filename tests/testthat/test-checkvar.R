


# test_that("checkvar works", {
#   df <- tibble::tibble(a = c(rep(1, 10), rep(2, 10)),
#                        b = c(rep(1, 5), rep(2, 10), rep(3, 5))) %>%
#     dplyr::mutate(new_var = a + b)
#
#   df_summary <- tibble::tibble(new_var = c(2, 3, 4, 5),
#                                a = c(1, 1, 2, 2),
#                                b = c(1, 2, 2, 3),
#                                n = c(5, 5, 5, 5)) %>%
#     dplyr::mutate(n = as.integer(n))
#
#   testthat::expect_equal(df_summary, checkvar(df, new_var, a, b))
# }
# )
