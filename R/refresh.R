# refresh.R
#' Refresh the entire SoilKnowledgeBase inst/extdata/ folder 
#' 
#' @description This method calls all functions defined in the SoilKnowledgeBase package with the prefix \code{create_} in the function name. 
#'
#' @param ... Arguments passed to \code{parse_nssh_index} or similar index-creating methods
#'
#' @return TRUE if all \code{create_} functions returned TRUE. 
#' @export
refresh <- function(...) {
  
  exportfn_sub <- get_create_functions()
  
  res <- try(lapply(exportfn_sub, function(x) get(x)(...)))
  
  if (!is.list(res))
     if (inherits(res, 'try-error'))
        return(FALSE)
  
  return(res)
}

#' Get \code{create_} functions used to build SoilKnowledgeBase
#'
#' @return A vector of functions with \code{create_} prefix in name
#' @export
get_create_functions <- function() {
  
  require(SoilKnowledgeBase)
  
  exportfn <- ls('package:SoilKnowledgeBase')
  exportfn[grepl("^create_.*", exportfn)]
  
}
