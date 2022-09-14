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

  hznames <- c('name', 'top', 'bottom',
               'dry_hue', 'dry_value', 'dry_chroma',
               'moist_hue', 'moist_value', 'moist_chroma')
  nalist <- as.list(rep(NA_character_, length(hznames)))
  names(nalist) <- hznames

  # important notes:
  # * some series in SC (inactive without OSD) will not exist here
  hz <- get_OSD(i, result = 'json', base_url = osd.path)[['HORIZONS']][[1]]

  if (!is.null(hz) && nrow(hz) == 0)
    hz <- NULL

  # add series name
  hz$id <- i
  sci <- sc[which(sc$soilseriesname == i), ]
  if (is.null(hz$name) && (sci$soilseriesstatus != "Established")) {
    return(data.frame(missing_error = TRUE, parse_error = FALSE, nalist, hz))
  }

  hz2 <- try(hz[, c(hznames, 'id')], silent = TRUE)

  if (inherits(hz2, 'try-error')) {
    return(data.frame(missing_error = FALSE, parse_error = TRUE, nalist, hz))
  } else {
    hz2[hznames] <- lapply(hz2[hznames], as.character)
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

spc <- x

# hz data -> SPC
depths(spc) <- id ~ top + bottom
hzdesgnname(spc) <- 'name'

# ignoring missing bottom-most horizon depths for now
spc <- repairMissingHzDepths(spc)

# color OCR error checks
spc <- mutate_profile(spc, any_dry_ocrerr = any(grepl("[Ol]", sprintf("%s %s/%s", dry_hue, dry_value, dry_chroma))),
                           any_moist_ocrerr = any(grepl("[Ol]", sprintf("%s %s/%s", moist_hue, moist_value, moist_chroma))),
                           any_hzname_ocrerr = any(grepl("[0l]", name)))

# number of OCR errors
table(spc$any_dry_ocrerr) # n=110 (when implemented)
table(spc$any_moist_ocrerr) # n=133
table(spc$any_hzname_ocrerr) # n=1005

# standard checks
ck <- checkHzDepthLogic(spc)

# how bad
# ~ 11.5%
table(ck$valid)
prop.table(table(ck$valid))

# subset / check
ck <- cbind(ck, site(spc)[, c("any_dry_ocrerr", "any_moist_ocrerr", "any_hzname_ocrerr")])
bad <- ck[which(!ck$valid | ck$any_dry_ocrerr | ck$any_moist_ocrerr | ck$any_hzname_ocrerr), ]

# including OCR errors adds about 700 "bad" series (when implemented)
# i.e. those that had color or designation errors but no depth problems

# combine with SC for additional info
bad <- merge(bad, sc, by.x = 'id', by.y = 'soilseriesname', all.x = TRUE, sort = FALSE)

# combine with series acreage estimates
bad <- merge(bad, ac, by.x = 'id', by.y = 'series', all.x = TRUE, sort = FALSE)

# remove inactive series with no mlraoffice assigned
bad <- subset(bad, !(is.na(mlraoffice) & soilseriesstatus == "Inactive"))

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

cat('### Hz Designation OCR Errors by State  ###')
table(bad$areasymbol, bad$any_hzname_ocrerr)
cat('--------------------------------------------------------\n\n')

cat('### Hz Dry Color OCR Errors by State  ###')
table(bad$areasymbol, bad$any_dry_ocrerr)
cat('--------------------------------------------------------\n\n')

cat('### Hz Moist Color OCR Errors by State  ###')
table(bad$areasymbol, bad$any_moist_ocrerr)
cat('--------------------------------------------------------\n\n')

sink()

# show counts in console
cat(readLines(file.path(output.path, 'log.txt')), sep = "\n")

.processChunk <- function(s, path) {
  # rank
  s <- s[order(s$ac, s$id, s$valid, decreasing = TRUE), ]

  office <- sapply(strsplit(i, ',', fixed = TRUE), '[', 1)
  s.sub <- s[, c('id', 'ac', 'benchmarksoilflag', 'soiltaxclasslastupdated')]
  s.sub$depthErrors <- !s$valid
  s.sub$ocrErrors <- (s$any_dry_ocrerr | s$any_moist_ocrerr | s$any_hzname_ocrerr)

  fn <- sprintf('%s/%s-series.csv', path, office)
  write.csv(s.sub, file = fn, row.names = FALSE)

  z <- subset(spc, id %in% s$id)
  ck.hz <- checkHzDepthLogic(z, byhz = TRUE)
  horizons(z) <- ck.hz[, -c(1:3)]

  z <- mutate_profile(z, dry_ocrerr = grepl("[Ol]", sprintf("%s %s/%s", dry_hue, dry_value, dry_chroma)),
                         moist_ocrerr = grepl("[Ol]", sprintf("%s %s/%s", moist_hue, moist_value, moist_chroma)),
                         hzname_ocrerr = grepl("[0l]", name))

  h <- horizons(z)
  h.bad <- h[!h$valid | h$dry_ocrerr | h$moist_ocrerr | h$hzname_ocrerr, .SD,
             .SDcols = c(idname(z), hzdesgnname(z), horizonDepths(z), "dry_hue", "dry_value", "dry_chroma", "moist_hue", "moist_value", "moist_chroma")]

  fn <- sprintf('%s/%s-hz.csv', path, office)
  write.csv(h.bad, file = fn, row.names = FALSE)
}

# debug mysterious error only occurring in GHA

## sort by RO and state -> save to TXT files

mo <- unique(bad$mlraoffice)
for (i in mo) {
  cat(i, sep = "\n")
  s <- bad[which((
    bad$overlapOrGap |
      bad$any_dry_ocrerr  |
      bad$any_moist_ocrerr |
      bad$any_hzname_ocrerr
  ) & bad$mlraoffice == i
  ), ]

  if (nrow(s) > 0) {
    try(.processChunk(s, path = file.path(output.path, 'RO')))
  }
}

states <- unique(bad$areasymbol)
for (i in states) {
  cat(i, sep = "\n")
  s <- bad[which((
    bad$overlapOrGap |
      bad$any_dry_ocrerr  |
      bad$any_moist_ocrerr |
      bad$any_hzname_ocrerr
  ) & bad$areasymbol == i
  ), ]

  if (nrow(s) > 0) {
    try(.processChunk(s, path = file.path(output.path, 'state')))
  }
}
