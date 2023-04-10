
<!-- README.md is generated from README.Rmd. Please edit that file -->

# QSPtools

<!-- badges: start -->
<!-- badges: end -->

The goal of QSPtools is to put the various functions developed by the
Quantative Sciences Program into one place. There are functions that:

- set the netowrk path to the Brown network
- directly read data from select studies that are saved on the Brown
  network
- perform data checking

## Installation

You can install the development version from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("dougtommet/QSPtools")
```

## Example

``` r
library(QSPtools)

# Network functions
my_project <- fs::path(QSPtools::network_path(), "Projects", "My_Project")
my_project
#> /Volumes/Research/BM_QuantitativeSciencesPrg/Projects/My_Project
# df <- readr::read_csv(fs::path(my_project, "my_data.csv"))

# Read data functions
# QSPtools::sages_data("si", frozen = TRUE, frozen_date = "2021-05-03")
# QSPtools::sagesII_data("si", frozen = TRUE, frozen_date = "2022-10-05")

# Check data functions
df <- tibble::tibble(a = c(rep(1, 10), rep(2, 10)),
                     b = c(rep(1, 5), rep(2, 10), rep(3, 5)))
df <- df %>%
  dplyr::mutate(new_var = a + b)
df %>%
  QSPtools::checkvar(new_var, a, b)
#> # A tibble: 4 × 4
#>   new_var     a     b     n
#>     <dbl> <dbl> <dbl> <int>
#> 1       2     1     1     5
#> 2       3     1     2     5
#> 3       4     2     2     5
#> 4       5     2     3     5
```
