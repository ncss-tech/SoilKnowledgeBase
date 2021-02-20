# Create OSD data structures in inst/extdata

#' Create OSD Dataset
#'
#' @param ... Arguments to \code{parse_OSD}
#' @return TRUE if successful
#' @export
create_OSD <- function(...) {

  attempt <- try({

        message("Processing OSD data snapshot from OSDRegistry...")

        # Download OSDRegistry snapshot
        download_OSD()

        # Optional: special scripts can be called from inst/scripts/OSD
        #  rpath <- list.files("inst/scripts/OSD/", ".*.R", full.names = TRUE)
        #
        # # Find each .R file (one or more for each part) and source them
        # lapply(rpath, function(filepath) {
        #   if (file.exists(filepath))
        #     source(filepath)
        # })

        ## TODO: dedicated/built-in methods for wrangling the OSDRegistry snapshot
        # parse_OSD(...)

      })

  if (inherits(attempt, 'try-error'))
    return(FALSE)

  message("Done!")
  return(TRUE)
}

#' Internal method for downloading OSDRegistry snapshot
#'
#' @description This is an internal method for downloading the latest snapshot (or sample ZIP) containing Official Series Description (OSD) text files in an alphabetical folder structure. These files are un-zipped and processed into JSON which is stored in \code{"inst/extdata/OSD"}
#'
#' @details Default path to OSD data snapshot is an "artifact" created by the \code{refresh-osd} workflow on the \href{https://github.com/ncss-tech/OSDRegistry}{OSDRegistry} GitHub Repository.
#'
#' The latest version of the snapshot can be downloaded as a ZIP file from this URL: \url{https://github.com/ncss-tech/OSDRegistry/releases/download/main/OSD-data-snapshot.zip}.
#'
#' Note: This is a ZIP file within a ZIP file where the internal ZIP file has a unique (weekly) date stamp.
#'
#' @param url Path to OSD Data Snapshot
#'
#' @return TRUE if successful, try-error if download or parsing fails
#' @importFrom utils unzip
download_OSD <- function(url = NULL) {
  if (is.null(url))
    url <- 'https://github.com/ncss-tech/OSDRegistry/releases/download/main/OSD-data-snapshot.zip'
  download.file(url, "OSD.zip")
  unzip('OSD.zip')
  file.remove('OSD.zip')
  wkzip <- list.files(pattern = "OSD_.*zip")
  unzip(wkzip)
  file.remove(wkzip)
  res <- osd_to_json(output_dir = "inst/extdata/OSD")
  stopifnot(all(res))
  unlink("OSD", recursive = TRUE)
  return(TRUE)
}

#' Validate OSD using NSSH standards
#' @param filepath Path to a single plain text file containing OSD narrative
#'
#' @return A nested list containing OSD structure for specified file path
#' @export
#' @importFrom stringi stri_trans_general
validateOSD <- function(filepath) {

  if (!file.exists(filepath))
    return(FALSE)

  raw <- scan(file = filepath,
              what = character(),
              sep = "\n", quiet = TRUE)
  raw <- stringi::stri_trans_general(raw, "Latin-ASCII")

  raw <- trimws(raw[trimws(raw) != ""])

  # TODO: abstract and generalize these into rules
  x <- trimws(raw[-grep("^([A-Z '`][A-Z'`][A-Z .`']+)", raw, invert = TRUE)])

  loc.idx <- grep("^LOCATION", x)[1]
  ser.idx <- grep("SERIES$", x)[1]
  rem.idx <- grep("SERIES ESTABLISHED[:]|SERIES PROPOSED[:]|ESTABLISHED SERIES[:]|PROPOSED SERIES[:]|REMARKS[:]", x)
  rem.idx <- rem.idx[length(rem.idx)]
  # grep("REMARKS|NOTE|ADDITIONAL DATA", x)[1]

  # unable to locate location and series
  if (is.na(loc.idx) | is.na(ser.idx) | length(x) == 0)
    return(FALSE)

  if (length(rem.idx) == 0) {
    # these have some sort of malformed series status
    message(sprintf("Check Section Headings: %s", filepath))
    rem.idx <- length(x)
  }

  # TODO: abstract and generalize these into rules
  markers <- trimws(gsub("^([A-Z`']{2}[A-Z ().`']+): ?(.*)", "\\1", x[(ser.idx + 1):rem.idx]))
  marker_self1 <- trimws(unlist(strsplit(gsub("LOCATION +([A-Z .`']+) {2,}\\d?([A-Z\\+]+)", "\\1;\\2", x[loc.idx]), ";")))
  marker_self2 <- trimws(gsub("([A-Z .`']) SERIES", "\\1", x[ser.idx]))

  if (marker_self1[1] != marker_self2) {
    # print(marker_self1[1])
    # print(marker_self2)
    message(sprintf("Check Line 1 LOCATION: %s", filepath))

    # TODO: abstract and generalize these into rules
    # three series in california have established dates before the state
    marker_self1[1] <- trimws(gsub("[0-9]|/","",marker_self1[1]))
    marker_self1 <- trimws(unlist(strsplit(gsub("LOCATION +([A-Z .`']+) {2,}\\d?([A-Z\\+]+)", "\\1;\\2", marker_self1[1]), ";")))

    # inconsistent location and series
    if (marker_self1[1] != marker_self2)
      return(FALSE)
  }

  # TODO: abstract and generalize these into rules
  # for now, just check that at least one valid state code is used (dput(datasets::state.abb)); check these against metadata
  all_states <- c("AS","PB","PR","VI","HT","PW","FM", c("AL", "AK", "AZ", "AR", "CA", "CO", "CT", "DE", "FL", "GA",
                                                        "HI", "ID", "IL", "IN", "IA", "KS", "KY", "LA", "ME", "MD", "MA",
                                                        "MI", "MN", "MS", "MO", "MT", "NE", "NV", "NH", "NJ", "NM", "NY",
                                                        "NC", "ND", "OH", "OK", "OR", "PA", "RI", "SC", "SD", "TN", "TX",
                                                        "UT", "VT", "VA", "WA", "WV", "WI", "WY"))
  n_states <- sum(unlist(lapply(all_states, function(x) sum(grepl(x, marker_self1[2])))))

  if (n_states < 1)
    message(sprintf("Unknown state marker: %s", marker_self1[2]))

  markheaders <- trimws(gsub(marker_self2, "", markers))

  # TODO: abstract and generalize these into rules
  # all section headers begin with capitals, and contain capitals up to the colon
  bad.idx <- grep("[a-z]", markheaders)

  # TODO: abstract and generalize these into rules

  # these are things that should be collapsed within RIC, REMARKS, etc
  bad.idx <- c(bad.idx, grep("SAR|SLOPE|NAD83", markheaders))

  if (length(bad.idx) > 0) {
    nu <- markheaders[-bad.idx]
    tst <- unique(nu)
    # if (length(tst) != length(nu)) {
    #   print(sprintf("Duplicate sections: %s [%s]", filepath, paste0(names(table(nu))[table(nu) > 1], collapse = ",")))
    # }
    markheaders <- tst
  }

  # dput(markheaders[markheaders != ""])

  # TODO: abstract and generalize these into rules

  headerpatterns <- c("TAXONOMIC CLASS",
                      "TYPI(CAL|FYING) PEDON",
                      "TYPE LOCATION",
                      "RANGE (IN|OF) CHARACTERISTICS|RANGE OF INDIVIDUAL HORIZONS",
                      "COMPETING SERIES",
                      "GEOGRAPHICA?L? SETTINGS?|SETTING",
                      "ASSOCIATED SOILS",
                      "DRAINAGE AND (PERMEABILITY|SATURATED HYDRAULIC CONDUCTIVITY)|PERMEABILITY|DRAINAGE CLASS|DRAINAGE",
                      "USE AND VEGETATION|VEGETATION|USE",
                      "DISTRIBUTION AND EXTENT|DISTRIBUTION|EXTENT",
                      "SOIL SURVEY REGIONAL OFFICE",
                      "(SERIES )?(ESTABLISHED|PROPOSED)",
                      "REMARKS|NOTE|ADDITIONAL DATA")
  # everything after established/proposed is "remarks", dont care about order

  names(headerpatterns) <- c("TAXONOMIC CLASS",
                             "TYPICAL PEDON",
                             "TYPE LOCATION",
                             "RANGE IN CHARACTERISTICS",
                             "COMPETING SERIES",
                             "GEOGRAPHIC SETTING",
                             "GEOGRAPHICALLY ASSOCIATED SOILS",
                             "DRAINAGE AND PERMEABILITY",
                             "USE AND VEGETATION",
                             "DISTRIBUTION AND EXTENT",
                             "REGIONAL OFFICE",
                             "ORIGIN",
                             "REMARKS")

  headerorders <- sapply(1:length(headerpatterns), function(i) {
    j <- grep(headerpatterns[i], markheaders)
    if (length(j) == 0)
      return(NA)
    return(j)
  })

  rez <- do.call('list', lapply(1:length(headerorders), function(i) {

    parts <- headerorders[[i]]

    if (!all(grepl(headerpatterns[i], markheaders[parts]))) {
      return(list(section = names(headerpatterns)[i],
                  content = NA))
    }

    if (length(parts) > 0) {
      lpart <- lapply(parts, function(p) {
        idx_start <- grep(pattern = markheaders[p], x = raw, fixed = TRUE)[1]
        idx_next <- pmatch(markheaders[p + 1], raw)
        idx_stop <- ifelse(test = (i == length(headerpatterns)),
                           yes = length(raw),
                           no =  ifelse(is.na(idx_next), length(raw), idx_next - 1))

        if (length(idx_start) == 0 | length(idx_stop) == 0) {
          return(list(section = markheaders[i],
                      content = NA))
        }

        if (is.na(idx_start) | is.na(idx_stop)) {
          return(list(section = markheaders[i],
                      content = NA))
        }

        return(list(section = markheaders[p],
                    content = paste0(raw[unique(idx_start:idx_stop)], collapse = "\n")))
      })
      lpartc <- Map('c', lpart)
      if (length(lpartc) > 0)
        return(as.list(apply(do.call(rbind, lpartc), 2, paste, collapse = " & ")))
    }
  }))

  present_idx <- apply(sapply(headerpatterns, function(y) {
    grepl(y, sapply(rez, function(x) x$section))
  }), 2, which)

  names(rez) <- names(headerpatterns)
  rez2 <- c(list(SERIES = marker_self2,
                 STATUS = raw[loc.idx + 1],
                 BYREV = raw[loc.idx + 2],
                 REVDATE = raw[loc.idx + 3]),
            rez)

  rez2[is.na(names(rez2))] <- NULL

  return(rez2)
}

#' Convert OSD plaintext to JSON using NSSH structural elements
#'
#' @param input_dir Default: \code{'OSD'}; files matching pattern are listed recursviely
#' @param pattern Argument passed to \code{list.files} when \code{osd_files} is not specified
#' @param output_dir Default: \code{'inst/extdata'}; folder to create alphabetical folder structure with JSON files
#' @param osd_files Default \code{NULL}; Optional over-ride vector of file names for testing
#'
#' @return A logical vector equal in length to the number of input files.
#' @export
#' @importFrom jsonlite toJSON
osd_to_json <- function(input_dir = 'OSD',
                        pattern = "txt",
                        output_dir = "inst/extdata",
                        osd_files = NULL) {

  if (!is.null(osd_files)) {
    all_osds <- osd_files
  } else {
    all_osds <- list.files(input_dir, pattern = pattern,
                           full.names = TRUE, recursive = TRUE)
  }

  res <- sapply(1:length(all_osds), function(i) {
    filepath <- all_osds[[i]]
    x <- validateOSD(filepath)

    if (is.logical(x))
      if (!x) return(FALSE)

    fld <- file.path(output_dir, substr(x$SERIES, 1, 1))

    if (!dir.exists(fld))
      dir.create(fld, recursive = TRUE)

    fn <- gsub("\\.txt", "\\.json", basename(all_osds[[i]]))

    write(jsonlite::toJSON(x, pretty = TRUE, auto_unbox = TRUE),
          file = file.path(fld, fn))
    return(TRUE)
  })
  names(res) <- all_osds
  return(res)
}
