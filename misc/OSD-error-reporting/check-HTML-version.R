# library(SoilKnowledgeBase)
library(soilDB)

# get latest version via HTML interface
# latest soilDB contains a fix to properly launder the result
o <- get_OSD('chualar', result = 'html')

# use throw-away files as place-holders
logfile <- tempfile()
OSDtext <- tempfile()

# dump HTML -> TEXT -> FILE
cat(o, file = OSDtext, sep = '\n')

# split into sections + check
x <- validateOSD(logfile, filepath = OSDtext)

# parse site/horizon data
# note: missing series name in hz data
parsed.OSD <- .doParseOSD(x)

# check:
s <- parsed.OSD$`hz-data`
s[, 1:5]

