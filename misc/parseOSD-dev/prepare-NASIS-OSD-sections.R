library(soilDB)


x <- get_OSD('peters')

# remove section title, not present in all sections
cleanSectionTitle <- function(s) {
  .text <- gsub(pattern = "^[a-zA-Z1-9 ]+\\s?:\\s*", replacement = "", x = s)
  return(.text)
}

# section chunks
chunkNames <- c("OVERVIEW", 
       "TAXONOMIC.CLASS", "TYPICAL.PEDON", "TYPE.LOCATION", "RANGE.IN.CHARACTERISTICS", 
       "COMPETING.SERIES", "GEOGRAPHIC.SETTING", "GEOGRAPHICALLY.ASSOCIATED.SOILS", 
       "DRAINAGE.AND.PERMEABILITY", "USE.AND.VEGETATION", "DISTRIBUTION.AND.EXTENT", 
       "REGIONAL.OFFICE", "ORIGIN", "REMARKS", "ADDITIONAL.DATA")

# iterate over subset of section names, just those we intend to insert into the OSD table
x.clean <- lapply(chunkNames, function(i) {
  # remove section title if present
  res <- cleanSectionTitle(x[[i]])
  return(res)
})

# reset names
names(x.clean) <- chunkNames



