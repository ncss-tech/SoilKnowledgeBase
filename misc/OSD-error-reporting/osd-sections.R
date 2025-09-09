# check OSD sections/structural elements by parsing logfile from create_OSD()/validateOSD()
library(data.table)
osd_log <- "inst/extdata/OSD/OSD.log"

sc <- data.table::fread('https://github.com/ncss-tech/OSDRegistry/raw/main/SC/SCDB.csv')
sc <- as.data.frame(sc)

if (file.exists(osd_log)) {

  osd_loglines <- readLines(osd_log)
  osd_check <- osd_loglines[grepl("^CHECK", osd_loglines)]

  res <- data.table::rbindlist(lapply(strsplit(
    gsub(
      "CHECK:? ([A-Z a-z0-9]+):? .*/[A-Z]/([A-Z_]+)\\.txt ?(\\[.*\\])?",
      "\\1;;;;\\2;;;;\\3",
      osd_check
    ), ";;;;"
  ), function(x) data.frame(t(x))), fill = TRUE)

  if (ncol(res) > 3 ) {
    res <- res[,1:3]
  }

  colnames(res) <- c("errorkind", "soilseriesname", "context")

  res$soilseriesname <- gsub("_", " ", res$soilseriesname)

  res2 <- merge(res, sc[,c("soilseriesname", "mlraoffice")], by = "soilseriesname", all.x = TRUE, sort = FALSE)
  res2$ro <- gsub("(.*),.*", "\\1", res2$mlraoffice)
  ress <- split(res2, res2$ro)
  lapply(names(ress), function(x) {
    ress[[x]]$ro <- NULL
    write.csv(ress[[x]], sprintf("inst/extdata/OSD-error-reporting/RO/%s-sections.csv", x), row.names = FALSE)
  })
  
} else message("Could not find ", osd_log, "; try running create_OSD() or refresh() to create it")
