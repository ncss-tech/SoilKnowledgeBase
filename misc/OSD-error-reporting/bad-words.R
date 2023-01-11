## Search for offensive soil series names in the full text of OSDs. Parsed OSDs via SKB are used for searching.
## D.E. Beaudette
## 2022-11-7


library(soilDB)
library(jsonlite)
library(furrr)
library(stringi)
library(pbapply)
library(lattice)
library(tactile)

# collapse JSON / structured form of OSD -> character vector
# 1 / series
# i: series name, case insensitive
prepareData <- function(i) {
  
  # local SKB repo
  # result is an empty data.frame when no matching record is available
  x <- get_OSD(i, base_url = '../../inst/extdata/OSD/')
  
  # remove parsed data
  x$HORIZONS <- NULL
  x$SITE <- NULL
  
  # flatten sections into single body of text
  x <- paste(unlist(x), collapse = '\n')
  
  # result is empty character vector when no parsed OSD is available
  return(x)
}

# search for words in a single OSD text
# NULL is returned when no matches are found
# NULL is returned when parsed OSD not available (i is an empty char vector)
# i: OSD text
# .words: vector of search terms
findWords <- function(i, .words) {
  
  # stringi functions automatically iterate over regex patterns
  # using word boundary markers to find entire words, not embedded in others
  # set case insensitive matching
  m <- stri_detect_regex(
    str = i, 
    pattern = sprintf("\\b%s\\b", .words), 
    opts_regex = stri_opts_regex(case_insensitive = TRUE)
  )
  
  # find matches
  idx <- which(m)
  
  # no matches
  if(length(idx) < 1) {
    return(NULL)
  }
  
  # at least one match found
  
  # this is kind of dumb
  # extract series name from first line of text
  .series <- strsplit(i, '\n', fixed = TRUE)[[1]][1]
  
  # collapse multiple matches
  .matches <- paste(.words[idx], collapse = ', ')
  
  # compile result: OSD + matching words
  res <- data.frame(
    series = .series, 
    matches = .matches
  )
  
  return(res)
}


## bad words
w <- read.table('E:/temp/badwords.txt')$V1

# test words: enmsure multiple matches are present
# w <- c('amador', 'gillender', 'peters', 'pentz')


## series names from SC DB via NASIS
sc <- get_soilseries_from_NASIS()

# series names, as named vector
# this will translate into named list elements
s <- sc$soilseriesname
names(s) <- s

# start parallel back-ends
plan(multisession)

## load from local GH repo in parallel
# <1 minute from local files
# 3x time when VPN is in use
osds <- future_map(s, .f = prepareData, .progress = TRUE)

# check: OK
head(names(s))
cat(osds[[1]])


## iterate over list of OSD text, find bad words
# ~ 21 seconds grep(..., fixed = TRUE) (VPN)
# ~ 28 minutes REGEX with grep() !
# ~ 13 seconds REGEX with str_detect_regex()
# ~ 5 seconds REGEX with str_detect_regex(), parallel
# TRUE -> bad word found
bad <-  future_map(osds, .f = findWords, .words = w, .progress = TRUE)

# stop back-ends
plan(sequential)

# flatten
bad <- do.call('rbind', bad)
row.names(bad) <- NULL

# possible false positives: TRUE|FALSE
# * location near Squaw Valley, CA
# * squaw carpet
.of <- stri_opts_fixed(case_insensitive = TRUE)
notbad <- pbsapply(osds, function(i) {
  # patterns
  m1 <- stri_detect_fixed(str = i, pattern = 'Squaw Valley', opts_fixed = .of)
  m2 <- stri_detect_fixed(str = i, pattern = 'squaw carpet', opts_fixed = .of)
  
  # any possible false positives
  .res <- m1 || m2
  return(.res)
})

## series with matches
# first run: 374
# 2022-12-29: 224
# 2023-01-11: 133
nrow(bad)

# frequency of bad words
dotplot(sort(table(bad$matches)), par.settings = tactile.theme(), xlab = 'Frequency')

# flag as possible false positives
names(which(notbad))

# tabulate by responsible office
z <- merge(bad, sc[, c('soilseriesname', 'mlraoffice')], by.x = 'series', by.y = 'soilseriesname', all.x = TRUE, sort = FALSE)

sort(table(z$mlraoffice), decreasing = TRUE)

# add false positives
z$falsePositive <- ''
z$falsePositive[z$series %in% names(which(notbad))] <- 'X'

# save
write.csv(z, file = 'series-with-bad-words.csv', row.names = FALSE)

# describe for Kyle
knitr::kable(z[sample(nrow(z), size = 10), ], row.names = FALSE)




