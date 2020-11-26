parse_nssh_part <- function(number, subpart) {
  do.call('c', lapply(split(data.frame(number = number,
                                       subpart = subpart),
                            1:length(number)), function(x) {
    L <- readLines(sprintf("inst/extdata/NSSH/%s/%s%s.txt",
                           x$number,x$number,x$subpart))
    L[grep("^\\d{3}\\.\\d+ ", L)]
  }))
}