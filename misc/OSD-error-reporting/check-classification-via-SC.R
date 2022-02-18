
## TODO: convert this for use by GH actions


library(aqp)
library(soilDB)
library(pbapply)


cleanSectionTitle <- function(s) {
  .text <- gsub(pattern = "^[a-zA-Z1-9 ]+\\s?:\\s*", replacement = "", x = s)
  return(.text)
}


sc <- get_soilseries_from_NASIS()

osds <- pblapply(sc$soilseriesname, FUN = get_OSD, base_url = 'E:/working_copies/SoilKnowledgeBase/inst/extdata/OSD/')


d <- data.frame(
  series = sc$soilseriesname,
  status = sc$soilseriesstatus,
  SC.taxcl = sc$taxclname
)

osds.taxcl <- pblapply(osds, FUN = function(i) {
  
  res <- data.frame(
    series = toupper(i$SERIES),
    OSD.taxcl = toupper(cleanSectionTitle(i$TAXONOMIC.CLASS))
  )
  
  return(res)
  
})

osds.taxcl <- do.call('rbind', osds.taxcl)


x <- merge(d, osds.taxcl, by = 'series', all.x = TRUE, sort = FALSE)

x$flag <- x$SC.taxcl != x$OSD.taxcl

table("does not match" = x$flag)
table("series status" = x$status, "does not match" = x$flag)

idx <- which(x$flag)

x$series[idx]

m <- sc$soiltaxclasslastupdated[match(sc$soilseriesname, x$series[idx])]
m <- na.omit(m)

summary(m)


sc.to.fix <- sc[sc$soilseriesname %in% x$series[idx], ]

table(sc.to.fix$mlraoffice)



