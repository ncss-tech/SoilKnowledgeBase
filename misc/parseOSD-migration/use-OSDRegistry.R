library(stringi)
library(httr)
library(rvest)
library(purrr)
library(furrr)
library(R.utils)


## TODO: remove dependency
# used by extractHzData()
library(plyr)

# moved low-level file access here
library(soilDB)

## TODO: convert to JSON section


# functions used here, some of which will go to soilDB
source('local_functions.R')

## TODO: get latest SC from local NASIS if available

# load latest SC-database
tf <- tempfile()
download.file(url = 'https://github.com/ncss-tech/SoilTaxonomy/raw/master/inst/extdata/SC-database.csv.gz', destfile = tf)
x <- read.csv(tf, stringsAsFactors = FALSE)

# keep only those records that are established or tentative
x <- subset(x, subset= soilseriesstatus != 'inactive')

# keep just the series names 
x <- x$soilseriesname
names(x) <- x


# init parallel processing, works on macos and windows
plan(multisession)

# using local copy of OSDs via OSDRegistry working copy
# ~ 3 minutes
system.time(res <- future_map(x, downloadParseSave.safe, .progress = TRUE))

# stop back-ends
plan(sequential)


########################################


## TODO: update cached copy, for those series that have been updated since the last run
# cache results just in case
saveRDS(res, file='cached-copy.rds')


## process horizon data
z <- map(res, pluck, 'result', 'hz')
# remove NULL
idx <- which(! sapply(z, is.null))
z <- z[idx]
# convert to data.frame (~ 15 seconds)
d <- do.call('rbind', z)
# save
write.csv(d, file=gzfile('parsed-data.csv.gz'), row.names=FALSE)

## process site data
z <- map(res, pluck, 'result', 'site')
# remove NULL
idx <- which(! sapply(z, is.null))
z <- z[idx]
# convert to data.frame (~ 1 seconds)
d <- do.call('rbind', z)
# save
write.csv(d, file=gzfile('parsed-site-data.csv.gz'), row.names=FALSE)



## process fulltext
z <- map(res, pluck, 'result', 'fulltext')
# iterate over list elements and write to file (~ 5 minutes, slow due to scanning)
makeFullTextTable(z)

# process sections
z <- map(res, pluck, 'result', 'sections')
makeFullTextSectionsTable(z)


## compress fulltext
f <- list.files(path='.', pattern = '\\.sql$', full.names = TRUE)

for(i in f) {
  print(i)
  gzip(i, remove=TRUE, skip=FALSE)
}




## TODO: finish error checking and "problem OSDs"

# # save dated log file
# write.csv(logdata, file=paste0('logfile-', Sys.Date(), '.csv'), row.names=FALSE)
# 
# # ID those series that were not parsed
# parse.errors <- logdata$.id[which(! logdata$`hz-data` & logdata$sections)]
# cat(parse.errors, file=paste0('problem-OSDs-', Sys.Date(), '.txt'), sep = '\n')





## done, now fill missing colors via supervised classification

