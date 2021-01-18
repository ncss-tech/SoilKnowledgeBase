#' Create GDS Dataset
#'
#' @param ... Arguments to \code{parse_GDS}
#' @return TRUE if successful
#' @export
create_GDS <- function(...) {
  download_GDS()
  parse_GDS()
}

download_GDS <- function() {

  download.file(destfile = "GDS.pdf",
                url = "https://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/nrcs142p2_051068.pdf")

  system(sprintf("pdftotext -raw -nodiag GDS.pdf"))
  # system(sprintf("pdftohtml GDS.pdf"))

  file.remove("GDS.pdf")

  dir.create("inst/extdata/GDS", recursive = TRUE)
  file.copy("GDS.txt","inst/extdata/GDS/GDS.txt")

  # htm <- list.files(pattern = "html")
  # file.copy(htm,"inst/extdata/GDS")

  # img <- list.files(pattern = "png|jpg")
  # file.copy(img,"inst/extdata/GDS")
  # file.remove(c("GDS.txt", img, htm))
}

parse_GDS <- function() {
  x <- readLines('inst/extdata/GDS/GDS.txt', warn = FALSE)

  # get GDS abbreviated outline (Phys. Location, Geomor. Description, Surface Morphometry)
  gds.outline.bounds <- grep('ABBREVIATED OUTLINE|DETAILED OUTLINE', x)
  stopifnot(length(gds.outline.bounds) == 2)

  abbreviated.outline <- data.frame(content = x[gds.outline.bounds[1]:(gds.outline.bounds[2] - 4)])
  abbreviated.outline$part <- cumsum(grepl("PART I+", abbreviated.outline$content))
  abbreviated.outline$tier <- do.call('c', aggregate(abbreviated.outline$content, by = list(abbreviated.outline$part),
                                                     function(x) cumsum(grepl("^[A-Z]\\)", x)))$x)
  abbreviated.outline$subtier <- do.call('c', aggregate(abbreviated.outline$content, by = list(abbreviated.outline$tier),
                                                        function(x) cumsum(grepl("^[1-9]\\)", x)))$x)

  write(jsonlite::toJSON(abbreviated.outline, pretty = TRUE, auto_unbox = TRUE),
        file = "inst/extdata/GDS/GDS_outline_abbrev.json")

  # TODO: detailed outline; using structure parsed from abbreviated

  # TODO: Physiographic Location
  # TODO: Geomorphic Description
  # - comprehensive lists: landscape, landform, microfeature, anthroscape, anthropogenic landforms, anthropogenic microfeatures
  # - geomorphic environments and other groupings: associations of terms grouped by process or setting
  # TODO: Surface Morphometry
  # - Several important figures and tables -- pdftohtml?
}
