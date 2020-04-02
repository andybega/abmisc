#' Find R package depedendencies
#'
#' Recursively search R and Rmd files for packages that are loaded via `library()``
#' or `require()`.
#'
#' @param path Folder in which to search
#'
#' @details This function will search for all files ending in ".R", ".r", or
#' ".Rmd" and extract the subjects of library and require calls in them. The
#' intended use is to make it easier to identify package dependencies for a
#' project using R.
#'
#' @examples
#' \dontrun{
#' # Find packages and write to a txt file
#' packs <- find_packages("./R")
#' writeLines(packs, "required-packages.txt")
#' }
#' @export
find_packages <- function(path = "./") {

  code_files <- dir("./", recursive = TRUE, pattern = "\\.(R|r)(md)?$")
  packs <- lapply(code_files, function(x) {
    x <- readLines(x)
    r <- stringr::str_extract(x, "(library|require)\\(\"?[:alnum:]+\"?\\)")
    r[!is.na(r)]
  })

  packs <- unlist(packs)
  packs <- str_replace(packs, "library\\(\"?([:alnum:]+)\"?\\)", "\\1")
  packs <- sort(unique(packs))
  packs

}

