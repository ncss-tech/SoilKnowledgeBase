## compare TAXONOMIC CLASS section of each OSD to a snapshot of the SC DB
## this script should be run via GH actions.
## 

library(aqp)
library(soilDB)

## toggle local / GH actions
.local <- TRUE

if(.local) {
  ## local version
  
  library(pbapply)
  sc <- get_soilseries_from_NASIS()  
  
} else {
  
  ## GH actions version
  
  # get snapshot of SC
  tf <- tempfile(fileext = '.zip')
  td <- tempdir()
  u <- 'https://github.com/ncss-tech/OSDRegistry/releases/download/main/SC-data-snapshot.zip'
  download.file(u, destfile = tf, mode = 'wb', quiet = TRUE)

  # unzip container
  unzip(zipfile = tf, exdir = td, overwrite = TRUE)

  # unzip time-stamped version
  sc.zip <- list.files(td, pattern = 'SC_', full.names = TRUE)
  unzip(zipfile = sc.zip, exdir = td, overwrite = TRUE)

  # the file is in td/SC/SCDB.csv
  sc <- read.csv(file.path(td, 'SC', 'SCDB.csv'))
}


# clean unexpected chars from the section titles
cleanSectionTitle <- function(s) {
  .text <- gsub(pattern = "^[a-zA-Z1-9 ]+\\s?:\\s*", replacement = "", x = s)
  return(.text)
}

# ~ 6 minutes from local files
osds <- pblapply(sc$soilseriesname, FUN = get_OSD, base_url = 'inst/extdata/OSD/')


# SC version
d <- data.frame(
  series = sc$soilseriesname,
  status = sc$soilseriesstatus,
  SC.taxcl = sc$taxclname
)

# iteratively get / clean TAXONOMIC CLASS sections
# from local OSDs
osds.taxcl <- pblapply(osds, FUN = function(i) {
  
  # cleanup parsed taxonomic label
  # remove section title
  # upper case
  # trim white space
  .cl <- trimws(toupper(cleanSectionTitle(i$TAXONOMIC.CLASS)), which = 'both')
  
  # remove newline
  .cl <- gsub(pattern = '\n', replacement = '', x = .cl, fixed = TRUE)
  
  res <- data.frame(
    series = toupper(i$SERIES),
    OSD.taxcl = .cl
  )
  
  return(res)
})

osds.taxcl <- do.call('rbind', osds.taxcl)

# combine SC + OSD versions
x <- merge(d, osds.taxcl, by = 'series', all.x = TRUE, sort = FALSE)

# flag those that aren't matching exactly
x$flag <- x$SC.taxcl != x$OSD.taxcl

# extract flagged records 
idx <- which(x$flag)
z <- x[idx, ]


# save results, only when run by GH action
if(! .local) {
  write.csv(z, file = 'inst/extdata/OSD-error-reporting/taxclassname-errors.csv', row.names = FALSE)
}

# quick check: ~ 125 non-matching
if(.local) {
  
  table("does not match" = x$flag)
  table("series status" = x$status, "does not match" = x$flag)
  
  # is there a pattern in time?  
  m <- sc$soiltaxclasslastupdated[match(sc$soilseriesname, z$series)]
  m <- na.omit(m)
  summary(m)
  
  # pattern among offices
  sort(table(sc$mlraoffice[idx]))
  
  # record differences
  library(daff)
  .d <- diff_data(data_ref = z[, c('series', 'SC.taxcl')], data = z[, c('series', 'OSD.taxcl')])
  
  # save locally
  render_diff(.d, file = 'S:/NRCS/Archive_Dylan_Beaudette/Focus-Teams/OSD/OSD-vs-SC.html', title = 'SC vs. OSD')
  
  write.csv(z, file = 'S:/NRCS/Archive_Dylan_Beaudette/Focus-Teams/OSD/taxclassname-errors.csv', row.names = FALSE)
  
  # https://github.com/ncss-tech/SoilKnowledgeBase/issues/49
  # parse errors due to funky typical pedon section header
  bad.tp.section.header <- z$series[which(nchar(z$OSD.taxcl) > 200)]
  
  # list for GH issue / email to SRSS
  dput(bad.tp.section.header)
  cat(sprintf('https://casoilresource.lawr.ucdavis.edu/sde/?series=%s#osd', bad.tp.section.header), sep = '\n')
}






