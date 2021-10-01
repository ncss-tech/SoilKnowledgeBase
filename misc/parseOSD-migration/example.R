library(stringi)
library(purrr)
library(httr)
library(rvest)
library(plyr)
library(aqp)

source('local_functions.R')


# funky SSRO1-style OSDs, put drainage class up top
res <- testIt('ZYGORE')
res$`site-data`

res <- testItLocal('ZYGORE')
res$`site-data`



testIt('PAIA')


testIt('TINTERO')


# color moist and dry not correctly interpreted
testIt('KALAPA')


# old-style O horizons and formatting errors
# https://github.com/dylanbeaudette/parse-osd/issues/12
testIt('KLAWASI')

# 
testIt('tiger creek')

# TYPICAL PEDON section is mis-labeled
# https://casoilresource.lawr.ucdavis.edu/sde/?series=MEIKLE
testIt('MEIKLE')

# O insteat of 0 in "1OYR 6/3"
# https://casoilresource.lawr.ucdavis.edu/sde/?series=ESPARTO
testIt('ESPARTO')

# latest OSD from Kyle
# informed by his OSD synthesis via NASIS report / components
testIt('bordengulch')

# missing  typical pedon header
testIt('ARIEL')

# no simple fix:" "O" instead of "0" in depths and colors
testIt('kuck')

# works
testIt('downer')

# missing "cm" 
testIt('hammonton')

# 
testIt('drummer')


# brief narrative not parsed, extra white space after SERIES
testIt('ATOMIC')

# brief narrative not parsed: fixed 2017-09-02
testIt('amador')

# typos related to OCR: fixed 2017-08-08
testIt('rincon')

# typos related to OCR: fixed 2017-08-08
testIt('solano')

# first horizon depths use inconsistent units specification: incorrect conversion applied
testIt('proper')

# can't parse (N 3/)
testIt('demas')

# horizons are multi-line records... REGEX can't parse
testIt('HELMER')

# fixed B and N hues
testIt('SOUTHPOINT')

# fixed: 5GY hues
testIt('figgs')

# fixed
# multiple matches in type location
testIt('URLAND')

# fixed
# multiple, exact matches for typical pedon
testIt('MANASTASH')
testIt('KEAA')

# missing "TYPICAL PEDON"
testIt('ARIEL')
testIt('PACKSADDLE')

# no white space, fixed
# "TYPICAL PEDON:"
testIt('dinuba')

# "TYPICAL PEDON;"
testIt('NEISSENBERG')

# funky white space
testIt('ODESSA')

## multiple matches for typical pedon
testIt('CAJON')

## no OSD..
testIt('FUCHES')

# white-space in front of section names: fixed
testIt('BRYMAN')

# missing dry/moist flag
testIt('ADAMSTOWN')
extractSections(x)


testIt('Funkstown')


# section names have no spaces...
testIt('TUSKAHOMA')


# typos and ?
testIt('vance')


# errors in OSD: "A1, A3--0 to 19 inches;"
testIt('whitney')


# can't parse this: (10YR 3/1 moist or dry)
testIt('salinas')


# error in O horizon narrative
testIt('CROQUIB')


# false-positives matched in RIC section
# -> fixed in post-processing SQL code
testIt('humeston')


# variation on type location
testIt('ANAN')


# multiple mention of "type location" 
testIt('yutan')


# multiple mention of "type location" 
testIt('filbert')


# "E and Bt1"
testIt('colonie')


# some problematic OSDs
testIt('pardee')


## TODO, still not correct as all colors are moist
testIt('canarsie')


testIt('capay')


testIt('academy')


testIt('newot')


testIt('flagspring')


# error in "TYPICAL PEDON" heading
testIt('ACKWATER')


testIt('CASA GRANDE')


# return NULL
# strange notation: A [A1]--0 to 10 cm (4 inches)
testIt('RAPSON')


testIt('KILFOIL')


# "TYPICAL PEDON-"
testIt('MENTZ')


# non-standard TYPE LOCATION heading 
testIt('ALBUS')


# no OSD document
testIt('YALE')





# parsing all of the series data could be done from the SC database...
