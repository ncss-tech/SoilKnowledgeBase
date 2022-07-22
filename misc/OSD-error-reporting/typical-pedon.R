library(aqp)
library(data.table)

source("https://raw.githubusercontent.com/ncss-tech/soilDB/master/R/get_OSD.R")

# recent acreage estimates from SoilWeb
ac <- fread('https://github.com/ncss-tech/SoilWeb-data/raw/main/files/series_stats.csv.gz')
ac <- as.data.frame(ac)

# recent SC database from OSDRegistry
sc <- fread('https://github.com/ncss-tech/OSDRegistry/raw/main/SC/SCDB.csv')

## working on the output from SKB->OSD getting / parsing

# for now, relative to /misc/OSD-error-reporting
osd.path <- 'inst/extdata/OSD'
output.path <- 'inst/extdata/OSD-error-reporting/'

# about 3 minutes just to parse all the JSON files
# system.time({osds <- get_OSD(sc$soilseriesname, result = 'json', base_url = osd.path)})
#> user  system elapsed
#> 205.73    5.11  211.17

# keep subset of parsed data + current series name
.getOSD <- function(i) {
  # important notes:
  # * some series in SC (inactive without OSD) will not exist here
  hz <- get_OSD(i, result = 'json', base_url = osd.path)[['HORIZONS']][[1]]

  if (!is.null(hz) && nrow(hz) == 0)
    hz <- NULL
  # add series name
  hz$id <- i
  sci <- sc[which(sc$soilseriesname == i), ]
  if (is.null(hz$name) && (sci$soilseriesstatus != "Established")) {
    return(data.frame(missing_error = TRUE, parse_error = FALSE,
                      list(name = NA_character_, top = NA_character_, bottom = NA_character_), hz))
  }

  hz2 <- try(hz[, c('name', 'top', 'bottom', 'id')], silent = TRUE)

  if (inherits(hz2, 'try-error')) {
    return(data.frame(missing_error = FALSE, parse_error = TRUE,
                      list(name = NA_character_, top = NA_character_, bottom = NA_character_), hz))
  } else {
    hz2[c('name', 'top', 'bottom')] <- lapply(hz2[c('name', 'top', 'bottom')], as.character)
    return(data.frame(missing_error = FALSE, parse_error = FALSE, hz2))
  }
}

system.time({x <- sc[, .getOSD(soilseriesname), by = "soilseriesname"]})

## flatten

# missing files: likely old / retired OSDs
missing.file <- x$id[which(x$missing_error)]
length(missing.file)

# likely REGEX problems inherited from parseOSD
parse.error <- x$id[which(x$parse_error)]
length(parse.error)

# dput(parse.error)
cat(parse.error, file = file.path(output.path, 'misc-errors.txt'), sep = '\n')

# hz data -> SPC
depths(x) <- id ~ top + bottom
hzdesgnname(x) <- 'name'

# ignoring missing bottom-most horizon depths for now
x <- repairMissingHzDepths(x)

# standard checks
ck <- checkHzDepthLogic(x)

# how bad
# ~ 11.5%
table(ck$valid)
prop.table(table(ck$valid))

# subset / check
bad <- ck[which(!ck$valid), ]

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
  s <- s[order(s$ac, s$id, decreasing = TRUE), ]

  office <- sapply(strsplit(i, ',', fixed = TRUE), '[', 1)

  fn <- sprintf('%s/%s-series.csv', path, office)
  write.csv(s[, c('id', 'ac', 'benchmarksoilflag', 'soiltaxclasslastupdated')], file = fn, row.names = FALSE)

  z <- subset(x, id %in% s$id)
  ck.hz <- checkHzDepthLogic(z, byhz = TRUE)
  horizons(z) <- ck.hz[, -c(1:3)]

  h <- horizons(z)
  h.bad <- h[!h$valid, .SD, .SDcols = c(idname(z), hzdesgnname(z), horizonDepths(z))]

  fn <- sprintf('%s/%s-hz.csv', path, office)
  write.csv(h.bad, file = fn, row.names = FALSE)
}


## sort by RO and state -> save to TXT files

mo <- unique(bad$mlraoffice)

# remove inactive series with no mlraoffice assigned
bad <- subset(bad, !(is.na(mlraoffice) & soilseriesstatus == "Inactive"))

for (i in mo) {
  s <- bad[which(bad$overlapOrGap & bad$mlraoffice == i), ]

  if (nrow(s) > 0) {
    .processChunk(s, path = file.path(output.path, 'RO'))
  }
}

states <- unique(bad$areasymbol)
for (i in states) {
  s <- bad[which(bad$overlapOrGap & bad$areasymbol == i), ]

  if (nrow(s) > 0) {
    .processChunk(s, path = file.path(output.path, 'state'))
  }
}
