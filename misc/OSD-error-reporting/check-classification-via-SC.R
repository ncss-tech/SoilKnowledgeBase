
## TODO: convert this for use by GH actions


library(aqp)
library(soilDB)
library(pbapply)
library(daff)


cleanSectionTitle <- function(s) {
  .text <- gsub(pattern = "^[a-zA-Z1-9 ]+\\s?:\\s*", replacement = "", x = s)
  return(.text)
}


sc <- get_soilseries_from_NASIS()

# ~ 6 minutes from local files
osds <- pblapply(sc$soilseriesname, FUN = get_OSD, base_url = 'E:/working_copies/SoilKnowledgeBase/inst/extdata/OSD/')


d <- data.frame(
  series = sc$soilseriesname,
  status = sc$soilseriesstatus,
  SC.taxcl = sc$taxclname
)

osds.taxcl <- pblapply(osds, FUN = function(i) {
  
  # cleanup parsed taxonomic label
  # remove section title
  # upper case
  # trim white space
  .cl <- trimws(toupper(cleanSectionTitle(i$TAXONOMIC.CLASS)), which = 'both')
  
  # remove newline
  .cl <- gsub(pattern = '\n', replacement = '', x = .cl, fixed = TRUE)
  
  res <- data.frame(
    series = toupper(i$SERIES),
    OSD.taxcl = .cl
  )
  
  return(res)
  
})

osds.taxcl <- do.call('rbind', osds.taxcl)


x <- merge(d, osds.taxcl, by = 'series', all.x = TRUE, sort = FALSE)

x$flag <- x$SC.taxcl != x$OSD.taxcl

# 123 series
table("does not match" = x$flag)
table("series status" = x$status, "does not match" = x$flag)

idx <- which(x$flag)

z <- x[idx, ]

z$series

m <- sc$soiltaxclasslastupdated[match(sc$soilseriesname, z$series)]
m <- na.omit(m)

summary(m)


sc.to.fix <- sc[sc$soilseriesname %in% z$series, ]

table(sc.to.fix$mlraoffice)

options(width = 500)
knitr::kable(z[1:10, 3:4])

write.csv(z, file = '../../inst/extdata/OSD-error-reporting/taxclassname-errors.csv', row.names = FALSE)


## record differences
.d <- diff_data(data_ref = z[, c('series', 'SC.taxcl')], data = z[, c('series', 'OSD.taxcl')])

render_diff(.d, file = 'E:/temp/OSD-vs-SC.html', title = 'SC vs. OSD')

