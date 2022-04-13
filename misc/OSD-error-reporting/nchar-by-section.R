
library(aqp)
library(soilDB)
library(pbapply)
library(latticeExtra)
library(tactile)
library(reshape2)


# series names to iterate over
sc <- get_soilseries_from_NASIS()

# load all OSDs
# ~ 6 minutes from local files
osds <- pblapply(sc$soilseriesname[500:550], FUN = get_OSD, base_url = 'E:/working_copies/SoilKnowledgeBase/inst/extdata/OSD/')


sectionCharacterCount <- function(i) {
  
  # ignore parsed data
  i$SITE <- NULL
  i$HORIZONS <- NULL
  
  # character count by section
  nc <- sapply(i, nchar)
  
  # replace NA with 0
  nc[which(is.na(nc))] <- 0
  
  # data.frame
  d <- data.frame(t(nc))
  
  return(d)
}


section.char.count <- pblapply(osds, sectionCharacterCount)
section.char.count <- do.call('rbind', section.char.count)

# wide -> long format
z <- melt(section.char.count)

# reverse factor levels 
# so that sections in figure are in the same logical ordering as the OSD
z$variable <- factor(z$variable, levels = rev(levels(z$variable)))


bwplot(
  variable ~ value, 
  data = z, 
  par.settings = tactile.theme(box.rectangle = list(fill = '#A1CBEEFF')),
  scales = list(x = list(tick.number = 10, log = 10, alternating = 3)),
  xscale.components = xscale.components.log10.3,
  xlab = 'Number of Characters in Section',
  main = 'OSD Section Summary',
  panel = function(...) {
    panel.abline(h = 1:ncol(section.char.count), lty = 3, col = grey(0.75))
    panel.abline(v = log10(c(3, 10, 30, 100, 300, 1000, 3000)), lty = 3, col = grey(0.75))
    panel.bwplot(...)
  }
)


tapply(z$value, z$variable, quantile, probs = c(0.05, 0.5, 0.95))

knitr::kable(
tapply(z$value, z$variable, max)
)


