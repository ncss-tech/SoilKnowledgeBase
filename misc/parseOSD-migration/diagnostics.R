library(Hmisc)

## note: must explicitly use print() when source()-ing code that includes sink()

## parsed from OSDs, no cleaning / estimation of missing colors
d <- read.csv('parsed-data.csv.gz', stringsAsFactors=FALSE)

## dump basic summary, skipping horizon narratives
options(width=160)
sink(file='QC/parsed-hz-data-summary.txt')
print(Hmisc::describe(d[, grep('narrative', names(d), invert = TRUE)]))
sink()


## parsed from OSDs, no cleaning / estimation of missing colors
s <- read.csv('parsed-site-data.csv.gz', stringsAsFactors=FALSE)

## dump basic summary, skipping last column containing horizon narratives
options(width=160)
sink(file='QC/parsed-site-data-summary.txt')
print(Hmisc::describe(s))
sink()


## parsed from OSDs, after cleaning
d <- read.csv('parsed-data-est-colors.csv.gz', stringsAsFactors=FALSE)

## dump basic summary, skipping horizon narratives
options(width=160)
sink(file='QC/cleaned-hz-data-summary.txt')
print(Hmisc::describe(d[, grep('narrative', names(d), invert = TRUE)]))
sink()
