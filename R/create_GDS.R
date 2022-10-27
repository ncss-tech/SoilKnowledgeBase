#' Create GDS Dataset
#'
#' @param ... Arguments to \code{parse_GDS}
#' @return TRUE if successful
#' @export
create_GDS <- function(...) {

    parse_GDS(...)

}

#' @importFrom curl curl_download
download_GDS <- function(outpath = "./inst/extdata",
                         output_types = "txt",
                         keep_pdf = FALSE, ...) {


    # TODO: convert to pdftools

    curl::curl_download(destfile = "GDS.pdf",
                        url = "https://www.nrcs.usda.gov/sites/default/files/2022-10/GDS_v5.pdf",
                        handle = .SKB_curl_handle(),
                        ...)

    system(sprintf("pdftotext -raw -nodiag GDS.pdf"))


    dir.create(file.path(outpath, "GDS"), recursive = TRUE)

    if (file.exists("GDS.txt")) {
      file.copy("GDS.txt", file.path(outpath, "GDS/GDS.txt"))
      file.remove("GDS.txt")
    }

    if ("html" %in% output_types) {
      system(sprintf("pdftohtml GDS.pdf"))

      htm <- list.files(pattern = "html")
      file.copy(htm, file.path(outpath, "GDS"))

      img <- list.files(pattern = "png|jpg")
      file.copy(img, "GDS")

      file.remove(c(img, htm))
    }

    if (!keep_pdf) {
      if (file.exists("GDS.pdf"))
        file.remove("GDS.pdf")
    }
}

#' parse_GDS
#'
#' @param logfile Path to log file; default: \code{file.path(outpath, "GDS/GDS.log")}
#' @param outpath A directory path to create "inst/extdata/NSSH" folder structure.
#' @param download_pdf Download official PDF file? default: "ifneeded"; options: TRUE/FALSE
#' @param output_types Options include \code{c("txt","html")} for processed PDF files.
#' @param keep_pdf Keep PDF files after processing TXT
#' @importFrom stats aggregate
#'
parse_GDS <- function(logfile = file.path(outpath, "GDS/GDS.log"),
                      outpath = "./inst/extdata",
                      download_pdf = "ifneeded",
                      output_types = c("txt"), #, "html"
                      keep_pdf = FALSE) {

  gds_path <- file.path(outpath, "GDS/GDS.txt")

  if (!file.exists(gds_path) | as.character(download_pdf)[1] == "TRUE")
    if (!as.character(download_pdf)[1] == "FALSE") {
      logmsg(logfile, "Downloading Geomorphic Description System document...")
      download_GDS(outpath, keep_pdf = keep_pdf, output_types = output_types)
    }

  if (file.exists(gds_path)) {
    x <- readLines(gds_path, warn = FALSE)

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
          file = file.path(outpath, "/GDS/GDS_outline_abbrev.json"))
    logmsg(logfile, "Wrote abbreviated Geomorphic Description System outline")
  } else {
    logmsg(logfile, "Skipped GDS download")
  }
  return(TRUE)
    # TODO: detailed outline; using structure parsed from abbreviated

    # TODO: Physiographic Location
    # TODO: Geomorphic Description
    # - comprehensive lists: landscape, landform, microfeature, anthroscape, anthropogenic landforms, anthropogenic microfeatures
    # - geomorphic environments and other groupings: associations of terms grouped by process or setting
    # TODO: Surface Morphometry
    # - Several important figures and tables -- pdftohtml?

}
