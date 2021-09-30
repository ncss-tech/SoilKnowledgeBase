# library(SoilKnowledgeBase)
library(soilDB)

# get latest version via HTML interface
# latest soilDB contains a fix to properly launder the result
o <- get_OSD('mendel', result = 'html')

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



lines <- strsplit(x$`TYPICAL PEDON`$content, split = '\n')[[1]]


lines <- strsplit("TYPICAL PEDON: Mendel very cobbly coarse sandy loam on a south facing (165 degree), 4 percent slope under a cover of timber oatgrass, dwarf bilberry, and scattered Sierra lodgepole pine at an elevation of 3221 meters. (Colors are for dry soils unless otherwise noted. When described on August 3, 2015 the soil was moist to 66 cm, wet, non-satiated from 66-105 cm, and wet, satiated from 66-150 cm. A water table was observed at 95 cm.)", split = '\n')[[1]]


z <- SoilKnowledgeBase:::.extractHzData(lines)
z[, 1:5]
