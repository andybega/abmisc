#' Fix mangled dates
#'
#' Try to fix dates in a CSV file that has received the Excel kiss of death.
#'
#' @param x ([base::character()]) \cr
#'   A character vector of dates
#'
#' @return A [base::Date()] vector.
#'
#' @examples
#' x <- c("1/20/53", "1890-01-23", "12/1/53", "1/12/53", "1/1/09")
#' data.frame(input = x, output = fix_csv_excel_dates(x), stringsAsFactors = FALSE)
#'
#' # decades/years less than or requal to today's are assumed to be this
#' # century, 20th century otherwise
#' now <- as.integer(substr(Sys.Date(), 3, 4))
#' x <- sprintf("1/1/%s", now + -1:2)
#' data.frame(input = x, output = fix_csv_excel_dates(x), stringsAsFactors = FALSE)
#'
#' @export
fix_csv_excel_dates <- function(x) {
  orig <- x
  # add missing century
  # assume that years <= current year are this century, rest 20th century
  current_year <- as.integer(substr(Sys.Date(), 3, 4))
  x <- strsplit(x, "/")
  x <- lapply(x, function(i) {
    if (length(i)==3) {
      i  <- as.integer(i)
      i3 <- i[3]
      i[3] <- ifelse(i3 <= current_year, 2000L + i3, 1900L + i3)
    }
    i
  })

  # paste back toISO-8601 Y-m-d form
  x <- sapply(x, function(i) {
    if (length(i)==3) {
      i <- paste(i[3], i[1], i[2], sep = "-")
    }
    i
  })

  x <- as.Date(x, format = "%Y-%m-%d", origin = "1970-01-01")
  x
}
