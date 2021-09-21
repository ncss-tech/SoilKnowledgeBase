library(aqp)
library(soilDB)
library(data.table)

library(progress)


# recent acreage estimates from SoilWeb
ac <- fread('https://github.com/ncss-tech/SoilWeb-data/raw/main/files/series_stats.csv.gz')
ac <- as.data.frame(ac)

# recent SC database
sc <- fread('https://github.com/ncss-tech/SoilWeb-data/raw/main/files/SC-database.csv.gz')
sc <- as.data.frame(sc)

## working on the output from SKB->OSD getting / parsing

## TODO: double-check funky names like "O'BRIEN" and chars not [a-z]

# for now, relative to /misc/OSD-error-reporting
osd.path <- 'inst/extdata/OSD'
output.path <- 'inst/extdata/OSD-error-reporting/'


## BUG: make a ticket for cases like this
## bottom horizon depths are missing
# get_OSD('ALMAVILLE', result = 'json', base_url = osd.path)[['HORIZONS']][[1]][, 1:5]
#
# horizon names are missing from fetchOSD() / parseOSD approach but horizon names are wrong


# keep subset of parsed data + current series name
# ~ 3 minutes on local machine

# local copy + names -> named list
x <- list()
missing.file <- list()
parse.error <- list()

## only for interactive use
pb <- progress_bar$new(total = length(sc$soilseriesname))

for(i in sc$soilseriesname) {
  
  pb$tick()
  
  # important notes:
  # * some series in SC may not exist here
  # * these files may contain data.frames of varying structure
  hz <- get_OSD(i, result = 'json', base_url = osd.path)[['HORIZONS']][[1]]
  
  # missing files / generate warnings
  if(is.null(hz)) {
    missing.file[[i]] <- i
    next
  }
  
  # errors here when parsing errors lead to inconsistent DF
  hz <- try(hz[, c('name', 'top', 'bottom')], silent = TRUE)
  if(inherits(hz, 'try-error')) {
    parse.error[[i]] <- i
    next
    
  } else {
    # add series name
    hz$id <- i
    
    x[[i]] <- hz
  }
  
}
  
pb$terminate()


## flatten

# missing files: likely old / retired OSDs
missing.file <- as.vector(do.call('c', missing.file))
length(missing.file)

# likely REGEX problems inherited from parseOSD
parse.error <- as.vector(do.call('c', parse.error))
length(parse.error)

# dput(parse.error)
cat(parse.error, file = file.path(output.path, 'misc-errors.txt'), sep = '\n')

# hz data
x <- do.call('rbind', x)

# init SPC
depths(x) <- id ~ top + bottom
hzdesgnname(x) <- 'name'

# ignoring missing bottom-most horizon depths for now
x <- repairMissingHzDepths(x)

# standard checks
ck <- checkHzDepthLogic(x)

# how bad
# ~ 7%
table(ck$valid)
prop.table(table(ck$valid))

# subset / check
bad <- ck[which(! ck$valid), ]



# combine with SC for additional info
bad <- merge(bad, sc, by.x = 'id', by.y = 'soilseriesname', all.x = TRUE, sort = FALSE)

# combine with series acreage estimates
bad <- merge(bad, ac, by.x = 'id', by.y = 'series', all.x = TRUE, sort = FALSE)

## tabulate errors -> logfile
sink(file = file.path(output.path, 'log.txt'))

cat('### Problems by RO  ###')
table(bad$mlraoffice)
cat('--------------------------------------------------------\n\n')

cat('### Depth Logic Errors by RO  ###')
table(bad$mlraoffice, bad$depthLogic)
cat('--------------------------------------------------------\n\n')


cat('### Hz Overlap / Gap Errors by RO  ###')
table(bad$mlraoffice, bad$overlapOrGap)
cat('--------------------------------------------------------\n\n')

cat('### Depth Logic / Gap Errors by State  ###')
table(bad$areasymbol, bad$depthLogic)
cat('--------------------------------------------------------\n\n')

cat('### Hz Overlap / Gap Errors by State  ###')
table(bad$areasymbol, bad$overlapOrGap)
cat('--------------------------------------------------------\n\n')

sink()


.processChunk <- function(s, path) {
  # rank
  s <- s[order(s$ac, decreasing = TRUE), ]
  
  office <- sapply(strsplit(i, ',', fixed = TRUE), '[', 1)
  
  fn <- sprintf('%s/%s-series.csv', path, office)
  write.csv(s[, c('id', 'ac', 'benchmarksoilflag', 'soiltaxclasslastupdated')], file = fn, row.names = FALSE)
  
  z <- subset(x, id %in% s$id)
  ck.hz <- checkHzDepthLogic(z, byhz = TRUE)
  horizons(z) <- ck.hz[, -c(1:3)]
  
  h <- horizons(z)
  h.bad <- h[!h$valid, c(idname(z), hzdesgnname(z), horizonDepths(z))]
  
  fn <- sprintf('%s/%s-hz.csv', path, office)
  write.csv(h.bad, file = fn, row.names = FALSE)
}


## sort by RO and state -> save to TXT files

mo <- unique(bad$mlraoffice)
for(i in mo) {
  # subset
  s <- bad[bad$overlapOrGap & bad$mlraoffice == i, ]
  
  if(nrow(s) > 0) {
    .processChunk(s, path = file.path(output.path, 'RO'))
  }
}

states <- unique(bad$areasymbol)
for(i in states) {
  # subset
  s <- bad[bad$overlapOrGap & bad$areasymbol == i, ]
  
  if(nrow(s) > 0) {
    .processChunk(s, path = file.path(output.path, 'state'))  
  }
}





