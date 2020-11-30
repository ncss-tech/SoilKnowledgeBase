parse_NSSH_618 <- function() {
  stopifnot(file.exists("inst/extdata/NSSH/618/618A.txt")) 
  cat("Parsing NSSH Part 618... ")
}

# each dataset-specific script needs to call itself
parse_NSSH_618()
