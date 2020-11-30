#' Parse headers and line positions by NSSH Part and Subpart
#'
#' @param number Vector of part number(s) e.g. \code{600:614}
#' @param subpart Vector of subpart characters e.g. \code{"A"}
#'
#' @return A data.frame containing line numbers corresponding to NSSH part and subpart headers.
#' @export
parse_nssh_part <- function(number, subpart) {

  do.call('rbind', lapply(split(data.frame(number = number, subpart = subpart),
                            1:length(number)), function(x) {

    idx <- respart <- ressubpart <- numeric(0)

    try( {
      f <- sprintf("inst/extdata/NSSH/%s/%s%s.txt",
                   x$number, x$number, x$subpart)
      
      if(!file.exists(f))
        return(NULL)
      
      L <- readLines(f, warn = FALSE)

        idx <- grep("^\\d{3}\\.\\d+ [A-Z]", L)
  
        respart <- rep(x$number, length(idx))
        ressubpart <- rep(x$subpart, length(idx))
  
  
        res <- data.frame(part = x$number,
                        subpart = x$subpart,
                        line = idx,
                        header = L[idx])
      return(res)
    } )
  }))
}
