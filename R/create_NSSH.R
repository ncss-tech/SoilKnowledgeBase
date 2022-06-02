# Create NSSH data structures in inst/extdata

#' Create NSSH Dataset
#'
#' @param ... Arguments to \code{parse_nssh_index}
#' @return TRUE if successful
#' @export
create_NSSH <- function(...) {
 outpath = "./inst/extdata"
 logfile = file.path(outpath, "NSSH/NSSH.log")

 logmsg(logfile, "Processing NSSH from eDirectives...")

  # run inst/scripts/NSSH

   dat <- parse_nssh_index(logfile = logfile, ...)
   attempt <- try(for (p in unique(dat$part)) {

   hed <- parse_nssh_part(dat$part, dat$subpart, outpath = outpath, logfile = logfile)

   if (!is.null(hed)) {
      # create the JSON clause products for each NSSH part/subpart .txt
      dspt <- split(dat, 1:nrow(dat))
      lapply(dspt, function(dd)
        parse_NSSH(
          logfile = logfile,
          outpath = outpath,
          a_part = dd$part,
          a_subpart = dd$subpart
        ))
      # Optional: special scripts (by NSSH Part #) can be called from inst/scripts/NSSH
      rpath <- list.files(paste0("inst/scripts/NSSH/", p), ".*.R", full.names = TRUE)
      # # find each .R file (one or more for each part) and source them
      lapply(rpath, function(filepath) {
        if (file.exists(filepath))
          source(filepath)
      })
    }
  })

  # call processing methods built into package
  try(process_NSSH_629A(outpath = outpath) )

  if (inherits(attempt, 'try-error'))
    return(FALSE)

  logmsg(logfile, "Done!")
  return(TRUE)
}

#' Parse the National Soil Survey Handbook (NSSH) Table of Contents to get eDirectives links
#'
#' @description \code{parse_nssh_index} provides a basic framework and folder structure for assets that are part of the National Soil Survey Handbook (NSSH) a key part of National Cooperative Soil Survey (NCSS) standards.
#'
#' @param logfile Path to log file; default \code{file.path(outpath, "NSSH/NSSH.log")}
#' @param nssh_url A URL to parse for Table of Contents information.
#' @param ignore.headers A character vector of h3 level headers to ignore on the NSSH Table of contents webpage.
#' @param outpath A directory path to create "inst/extdata/NSSH" folder structure.
#' @param download_pdf Download official PDF files from eDirectives? default: "ifneeded"; options: TRUE/FALSE
#' @param output_types Options include \code{c("txt","html")} for processed PDF files.
#' @param keep_pdf Keep PDF files after processing TXT?
#' @param ... Additional arguments (may not be used)
#'
#' @details Hardcoded with \code{ignore.headers = "Part 615 – Amendments To Soil Taxonomy"}; TODO: set this to NULL when webpage is updated. Default URL: https://www.nrcs.usda.gov/wps/portal/nrcs/detail/soils/ref/?cid=nrcs142p2_054240
#'
#' @return A data.frame object containing link, part and section information for the NSSH. A directory "inst/extdata/NSSH" is created in \code{outpath} (Default: "./inst/extdata/NSSH/") with a numeric subfolder for each part in the NSSH.
#' @importFrom data.table data.table
#' @importFrom rvest html_node html_nodes html_text
#' @importFrom xml2 read_html xml_attr
#' @importFrom utils write.csv download.file
#' @importFrom stats aggregate complete.cases
#' @importFrom utils head
#' @importFrom pdftools pdf_text
parse_nssh_index <- function(
  logfile = file.path(outpath, "NSSH/NSSH.log"),
  nssh_url = NULL,
  ignore.headers = NULL,
  outpath = "./inst/extdata",
  download_pdf = "ifneeded",
  output_types = c("txt","html"),
  keep_pdf = FALSE,
  ...
) {
  .SD <- NULL
  if (is.null(nssh_url))
    nssh_url <- "https://www.nrcs.usda.gov/wps/portal/nrcs/detailfull/soils/ref/?cid=nrcs142p2_054242"

  ## NSSH Table of Contents

  html <- xml2::read_html(nssh_url)

  edi <-  data.frame(
    url = rvest::html_attr(rvest::html_nodes(html, 'a'), 'href'),
    txt = rvest::html_text(rvest::html_nodes(html, 'a'))
  )
  edi <- edi[grepl("directives", edi$url) & !grepl("Amendments", edi$txt), ]

  edi$url <- gsub(
      "http:",
      "https:",
      gsub("viewerFS.aspx?", "viewDirective.aspx?", edi$url, fixed = TRUE),
      fixed = TRUE)

  html2 <- lapply(edi$url, xml2::read_html)

  res0 <- do.call('rbind', lapply(seq_along(edi$url), function(i) {
    p <- rvest::html_nodes(html2[[i]], 'p')

    data.frame(
      url = rvest::html_attr(rvest::html_nodes(p, 'a'), 'href'),
      txt = rvest::html_text(rvest::html_nodes(p, 'a'))
    )
  }))

  res1 <- res0[complete.cases(res0),]
  pdf_path <- file.path(outpath, "NSSH", "pdf")
  if (!dir.exists(pdf_path)) {
    dir.create(pdf_path, recursive = TRUE)
  }
  pdfs <- list.files(pdf_path, pattern = "pdf", recursive = TRUE, full.names = TRUE)
  if ((length(pdfs) == 0 && (download_pdf == "ifneeded")) ||
      (is.logical(download_pdf) && download_pdf)) {
    pdfs <- lapply(res1$url, function(x) {
      dfile <- file.path(pdf_path, paste0(basename(x), ".pdf"))
      f <- download.file(
        paste0("https://directives.sc.egov.usda.gov/OpenNonWebContent.aspx?content=", x),
        dfile,
        mode = "wb"
      )
      if (f == 0)
        return(dfile)
      NA_character_
    })
    # heuristic to find bad PDF files (<100kB); TODO: get these fixed
    .badpdf <- function() (file.size(list.files(pdf_path, full.names = TRUE)) / 1024) < 100
    bpf <- which(.badpdf())
    if (length(bpf) > 0) {
      logmsg(logfile, "Found %s PDFs with bad format", length(bpf))
    }

    txts <- lapply(lapply(lapply(pdfs, function(x) try(pdftools::pdf_text(x), silent = TRUE)), paste0, collapse = "\n"), function(x) strsplit(x, "\n")[[1]])

    # TODO: bad pdf format
    # cmb <-  try(pdftools::pdf_combine(paste0("https://directives.sc.egov.usda.gov/", res$url),
    #                                   output = "test.pdf"))
    # unlink(as.character(pdfs))
  }

  if (length(txts) == 0) {
    stop("Missing input PDFs")
  }

  toc <- gsub("\\u2013", "-", txts[[1]])
  section <- toc[grep("^Parts", toc)]

  .section_to_parts <- function(x) {
    y <- do.call('rbind', lapply(x, function(z) {
      lh <- as.data.frame(do.call('rbind',
                                  strsplit(gsub("Parts (\\d+) to (\\d+) \u2013 (.*)",
                                                "\\1;\\2;\\3", z), ";"))
                          )
    }))
    do.call('rbind', lapply(seq_len(nrow(y)), function(i) {
      data.frame(Part = y$V1[i]:y$V2[i], Section = y$V3[i])
    }))
  }
  stp <- .section_to_parts(section)

  header <- lapply(txts, function(x) {
    y <- trimws(x)
    head(y[y != ""], 3)
  })

  longnames <- sapply(header, function(x) {
    if (length(x) > 1) {
      y <- x[2:length(x)]
      paste(y[grepl("Part|Subpart", y)], collapse = ", ")
    } else return(NA)
  })

  dln <- data.frame(longname = longnames,
                    url = paste0("https://directives.sc.egov.usda.gov/", res1$url),
                    part = trimws(res1$txt))
  dln$Part <- as.numeric(gsub("Part (\\d+) .*|(.*)", "\\1", dln$longname))
  dln$Subpart <- gsub(".*, Subpart ([AB]).*|(.*)", "\\1", dln$longname)
  dln$Content <- I(txts)

  res2 <- merge(data.table::data.table(stp), data.table::data.table(dln), by = "Part", sort = FALSE, all.x = TRUE)
  res3 <- res2[complete.cases(res2[, .SD, .SDcols = colnames(res2) != "Content"]), ]

  res4 <- data.frame(
    href = res3$url,
    parent = trimws(gsub("Part \\d+ \u2013 ([^\u2013]*) ?.*", "\\1", res3$longname)),
    section = res3$Section,
    part = res3$Part,
    subpart = res3$Subpart
  )

  lapply(unique(res3$Part), function(x) {
    dp <- file.path(outpath, "NSSH", x)
    if (!dir.exists(dp))
      dir.create(dp, recursive = TRUE)
    parts <- subset(res3, res3$Part == x)
    lapply(split(parts, 1:nrow(parts)), function(y) {
      xx <- strip_lines(clean_chars(y$Content[[1]]))
      writeLines(stringi::stri_escape_unicode(xx), file.path(outpath, "NSSH", x, sprintf("%s%s.txt", y$Part, y$Subpart)))
    })
  })

  indexout <- file.path(outpath, "NSSH", "index.csv")

  write.csv(res4, file = indexout)

  logmsg(logfile, "Wrote NSSH index to %s", indexout)
  return(res4)
}

#' Parse headers and line positions by NSSH Part and Subpart
#'
#' @param number Vector of part number(s) e.g. \code{600:614}
#' @param subpart Vector of subpart characters e.g. \code{"A"}
#' @param outpath A directory path to create "NSSH" folder structure in; default: \code{"S./inst/extdata"}
#' @param logfile PAth to log file; default \code{file.path(outpath, "NSSH/NSSH.log")}
#'
#' @return A data.frame containing line numbers corresponding to NSSH part and subpart headers.
parse_nssh_part <- function(number, subpart,
                            outpath = "./inst/extdata",
                            logfile = file.path(outpath, "NSSH/NSSH.log")) {

  res <- do.call('rbind', lapply(split(data.frame(number = number,
                                                  subpart = subpart),
                                1:length(number)), function(x) {

                                  idx <- respart <- ressubpart <- numeric(0)

                                  try( {
                                    f <- sprintf(file.path(outpath,
                                                           "NSSH/%s/%s%s.txt"),
                                                 x$number, x$number, x$subpart)

                                    if (!file.exists(f))
                                      return(NULL)

                                    L <- readLines(f)

                                    idx <- grep("^\\d{3}\\.\\d+ [A-Z]", L)
                                    # collapses long headers
                                    idx2 <- idx[grepl("^A\\. .*$|^[A-Z\\)][a-z\\)]+ ?", L[idx + 1])] + 1
                                    lidx2 <- length(idx2)
                                    lsub <- sapply(lapply(1:length(idx), function(i) {
                                      res <- idx[i]
                                      if (lidx2 > 0 && i <= lidx2 &&
                                          (nchar(L[idx2[[i]]]) < 50 &&
                                           !grepl("[\\.\\-\\:\\;]|Accessibility statement|^The database", L[idx2[[i]]]))) {
                                        resend <- idx2[i]
                                        if (!is.na(resend) && abs(resend - res) <= 1) {
                                          res <- res:resend
                                        }
                                      }
                                      res
                                    }), function(j) {
                                      paste0(L[j], collapse = " ")
                                    })

                                    respart <- rep(x$number, length(idx))
                                    ressubpart <- rep(x$subpart, length(idx))

                                    res <- data.frame(part = x$number,
                                                      subpart = x$subpart,
                                                      line = idx,
                                                      header = lsub)
                                    return(res)
                                  } )
                                }))
  nsshheaders <- file.path(outpath, "NSSH", "headers.csv")
  logmsg(logfile, "Wrote NSSH index to %s", nsshheaders)
  write.csv(res, file = nsshheaders)
  return(res)
}

#' Parse a Part/Subpart TXT file from the National Soil Survey Handbook
#'
#' @param logfile Path to log file; default: \code{file.path(outpath, "NSSH/NSSH.log")}
#' @param outpath Path to read in NSSH raw txt from; default \code{"inst/extdata"}
#' @param a_part Part number (a three digit integer, starting with 6)
#' @param a_subpart Subpart letter (A or B)
#'
#' @return TRUE if successful
parse_NSSH <- function(logfile = file.path(outpath, "NSSH/NSSH.log"),
                       outpath = "./inst/extdata",
                       a_part, a_subpart) {

  logmsg(logfile, "Parsing NSSH Part %s Subpart %s", a_part, a_subpart)

  raw_txt <- sprintf(file.path(outpath, "NSSH/%s/%s%s.txt"), a_part, a_part, a_subpart)
  stopifnot(file.exists(raw_txt))
  raw <- suppressWarnings(readLines(raw_txt, encoding = "UTF-8"))

  headers <- get_assets('NSSH','headers')[[1]]
  headers <- subset(headers, headers$part == a_part &
                             headers$subpart == a_subpart)
  headers <- rbind(data.frame(X = "", part = a_part, subpart = a_subpart,
                              line = 1, header = "Front Matter"), headers)
  sect.idx <- c(1, headers$line[2:nrow(headers)] - 1, length(raw))
  llag  <- sect.idx[1:(length(sect.idx) - 1)]
  llead <- sect.idx[2:(length(sect.idx))]

  hsections <- lapply(1:nrow(headers), function(i) {
    if (headers$header[i] != raw[llag[i]]) {
      k <- 1
      header_exceptions <- c("600.0 The Mission of the Soil Science Division, Natural Resources Conservation Service",
                             "607.11 Example of a Procedure for Geodatabase Development, File Naming, Archiving, and Quality Assurance")
      if (headers$header[i] %in% header_exceptions)
        k <- 2 # long headers need (at least) an extra line; see heuristics for header parsing in parse_nssh_part()
      llag[i] <- llag[i] + k
    }
    res <- fix_line_breaks(strip_lines(clean_chars(raw[llag[i]:llead[i]])))
    if (i == 1) {
      res$headerid <- 1
    }
    res$header <- headers$header[i]
    res
  })

  names(hsections) <- c(gsub("^(\\d+\\.\\d+) .*", "\\1", headers$header))

  res <- convert_to_json(hsections)
  write(res, file = sprintf(file.path(outpath, "NSSH/%s/%s%s.json"),
                                      a_part, a_part, a_subpart))
  return(TRUE)
}

# collapse multiline content into "clauses"
fix_line_breaks <- function(x) {
  # starts with A. (1) or 618. is a new line

  # parse header components
  ids <- strsplit(gsub("^(\\d+)\\.(\\d+) (.*)$", "\\1:\\2:\\3", x[1]), ":")

  # remove header from content
  x2 <- x[-1]
  if (length(x2) > 0) {
    res <- aggregate(x2,
                     by = list(cumsum(grepl("^[A-Z]\\.|^6[0-9]{2}\\. |^\\(\\d+\\)", x2))), # |^\\(\\d+\\) -- not sure if this is desired
                     FUN = paste, collapse = " ")
  } else {
    res <- aggregate(x,
                     by = list(cumsum(grepl("^[A-Z]\\.|^6[0-9]{2}\\. |^\\(\\d+\\)", x))), # |^\\(\\d+\\) -- not sure if this is desired
                     FUN = paste, collapse = " ")
  }

  # check for clauses that dont start with a capital letter, a number or a parenthesis
  fclause.idx <- !grepl("^[A-Zivx0-9\\(]", res$x)

  if (length(fclause.idx) > 0)
    res$Group.1[fclause.idx] <- res$Group.1[fclause.idx] - 1
  if (nrow(res) > 0) {
    res2 <- aggregate(res$x,
                      by = list(res$Group.1),
                      FUN = paste, collapse = " ")
  } else {
    return(data.frame(clause = "", content = ""))
  }

  colnames(res2) <- c("clause", "content")
  res2$part <- ids[[1]][1]
  res2$headerid <- ids[[1]][2]
  res2$header <- ids[[1]][3]
  res2$clause <- 1:nrow(res2)
  return(res2)
}

# remove material associated with page breaks and footnotes
strip_lines <- function(x) {
  idx <- grep("\\fTitle 430 .* National Soil Survey Handbook|\\(430-6\\d{2}-., 1st|Ed\\., Amend\\.|6\\d{2}-[AB].\\d+", x)
  idx.fn <- grep("-------------", x)
  if (length(idx.fn))
    x <- x[1:(idx.fn[1] - 1)]
  if (length(idx) > 0)
    return(x[-idx])
  x <- x[nchar(trimws(x)) > 0]
  return(x)
}

# fixing of unicode stuff, then convert to ascii
clean_chars <- function(x) {
  x <- gsub("\u2013|\u2014|\uf0b7|\u001a|\u2022", '-', x)
  x <- gsub("Title 430 - National Soil Survey Handbook", "", x)
  x <- gsub("\u2019", "'", x)
  x <- gsub("\u201c|\u201d", '"', x)
  x <- x[nchar(trimws(x)) > 0]
  return(trimws(x))
}


