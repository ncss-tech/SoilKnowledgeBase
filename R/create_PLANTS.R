# create PLANTS snapshot
#
#' Create PLANTS Dataset
#'
#' @param ... Arguments to `parse_PLANTS()` function. Only `outpath` supported at this time.
#' @return `TRUE` if successful
#' @export
#' @importFrom data.table fread
create_PLANTS <- function(...) {
  parse_PLANTS(...)
}

parse_PLANTS <- function(outpath = "inst/extdata", ...) {

  x <- data.table::fread('https://plants.usda.gov/assets/docs/CompletePLANTSList/plantlst.txt')

  d <- file.path(outpath, "PLANTS")
  f <- file.path(d, "plantlst.csv")

  if (!dir.exists(d)) {
    dir.create(d, showWarnings = FALSE)
  }

  x$sciname <- .clean_PLANT_sciautnames(x$`Scientific Name with Author`)

  res <- try(write.csv(x, f, row.names = FALSE,))

  !inherits(res, 'try-error') && file.exists(f)
}

.clean_PLANT_sciautnames <- function(x) {
  gsub(
    "^(\u00d7?[A-Z][a-z\\-]+ [\u00d7a-z\\-]+)[^\\.]*( [A-Za-z]+\\.)?( ?[varssp]{3}\\. [a-z\\-]+)?.*$|^([\u00d7?A-Z][a-z\\-]+) [A-Z\\(].*$|(\u00d7?[A-Z][a-z\\-]+) .*|^([A-Z]?[a-z]+-?[A-Z]?[a-z]+ [a-z]+-?[a-z]+) ?.*$|.*",
    "\\1\\3\\4\\5\\6",
    x
  )
}

