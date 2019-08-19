
<!-- README.md is generated from README.Rmd. Please edit that file -->

# abmisc

<!-- badges: start -->

<!-- badges: end -->

Various functions that don’t fit elsewhere.

## Installation

``` r
library("remotes")
install_github("andybega/abmisc")
```

## Example

Fix dates in CSV files that have been touched by Excel:

``` r
library("abmisc")

x <- c("1/20/53", "1890-01-23", "12/1/53", "1/12/53", "1/1/09")
data.frame(input = x, output = fix_csv_excel_dates(x), stringsAsFactors = FALSE)
#>        input     output
#> 1    1/20/53 1953-01-20
#> 2 1890-01-23 1890-01-23
#> 3    12/1/53 1953-12-01
#> 4    1/12/53 1953-01-12
#> 5     1/1/09 2009-01-01
```
