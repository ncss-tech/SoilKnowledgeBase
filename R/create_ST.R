#' @export
#' @params ... passed to `download_ST()``
create_ST <- function(...) {
  args <- list(...)
  message("Creating Soil Taxonomy (2nd edition) datasets...")

  download_pdf <- TRUE
  if (!is.null(args[["download_pdf"]])) {
    download_pdf <- args[["download_pdf"]]
  }

  keep_pdf <- FALSE
  if (!is.null(args[["keep_pdf"]])) {
    keep_pdf <- args[["keep_pdf"]]
  }

  attempt <- try({

    # markers for first page of each chapter
    chapter.markers <- list(
      ch1 = "like many common words, has several",
      ch2 = "primary objective of soil taxonomy",
      ch3 = "distinguish mineral soil material from organic soil material",
      ch4 = "chapter defines the horizons and characteristics",
      ch5 = "fundamental purposes of a soil survey are to show",
      ch6 = "category of soil taxonomy is a set of classes that is",
      ch7 = "nomenclature of soil taxonomy is based on the",
      ch8 = "taxonomic class of a specific soil can be determined",
      ch9 = "central concept of Alfisols is that of soils",
      ch10 = "central concept of an Andisol is that of a soil",
      ch11 = "concept of Aridisols is based on limited soil moisture",
      ch12 = "central concept of Entisols is that of soils t",
      ch13 = "central concept of Gelisols is that of soils",
      ch14 = "central concept of Histosols is that of soils",
      ch15 = "central concept of Inceptisols is that of soils",
      ch16 = "Mollisols are extensive in subhumid to semiarid areas",
      ch17 = "Oxisols consist mainly of quartz, kaolinite, oxides",
      ch18 = "feature that is common to most Spodosols",
      ch19 = "Ultisols are most extensive in warm, humid climates",
      ch20 = "central concept of Vertisols is that of clayey soils",
      ch21 = "purposes that are largely pragmatic, the series name",
      ch22 = "chapter describes the geographic extent and pattern",
      ch23 = "only comprehensive and international effort",
      ch24 = "operational definitions of this edition of Soil Taxonomy"
    )

    # lookup table for chapter number:order name relationship
    chapter.taxon.lut <- list( `9` = "Alfisols",
                              `10` = "Andisols",
                              `11` = "Aridisols",
                              `12` = "Entisols",
                              `13` = "Gelisols",
                              `14` = "Histosols",
                              `15` = "Inceptisols",
                              `16` = "Mollisols",
                              `17` = "Oxisols",
                              `18` = "Spodosols",
                              `19` = "Ultisols",
                              `20` = "Vertisols")

    pdftxtfile <- file.path(outpath, "ST/1999_ST.txt")
    # TODO: check version?

    # download PDF, convert to TXT and put in inst/extdata
    if (!download_ST(download_pdf = download_pdf,
                     keep_pdf = keep_pdf)) {
      message('No PDF input available!')
      if (!file.exists(pdftxtfile)) {
        message('No pdftotext output available!')
        # graceful failure
        return(TRUE)
      }
    }

    # # use pdftotext to extract text+metadata from Keys PDF
    suppressWarnings({
      if (file.exists(pdftxtfile)) {
        pdf <- data.frame(content = readLines(pdftxtfile),
                          stringsAsFactors = FALSE)
      }
    })

    # simple count of page break indices and lines
    pages.idx <- which(grepl("\\f", pdf$content))

    # number of page breaks
    message("pages: ", length(pages.idx))

    # number of lines
    message("lines: ", length(pdf$content))

    # determine line index each chapter starts on
    chidx <- rep(NA, length(chapter.markers))
    for (p in 1:length(chapter.markers)) {
      chp1 <-  as.numeric(first_match_to_page(chapter.markers[p], pdf$content))
      chidx[p] <- page_to_index(pdf$content, chp1)
    }

    # create some indexes that will create groups that span full content
    ch.groups <- c(0, chidx, length(pdf$content))

    pgidx <- c(0, get_page_breaks(pdf$content))
    pgnames <- as.numeric(gsub("[^0-9]*([0-9]+)[^0-9]*|^([^0-9]*)$", "\\1", pdf$content[pgidx]))

    # correct index offset of linebreaks
    pgnames <- pgnames - 1

    # create a table of text "content," chapter and page number
    st <- data.frame(
      content = pdf$content,
      chapter = category_from_index(ch.groups, length(pdf$content), 0:24),
      page = category_from_index(pgidx, length(pdf$content), pgnames),
      stringsAsFactors = FALSE
    )

    # remove page linefeed markup
    st <- st[-pgidx, ]

    # remove three-letter abbreviated headers and CHAPTER X
    st <- st[-grep("^CHAPTER|^[A-Z]$|^CAP\u00cdTULO", st$content), ]


    # fix dangling AND/ORs
    orfix <- grep("^or$|^o$", st$content)
    andfix <- grep("^and$|^y$", st$content)
    st$content[orfix - 1] <- paste0(st$content[orfix - 1], " or")
    st$content[andfix - 1] <- paste0(st$content[andfix - 1], " and")

    # general fixes
    lit.idx <- grep("Literature Cited|Literatura Citada", st$content)
    lit.pages <- st$page[lit.idx]
    bad.lit.idx <- do.call('c', lapply(1:length(lit.idx), function(i) which(1:nrow(st) >= lit.idx[i] & st$page == lit.pages[i])))
    # remove the baddies
    st <- st[-c(orfix, andfix, bad.lit.idx),]

    # split by chapter
    ch <- split(st, f = st$chapter)

    # save ch 1:4 + end chapters for definitions and criteria
    st_def <- do.call('rbind', ch[c(1:8, 21:24)])

    keys <- lapply(ch[9:21], function(h) {
      # show what chapter we are processing
      # message("chapter: ", unique(h$chapter))

      # identify indices of each key in the chapter (order)
      m <- grepl("^(Key to [A-z A-z]*)$|^(Claves* para .*)$", h$content)

      if (!any(m)) {
        h$key <- "None"
        return(h)
      }

      key.idx <- which(m)
      key.to.what <- gsub("^(Key to [A-Z a-z]*)$|^(Claves* para .*)$",
                          "\\1\\2",
                          h$content[key.idx])
      if (length(key.idx) == 1) {
        # this is the Key to Soil Orders
        h$key <- key.to.what
        h$taxa <- "*"
      } else if (length(key.idx) > 0) {
        # all other Keys
        key.taxa.idx <- key.idx
        key.taxa.idx[key.taxa.idx > 1] <- key.taxa.idx[key.taxa.idx > 1] - 1

        key.taxa <- h$content[key.taxa.idx]

        if (length(key.to.what) > 0) {
          taxsub.l <- key.to.what == "Key to Suborders" |
            key.to.what == "Clave para Sub\u00f3rdenes"
          key.taxa[taxsub.l] <-  as.character(chapter.taxon.lut[as.character(unique(h$chapter))])
        }

        key.groups <- c(0, key.idx,  length(h$content))

        # all Gelands are Vitrigelands
        key.taxa[grep("Vitrigelands\\,", key.taxa)] <- "Vitrigelands"

        key.group.names <- c("None", key.to.what, 'None')
        key.taxa.names <- c("None", key.taxa, 'None')

        h$key <-  category_from_index(key.groups, length(h$content), key.group.names)
        h$taxa <-  category_from_index(key.groups, length(h$content), key.taxa.names)
      }

      # remove Key to ... and higher level taxon name
      bad.idx <- c(key.idx, key.idx - 1)
      skip.idx <- grep("Vitrigelands\\,", h$content)

      if (length(skip.idx)) {
        has.idx <- which(bad.idx == skip.idx)
        if(length(has.idx))
          bad.idx <- bad.idx[-has.idx]
      }
      return(h[-bad.idx, ])
    })
  })
}


download_ST <- function(outpath = "./inst/extdata",
                        download_pdf = "ifneeded",
                        keep_pdf = FALSE) {

    # create output path
    if (!dir.exists(file.path(outpath, "ST"))) {
      dir.create(file.path(outpath, "ST"), "ST", recursive = TRUE)
    }

    # hard coding 12th edition web sources for PDF files
    yhref <- "https://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/nrcs142p2_051232.pdf"

    fn <- "1999_ST.pdf"
    dlkst <- FALSE

    if (as.character(download_pdf) == "ifneeded") {
      download_pdf <- !file.exists(fn)
    }

    if (as.logical(download_pdf)) {
      download.file(yhref, destfile = fn)
    }

    if (file.exists(fn)) {
      system(sprintf("pdftotext -raw -nodiag %s", fn))
    } else {
      return(file.exists(fn))
    }

    if (keep_pdf) {
      file.copy(fn, file.path(outpath,"ST",fn))
    }
    file.remove(fn)

    outfile <- gsub("\\.pdf",".txt", fn)

    file.copy(outfile, file.path(outpath, "ST", outfile), overwrite = TRUE)

    return(file.remove(outfile))

}