#' Fetch the assets associated with a specified dataset folder and name
#'
#' @param folder A folder name (e.g. \code{"NSSH"})
#' @param name A regular expression matching target asset file names (e.g. \code{"index"})
#'
#' @return A list, 1 list element per data source / file matching folder and name conditions
#' @export
get_assets <- function(folder, name) {
  filenames <- list.files(file.path("inst/extdata", folder), 
                          pattern =  name, 
                          full.names = TRUE)
  res <- lapply(filenames, .read_asset)
  names(res) <- filenames
  return(res)
}

#' Internal method for reading assets from known filetypes
#'
#' @param fname A (singular) file name for an asset
#'
#' @return A data.frame or similar data object
#'
#' @importFrom utils read.csv
#' @importFrom tools file_ext
.read_asset <- function(fname) {
  
  fxt <- tolower(tools::file_ext(fname))
  
  stopifnot(length(fxt) == 1)
  
  if (fxt == 'csv') {
    # .csv    
    return(utils::read.csv(fname))
  } else if (fxt ==  'json') {
    # .json
    stop("TODO: JSON assets")
  } else {
    # ???
    stop("unknown asset")
  }
  
}
