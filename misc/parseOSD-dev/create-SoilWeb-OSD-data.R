devtools::load_all()

library(aqp)
library(soilDB)
library(data.table)
library(progress)


## temporary parking place for full text processing functions
source('fulltext-to-merge.R')


# recent SC database
sc <- fread('https://github.com/ncss-tech/SoilWeb-data/raw/main/files/SC-database.csv.gz')
sc <- as.data.frame(sc)

# only using soil series names
sc <- sc$soilseriesname

## working on the output from SKB->OSD getting / parsing

## TODO: double-check funky names like "O'BRIEN" and chars not [a-z]

## TODO: add entire OSD -> fulltext data

## TODO: narratives in the JSON files have leading white space

# for now, relative to /misc/OSD-error-reporting
osd.path <- '../../inst/extdata/OSD'
# output.path <- 'inst/extdata/OSD-error-reporting/'

# OSDs to process, typically all of them
# debugging
# idx <- 1:500
idx <- 1:length(sc)

# lists to hold pieces
hz.data <- list()
site.data <- list()
missing.file <- list()
fulltext.records <- list()

# section names we will be extracting for SoilWeb / NASIS
section.names <- c("OVERVIEW", "TAXONOMIC.CLASS", "TYPICAL.PEDON", "TYPE.LOCATION", "RANGE.IN.CHARACTERISTICS", "COMPETING.SERIES", "GEOGRAPHIC.SETTING", "GEOGRAPHICALLY.ASSOCIATED.SOILS", "DRAINAGE.AND.PERMEABILITY", "USE.AND.VEGETATION", "DISTRIBUTION.AND.EXTENT", "REMARKS", "ORIGIN", "ADDITIONAL.DATA")


## TODO: convert this to furrr / parallel processing

pb <- progress_bar$new(
  format = "  processing [:bar] :percent eta: :eta", 
  total = length(sc[idx])
)

# ~ 6 minutes
# iteration over series names
for(i in sc[idx]) {

  pb$tick()
    
  # important notes:
  # * some series in SC may not exist here
  # * these files may contain data.frames of varying structure
  osddf <- get_OSD(i, result = 'json', base_url = osd.path)
  
  # typical pedon section, already broken into pieces
  hz <- osddf[['HORIZONS']][[1]]
  s <- osddf[['SITE']][[1]]
  
  # missing files / generate warnings
  if(is.null(hz)) {
    missing.file[[i]] <- i
    next
  }
  
  ## horizon data
  # file exists, but perhaps nothing was extracted... why?
  if(inherits(hz, 'data.frame')) {
    if(nrow(hz) > 0) {
      # add series name to last column, for compatibility with SoilWeb OSD import
      hz$seriesname <- i
      
      # append
      hz.data[[i]] <- hz
    }
  }
  
  ## site data
  # columns should contain: drainage, drainage_overview, id
  if(inherits(s, 'data.frame')) {
    # remove 'id' column
    s$id <- NULL
    
    ## TODO: consider keeping both
    # if the drainage class is missing from the DRAINAGE section use whatever was found in the overview
    s$drainage <- ifelse(is.na(s$drainage), s$drainage_overview, s$drainage)
    
    # remove drainage overview for now
    s$drainage_overview <- NULL
    
    # add series name
    s$seriesname <- i
    
    # append
    site.data[[i]] <- s
  }
  
  ## attempt narrative chunks
  .narratives <- list()
  for(sn in section.names) {
    .text <- osddf[[sn]]
    
    # remove section title, not present in all sections
    .text <- gsub(pattern = "^[a-zA-Z1-9 ]+\\s?:\\s*", replacement = "", x = .text)
    
    # convert NA -> ''
    
    # pack into a list for later
    .narratives[[sn]] <- .text
  }
  
  ## store the section fulltext INSERT statements
  # with compression: 61 MB
  # without compression: 232 MB
  fulltext.records[[i]] <- memCompress(
    .ConvertToFullTextRecord2(s = i, narrativeList = .narratives),
    type = 'gzip'
  )
  
}


pb$terminate()





## flatten
# missing files: likely old / retired OSDs
missing.file <- as.vector(do.call('c', missing.file))
length(missing.file)

## horizon data: may not share the same column-ordering
hz <- as.data.frame(rbindlist(hz.data, fill = TRUE))

# re-order
vars <- c("name", "top", "bottom", "dry_hue", "dry_value", "dry_chroma", 
          "moist_hue", "moist_value", "moist_chroma", "texture_class", 
          "cf_class", "pH", "pH_class", "distinctness", "topography", "narrative", 
          "seriesname")

hz <- hz[, vars]

## site data, all items should be conformal
s <- as.data.frame(rbindlist(site.data))


## save hz + site data
write.csv(hz, file = gzfile('parsed-data.csv.gz'), row.names = FALSE)
write.csv(s, file = gzfile('parsed-site-data.csv.gz'), row.names = FALSE)

## re-make section fulltext table + INSERT statements
# 6 minutes
system.time(.makeFullTextSectionsTable(fulltext.records))
# gzip
R.utils::gzip('fulltext-section-data.sql', overwrite = TRUE)

## TODO: investigate missing records, relative to the last time this was run
# nrow(read.csv('E:/working_copies/parse-osd/R/parsed-data.csv.gz'))
# nrow(read.csv('E:/working_copies/parse-osd/R/parsed-site-data.csv.gz'))


## fill missing colors
source('predict-missing-colors-OLS.R')


## push files to soilweb
## load tables
## make sketches
## make SDE figures



