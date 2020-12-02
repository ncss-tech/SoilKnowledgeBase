#' Parse the National Soil Survey Handbook (NSSH) Table of Contents to get eDirectives links
#'
#' @description \code{parse_nssh_index} provides a basic framework and folder structure for assets that are part of the National Soil Survey Handbook (NSSH) a key part of National Cooperative Soil Survey (NCSS) standards.
#'
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
#'
#' @importFrom dplyr bind_rows
#' @importFrom magrittr %>%
#' @importFrom rvest html_node html_nodes html_text
#' @importFrom xml2 read_html xml_attr
#' @importFrom utils write.csv download.file
#' @importFrom stats aggregate
parse_nssh_index <- function(
  nssh_url = NULL,
  ignore.headers = "Amendments To Soil Taxonomy",
  outpath = "./inst/extdata",
  download_pdf = "ifneeded",
  output_types = c("txt","html"),
  keep_pdf = FALSE,
  ...
) {

  if (is.null(nssh_url))
    nssh_url <- "https://www.nrcs.usda.gov/wps/portal/nrcs/detail/soils/ref/?cid=nrcs142p2_054240"

  ## NSSH Table of Contents

  html <- read_html(nssh_url)

  # header level 2 are the sections
  the_sections <- html %>%
                   html_nodes('h2') %>%
                   html_text()

  suppressWarnings({
    start_part <- as.numeric(gsub("Parts (\\d{3}) to (\\d{3}).*", "\\1", the_sections))
    end_part <- as.numeric(gsub("Parts (\\d{3}) to (\\d{3}).*", "\\2", the_sections))
  })

  # combine and remove first row
  the_sections <- data.frame(section = the_sections, start = start_part, end = end_part)[-1,]

  # header level 3 are "parts" e.g. part 618, 629
  the_parts <- html %>%
    html_nodes('h3') %>%
    html_text()

  # skip "Quick Links" section at top
  the_parts <- the_parts[2:length(the_parts)]

  # this is currently a header with no links
  if (!is.null(ignore.headers)) {
    for (h in ignore.headers) {
      a <- grep(h, the_parts)
      if (length(a))
        the_parts <- the_parts[-a]
    }
  }

  ulnodes <- html %>%
    html_nodes('ul')

  # find the links to eDirectives
  linknodes <- which(grepl('\\.wba', ulnodes %>% html_node('a') %>% xml_attr('href')))

  # this is the link to part 655; last link, as expected
  ulnodes[linknodes[length(linknodes)]]

  # inspect (should be part 600)
  ulnodes[linknodes[1]] %>%
    html_nodes('a') %>%
    bind_xml_nodeset()

  res <- lapply(seq_along(linknodes), function(i) {

   current_links <- ulnodes[linknodes[i]] %>%
      html_nodes('a') %>%
      bind_xml_nodeset()

   parent_index <- which(linknodes == linknodes[i])

   current_links$parent <- the_parts[parent_index]

   return(current_links)

  }) %>% bind_rows()

  res$part_number <- as.numeric(gsub("Part (\\d+).*", "\\1", res$parent))

  res$section <- as.character(lapply(split(res, 1:nrow(res)), function(x) {
     return(the_sections[x$part_number >= the_sections$start & x$part_number <= the_sections$end, 'section'])
    }))

  # cleanup
  res$target <- NULL
  res$part <- res$part_number
  res$part_number <- NULL
  res$subpart <- do.call('c', aggregate(res$part, by = list(res$part),
                                        FUN = function(x) LETTERS[1:2][1:length(x)])$x)

  res$parent <- gsub("Part \\d+ . (.*)", "\\1", res$parent)
  res$section <- gsub("Parts \\d+ to \\d+ . (.*)", "\\1", res$section)

  # create directory structure and download PDFs
  lapply(unique(res$part), function(x) {
      dp <-  file.path(outpath, "NSSH", x)
      if (!dir.exists(dp))
        dir.create(dp, recursive = TRUE)
      parts <- subset(res, res$part == x)
      lapply(split(parts, 1:nrow(parts)), function(y) {
         pat <- file.path(outpath, "NSSH", x, sprintf("%s%s.pdf", y$part, y$subpart))
         dfile <- download_pdf
         if (dfile == "ifneeded")
           dfile <- !file.exists(pat)
         if (dfile)
          download.file(y$href, destfile = pat)
         if (file.exists(pat)) {
          if ("txt" %in% output_types)
            system(sprintf("pdftotext -raw -nodiag %s", pat))
          if ("html" %in% output_types)
            system(sprintf("pdftohtml %s", pat))
         }
         if (!keep_pdf)
          system(sprintf("rm %s", pat))
        })
    })

  write.csv(res, file = file.path(outpath, "NSSH", "index.csv"))
  return(res)
}

#' Parse headers and line positions by NSSH Part and Subpart
#'
#' @param number Vector of part number(s) e.g. \code{600:614}
#' @param subpart Vector of subpart characters e.g. \code{"A"}
#' @param outpath A directory path to create "inst/extdata/NSSH" folder structure in
#'
#' @return A data.frame containing line numbers corresponding to NSSH part and subpart headers.
parse_nssh_part <- function(number, subpart,
                            outpath = "./inst/extdata") {

  res <- do.call('rbind', lapply(split(data.frame(number = number, subpart = subpart),
                                1:length(number)), function(x) {

                                  idx <- respart <- ressubpart <- numeric(0)

                                  try( {
                                    f <- sprintf("inst/extdata/NSSH/%s/%s%s.txt",
                                                 x$number, x$number, x$subpart)

                                    if(!file.exists(f))
                                      return(NULL)

                                    L <- readLines(f, warn = FALSE)

                                    idx <- grep("^\\d{3}\\.\\d+ [A-Z]", L)

                                    respart <- rep(x$number, length(idx))
                                    ressubpart <- rep(x$subpart, length(idx))


                                    res <- data.frame(part = x$number,
                                                      subpart = x$subpart,
                                                      line = idx,
                                                      header = L[idx])
                                    return(res)
                                  } )
                                }))
  write.csv(res, file = file.path(outpath, "NSSH", "headers.csv"))
  return(res)
}

#' Parse a Part/Subpart TXT file from the National Soil Survey Handbook
#'
#' @param a_part Part number (a three digit integer, starting with 6)
#' @param a_subpart Subpart letter (A or B)
#'
#' @return TRUE if succesful
#' @export
parse_NSSH <- function(a_part, a_subpart) {

  raw_txt <- sprintf("inst/extdata/NSSH/%s/%s%s.txt", a_part, a_part, a_subpart)
  stopifnot(file.exists(raw_txt))
  raw <- readLines(raw_txt)

  headers <- get_assets('NSSH','headers')[[1]]
  headers <- subset(headers, headers$part == a_part &
                             headers$subpart == a_subpart)

  sect.idx <- c(1, headers$line, length(raw))
  llag  <- sect.idx[1:(length(sect.idx - 1))]
  llead <- sect.idx[2:(length(sect.idx))]

  hsections <- lapply(1:(nrow(headers) + 1), function(i) {
    fix_line_breaks(strip_lines(clean_chars(raw[llag[i]:(llead[i] - 1)])))
  })

  names(hsections) <- c("frontmatter", gsub("^(\\d+\\.\\d+) .*", "\\1", headers$header))
  res <- convert_to_json(hsections)
  write(res, file = sprintf("inst/extdata/NSSH/%s/%s%s.json", a_part, a_part, a_subpart))
  return(TRUE)
}

# collapse multiline content into "clauses"
fix_line_breaks <- function(x) {
  # starts with A. (1) or 618. is a new line

  ids <- strsplit(gsub("^(\\d+)\\.(\\d+) (.*)$", "\\1:\\2:\\3", x[1]), ":")

  res <- aggregate(x,
                   by = list(cumsum(grepl("^[A-Z]\\.|^6[0-9]{2}\\. |^\\(\\d+\\)", x))), # |^\\(\\d+\\) -- not sure if this is desired
                   FUN = paste, collapse = " ")

  # check for clauses that dont start with a capital letter, a number or a parenthesis
  fclause.idx <- !grepl("^[A-Zivx0-9\\(]", res$x)

  if (length(fclause.idx) > 0)
    res$Group.1[fclause.idx] <- res$Group.1[fclause.idx] - 1

  res2 <- aggregate(res$x,
                    by = list(res$Group.1),
                    FUN = paste, collapse = " ")

  # idx.bad <- which(!grepl("\\.$", res2$x))
  # res3 <- aggregate(res2$x,
  #                   by = list(cumsum()),
  #                   FUN = paste, collapse = " ")

  colnames(res2) <- c("clause","content")
  res2$part <- ids[[1]][1]
  res2$headerid <- ids[[1]][2]
  res2$header <- ids[[1]][3]
  res2$clause <- 1:nrow(res2)
  return(res2)
}

# remove material associated with page breaks and footnotes
strip_lines <- function(x) {
  idx <- grep("\\fTitle 430 .* National Soil Survey Handbook|(430-6\\d{2}-., 1st|Ed., Amend. \\d+, [A-Za-z]+ \\d+)|6\\d{2}-[AB].\\d+|^Subpart [AB] ", x)
  idx.fn <- grep("-------------", x)
  if (length(idx.fn))
    x <- x[1:(idx.fn[1] - 1)]
  if (length(idx) > 0)
    return(x[-idx])
  return(x)
}

# TODO: placeholder; better fixing of unicode stuff
clean_chars <- function(x) {
  x <- gsub("\u00E2\u20AC\u201D",' ', x)
  return(x)
}

#' Create NSSH Dataset
#'
#' @param ... Arguments to \code{parse_nssh_index}
#' @return TRUE if successful
#' @export
create_NSSH <- function(...) {

  # run inst/scripts/NSSH
  dat <- parse_nssh_index(...)
  attempt <- try(for (p in unique(dat$part)) {

    hed <- parse_nssh_part(dat$part, dat$subpart)

    if (!is.null(hed)) {

      # create the JSON clause products for each NSSH part/subpart .txt
      dspt <- split(dat, 1:nrow(dat))
      lapply(dspt, function(dd) parse_NSSH(dd$part, dd$subpart))

      rpath <- list.files(paste0("inst/scripts/NSSH/", p), ".*.R", full.names = TRUE)

      # find each .R file (one or more for each part) and source them
      lapply(rpath, function(filepath) {
        if (file.exists(filepath))
          source(filepath)
      })
    }
  })

  if (inherits(attempt, 'try-error'))
    return(FALSE)

  return(TRUE)
}
