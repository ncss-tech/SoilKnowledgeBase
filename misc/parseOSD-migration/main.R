## Extract as much detail from text OSDs as possible, process colors, push to SoilWeb
## D.E. Beaudette
## 2019-11-19


#### old method ###
## 1. get / parse data
# ~ 4-5 hours with single thread
# source('parse-all-series-via-sc-db.R')
# ~ 42 minutes parallel
# source('parallelParseOSD.R')

###########################

#### new method

## 1. get / parse data
# ~ 3 minutes with local OSDRegistry files
# ~ fulltext source data is slow due to WD / scanning
source('use-OSDRegistry.R')


## 2. fill-in missing colors using OLS estimation of value and chroma
# ~ 2 minutes
source('predict-missing-colors-OLS.R')

## TODO: finish evaluation / interpretation of color models

## 3. diagnostics
source('diagnostics.R')

## 4. send to SoilWeb



## 5. re-load data: see sql/ dir in this repo



# stats
x <- read.csv('logfile-2018-01-05.csv', stringsAsFactors = FALSE)
table(x$sections)
