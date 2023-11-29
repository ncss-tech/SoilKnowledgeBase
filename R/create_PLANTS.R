# create PLANTS snapshot
#
#' Create PLANTS Dataset
#'
#' @param ... Arguments to `create_*()` function. Only `outpath` supported at this time.
#' @return TRUE if successful
#' @export
#' @importFrom data.table fread
create_PLANTS <- function(...) {

  args <- list(...)
  if (!is.null(args[["outpath"]])) {
    outpath <- args[["outpath"]]
  }

  x <- data.table::fread('https://plants.usda.gov/assets/docs/CompletePLANTSList/plantlst.txt')

  d <- file.path(outpath, "PLANTS")
  f <- file.path(d, "plantlst.csv")

  if (!dir.exists(d)) {
    dir.create(d, showWarnings = FALSE)
  }

  res <- try(write.csv(x, f, row.names = FALSE,))

  !inherits(res, 'try-error') && file.exists(f)
}
