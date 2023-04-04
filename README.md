
<!-- README.md is generated from README.Rmd. Please edit that file -->

# QSPtools

<!-- badges: start -->

<!-- badges: end -->

The goal of QSPtools is to put the various functions developed by the
Quantative Sciences Program into one place.

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
my_project <- fs::path(network_path(), "Projects", "My_Project")
my_project
#> /Volumes/Research/BM_QuantitativeSciencesPrg/Projects/My_Project
# df <- readr::read_csv(fs::path(my_project, "my_data.csv"))
```
