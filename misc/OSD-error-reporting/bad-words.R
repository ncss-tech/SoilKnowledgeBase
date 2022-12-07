library(soilDB)
library(furrr)
library(stringi)
library(pbapply)


# bad words
w <- read.table('E:/temp/badwords.txt')$V1

# series names
sc <- get_soilseries_from_NASIS()

# collapse JSON / structured form of OSD -> character vector
# 1 / series
prepareData <- function(i) {
  
  x <- get_OSD(i, base_url = '../../inst/extdata/OSD/')
  
  # parsed data
  x$HORIZONS <- NULL
  x$SITE <- NULL
  
  x <- paste(unlist(x), collapse = '\n')
  
  return(x)
}


# load from local report in parallel
# <1 minute from local files
# 3x time when VPN is in use
plan(multisession)
osds <- future_map(sc$soilseriesname, .f = prepareData, .progress = TRUE)
plan(sequential)

# transfer names
names(osds) <- sc$soilseriesname

# OK
cat(osds[[1]])

# search for words in a single OSD text
findWords <- function(i) {
  
  # stringi functions automatically iterate over regex
  # search for words padded by word boundary markers
  m <- stri_detect(i, regex = sprintf("\\b%s\\b", w))
  
  # find matches
  idx <- which(m)
  
  # no matches
  if(length(idx) < 1) {
    return(NULL)
  }
  
  # at least one match found
  
  # this is kind of dumb
  # extract series name
  .series <- strsplit(i, '\n', fixed = TRUE)[[1]][1]
  
  # collapse matches in case > 1
  .matches <- paste(w[idx], collapse = ', ')
  
  # compile result into data.frame
  res <- data.frame(series = .series, matches = .matches)
  
  return(res)
}

# ~ 21 seconds fixed string matching (VPN)
# ~ 28 minutes REGEX with grep() !
# ~ 8 seconds REGEX with str_detect()
# TRUE -> bad word found
bad <- pblapply(osds, findWords)

# flatten
bad <- do.call('rbind', bad)
row.names(bad) <- NULL

# possible false positives due to location near Squal Valley, CA
notbad <- pbsapply(osds, function(i) {
  m <- stri_detect(str = i, fixed = 'Squaw Valley')
  m
})

# flag as possible false positives
names(which(notbad))


# 326 series with matches
nrow(bad)

# frequency of bad words
sort(table(bad$matches), decreasing = TRUE)

# save
write.csv(bad, file = 'series-with-bad-words.csv', row.names = FALSE)

# describe for Kyle
knitr::kable(bad[1:10, ])



