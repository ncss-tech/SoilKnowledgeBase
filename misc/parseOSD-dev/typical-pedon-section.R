library(aqp)
library(soilDB)
library(data.table)

library(progress)

# for now, relative to /misc/OSD-error-reporting
osd.path <- 'inst/extdata/OSD'
output.path <- 'inst/extdata/OSD-error-reporting/'



# recent acreage estimates from SoilWeb
ac <- fread('https://github.com/ncss-tech/SoilWeb-data/raw/main/files/series_stats.csv.gz')
ac <- as.data.frame(ac)

# recent SC database
sc <- fread('https://github.com/ncss-tech/SoilWeb-data/raw/main/files/SC-database.csv.gz')
sc <- as.data.frame(sc)


# first line is TYPICAL PEDON
tp.check <- list()
missing.file <- list()
parse.error <- list()


pb <- progress_bar$new(
  format = "  processing local JSON files [:bar] :percent eta: :eta",
  total = length(sc$soilseriesname), clear = FALSE, width= 60
  )

# iteration over series names
for(i in sc$soilseriesname) {
  
  pb$tick()
  
  # important notes:
  # * some series in SC may not exist here
  # * these files may contain data.frames of varying structure
  tp <- suppressWarnings(get_OSD(i, result = 'json', base_url = osd.path)[['TYPICAL.PEDON']])
  
  # NULL -> no file
  if(is.null(tp)) {
    missing.file[i] <- i
    next
  }
  
  # NA -> parse error?
  if(is.na(tp)) {
    parse.error[i] <- i
    next
  }
  
  tp <- strsplit(tp, split = '\n')[[1]]
  
  tp.check[[i]] <- grepl('^TYP', tp[1])
  
}

pb$terminate()

idx <- which(tp.check == FALSE)
idx

## those are some funky OSDs...
#
# BAGGER       CALROY      COVEGAP   DOWNSVILLE       JESBEL      JUGTOWN        KERBY       MACOVE 
# 1151         3213         4784         5964        10222        10361        10751        12537 
# MANTON       MEIKLE       NORDIC       RINKER     SALLISAW SHIRLEYBASIN 
# 12748        13298        14814        17557        18107        18882 

