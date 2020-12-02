parse_NSSH_618A <- function() {
  
  raw_618a <- "inst/extdata/NSSH/618/618A.txt"
  stopifnot(file.exists(raw_618a)) 
  raw <- readLines(raw_618a)
  
  headers <- get_assets('NSSH','headers')[[1]]
  
  a_part <- 618
  a_subpart <- "A"
  
  headers <- subset(headers, part == a_part & subpart == a_subpart)
  
  sect.idx <- c(1, headers$line, length(raw))
  llag <- sect.idx[1:(length(sect.idx - 1))]
  llead <- sect.idx[2:(length(sect.idx))]
                
  hsections <- lapply(1:(nrow(headers) + 1), function(i) {
    fix_line_breaks(clean_chars(strip_lines(raw[llag[i]:(llead[i] - 1)])))
  })
  
  names(hsections) <- c("frontmatter", gsub("^(\\d+\\.\\d+) .*", "\\1", headers$header))
  res <- convert_to_json(hsections)
  write(res, file = "inst/extdata/NSSH/618/618A.json")
  return(TRUE)
}

# collapse multiline content into "clauses"
fix_line_breaks <- function(x) {
  # starts with A. (1) or 618. is a new line
  
  ids <- strsplit(gsub("^(\\d+)\\.(\\d+) (.*)$", "\\1:\\2:\\3", x[1]), ":")
   
  res <- aggregate(x, 
                   by = list(cumsum(grepl("^[A-Z]\\.|^6[0-9]{2}\\. ", x))), # |^\\(\\d+\\) -- not sure if this is desired
                   FUN = paste, collapse = " ")
  
  # check for clauses that dont start with a capital letter, a number or a parenthesis
  fclause.idx <- !grepl("^[A-Zivx0-9\\(]", res$x)
  
  if (length(fclause.idx) > 0)
    res$Group.1[fclause.idx] <- res$Group.1[fclause.idx] - 1
  
  res2 <- aggregate(res$x,
                     by = list(res$Group.1),
                     FUN = paste, collapse = " ")
  
  # idx.bad <- which(!grepl("\\.$", res2$x))
  # res3 <- aggregate(res2$x,
  #                   by = list(cumsum()),
  #                   FUN = paste, collapse = " ")
  
  colnames(res2) <- c("clause","content")
  res2$part <- ids[[1]][1]
  res2$headerid <- ids[[1]][2]
  res2$header <- ids[[1]][3]
  res2$clause <- 1:nrow(res2)
  return(res2)
}

# remove material associated with page breaks and footnotes
strip_lines <- function(x) {
  idx <- grep("\\fTitle 430 â€“ National Soil Survey Handbook|(430-6\\d{2}-., 1st|Ed., Amend. \\d+, [A-Za-z]+ \\d+)|6\\d{2}-[AB].\\d+|^Subpart [AB] ", x)
  idx.fn <- grep("-------------", x)
  if (length(idx.fn))
    x <- x[1:(idx.fn[1] - 1)]
  if (length(idx) > 0) 
    return(x[-idx])
  return(x)
}

# TODO: placeholder; better fixing of unicode stuff
clean_chars <- function(x) {
  x <- gsub("â€”",'"', x)
  return(x)
}

# each dataset-specific script needs to call itself
phase1 <- parse_NSSH_618A()
# parse_NSSH_618B()

