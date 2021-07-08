

# format sources
formatSource <- function(i) {
  # source ID
  source.id <- names(i) 
  
  cat(sprintf("<li><b>%s:&nbsp;</b>", source.id))
  
  # references
  trash <- lapply(i[[1]], function(j) {
    cat(
      sprintf("%s</li>", j)
    )
  })
  
}


formatSourceList <- function(x) {
  
  cat("<p><ul><br>")
  
  for(i in 1:length(x)){
    formatSource(x[i])
  }
  
  cat("</ul></p><br>\n")
}



# automatic vectorization, def is a data.frame
formatGlossaryDef <- function(def) {
  
  res <- sprintf(
      "%s&nbsp;%s&nbsp;(%s)",
      def[['text']],
      def[['compare']],
      paste(def[['sources']][[1]], collapse = ', ')
    )
  
  return(res)  
  
}


formatGlossaryTerm <- function(i) {
  g.term <- names(i)
  
  def <- i[[g.term]][['def']]
  def.txt <- formatGlossaryDef(def)
  
  cat(
    sprintf(
      "<li><b>%s:&nbsp;</b>%s</li>",
      g.term,
      def.txt
    )
  )
  
}

formatGlossaryList <- function(x) {
  
  cat("<p><ul><br>")
  
  for(i in 1:length(x)){
    formatGlossaryTerm(x[i])
  }
  
  cat("</ul></p><br>\n")
}


# findReplaceComparisons <- function(x) {
#     
#   pat <- 'Compare.*\\.'
#   
#   # search for comparisons
#   comp <- stri_extract_all_regex(x, pattern = pat, simplify = TRUE)
#   comp <- as.vector(comp)
#   
#   # remove comparison text if found
#   if(! is.na(comp)) {
#     # replace with empty string
#     x <- gsub(x, pattern = comp, replacement = '', fixed = TRUE)
#     # clean white space
#     x <- stri_trim_both(x)
#   } else {
#     comp <- NA
#   }
#   
#   return(comp)
# }
