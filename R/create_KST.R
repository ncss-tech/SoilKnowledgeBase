#' Create Keys to Soil Taxonomy Datasets
#'
#' @param ... arguments passed to `download_KST`
#'
#' @return TRUE if successful
#' @export
#' @importFrom tibble as_tibble
#' @importFrom stringi stri_enc_toascii
create_KST <- function(...) {
  args <- list(...)
  message("Creating Keys to Soil Taxonomy (12th Edition) datasets...")
  download_pdf <- TRUE
  if (!is.null(args[["download_pdf"]])) {
    download_pdf <- args[["download_pdf"]]
  }

  keep_pdf <- FALSE
  if (!is.null(args[["keep_pdf"]])) {
    keep_pdf <- args[["keep_pdf"]]
  }

  attempt <- try({
    languages <- c("EN", "SP")

    for(language in languages) {
        # markers for first page of each chapter
        chapter.markers <- get_chapter_markers(language = language)

        # lookup table for chapter number:order name relationship
        chapter.taxon.lut <- get_chapter_orders(language = language)

        message("language: ", language)

        pdftxtfile <- file.path("./inst/extdata/KST",
                          sprintf("2014_KST_%s.txt", language))
                          # TODO: check version?

        # download PDF, convert to TXT and put in inst/extdata
        if (!download_KST(
             download_pdf = download_pdf,
             keep_pdf = keep_pdf,
             language = language
            )) {
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
            pdf <- data.frame(content = readLines(pdftxtfile), stringsAsFactors = FALSE)
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
          chp1 <- as.numeric(first_match_to_page(chapter.markers[p], pdf$content))
          chidx[p] <- page_to_index(pdf$content, chp1)
        }

        # create some indexes that will create groups that span full content
        ch.groups <- c(0, chidx, length(pdf$content))

        pgidx <- c(0, get_page_breaks(pdf$content))
        pgnames <- as.numeric(gsub("[^0-9]*([0-9]+)[^0-9]*|^([^0-9]*)$","\\1",
                                   pdf$content[pgidx]))

        # correct index offset of linebreaks
        pgnames <- pgnames - 1

        # create a table of text "content," chapter and page number
        st <- data.frame(
          content = pdf$content,
          chapter = category_from_index(ch.groups, length(pdf$content), 0:19),
          page = category_from_index(pgidx, length(pdf$content), pgnames),
          stringsAsFactors = FALSE
        )

        # perform various 12th-edition specific fixes

        # determine line index each chapter starts on
        chidx <- rep(NA, length(chapter.markers))
        for (p in 1:length(chapter.markers)) {
          chp1 <-
            as.numeric(first_match_to_page(chapter.markers[p], pdf$content))
          chidx[p] <- page_to_index(pdf$content, chp1)
        }

        # create some indexes that will create groups that span full content
        ch.groups <- c(0, chidx, length(pdf$content))

        pgidx <- c(0, get_page_breaks(pdf$content))
        pgnames <- as.numeric(gsub("[^0-9]*([0-9]+)[^0-9]*|^([^0-9]*)$","\\1",
                                   pdf$content[pgidx]))

        # correct index offset of linebreaks
        pgnames <- pgnames - 1

        # create a table of text "content," chapter and page number
        st <- data.frame(
          content = pdf$content,
          chapter = category_from_index(ch.groups, length(pdf$content), 0:19),
          page = category_from_index(pgidx, length(pdf$content), pgnames),
          stringsAsFactors = FALSE
        )

        # remove page linefeed markup
        st <- st[-pgidx, ]

        # remove three-letter abbreviated headers and CHAPTER X
        st <- st[-grep("^CHAPTER|^[A-Z]$|^CAP\u00cdTULO", st$content), ]

        # remove multi underscore footnote markup (spanish)
        if (language == "SP")
          st <- st[-grep("\\_\\_+", st$content),]

        # remove floating order names (chapter names)
        # chordernames <- do.call('c', lapply(chtaxa.lut, function(x)
        #   grep(sprintf("^%s[ 0-9]*", x), st$content)))
        # st <- st[-chordernames, ]

        # fix dangling AND/ORs
        orfix <- grep("^or$|^o$", st$content)
        andfix <- grep("^and$|^y$", st$content)
        st$content[orfix - 1] <- paste0(st$content[orfix - 1], " or")
        st$content[andfix - 1] <- paste0(st$content[andfix - 1], " and")

        # fix PSCS and HAHT headers
        # TODO: extend feature and family keys to language="SP"
        if(language == "EN") {
          idx <- sapply(
            c("^Diagnostic Soil Characteristics for Mineral",
              "^Characteristics Diagnostic for",
              "Anthropogenic Landforms and",
              "Subgroups for Human-Altered and Human\\-",
              "Family Differentiae for Mineral Soils and",
              "Control Section for Particle-Size Classes and Their",
              "Key to the Particle-Size and Substitute Classes of Mineral",
              "Use of Human-Altered and Human-Transported Material",
              "Key to Human-Altered and Human-Transported Material",
              "Key to the Control Section for Human-Altered and Human-",
              "Control Section for the Ferrihumic Mineralogy Class and",
              "Control Section for Mineralogy Classes Applied Only to",
              "Key to the Control Section for the Differentiation"
            ), grep,
            st$content)
          if (is.list(idx)) {
            idx <- do.call('c', idx)
          }
          if (length(idx) > 0) {
            idxp1 <- idx + 1
            st$content[idx] <- paste(st$content[idx], trimws(st$content[idxp1]))
            st$content[idxp1] <- ""
          }

          haht.idx <- grep("Human-Altered and Human-$", st$content)
          st$content[haht.idx] <- paste0(trimws(st$content[haht.idx:(haht.idx+2)]), collapse="")
          st$content[haht.idx+(1:2)] <- ""

          st$content <- gsub("Human\\- T", "Human-T", st$content)
        }

        # errata syntax and language fixes

        humustepts.idx <- grep("KDC. Other Ustepts that have an umbric or mollic epipedon", st$content)
        st$content[humustepts.idx] <- paste0(st$content[humustepts.idx],".")

        bad.codes.fix <- list(
          c("LEFD. Other Udorthents that have 50 cm or more of human","LEFD","LEFE"),
          c("LEFE. Other Udorthents that have, throughout one or more","LEFE","LEFF"),
          c("LEFF. Other Udorthents that have, in one or more horizons","LEFF","LEFG"),
          c("LEFG. Other Udorthents that are saturated with water in one","LEFG","LEFH"),
          c("LEFH. Other Udorthents that have 50","LEFH","LEFI"),
          c("LEFI. Other Udorthents\\.","LEFI","LEFJ"),
          c("JEDA. Ferrudalfs que tienen, en uno o m\u00e1s horizontes", "JEDA", "JEBA"), #
          c("JEDB. Otros Ferrudalfs", "JEDB", "JEBB"), #
          c("JEJC. Otros Haplustalfs que tienen tanto:", "JEJC", "JCHC"), # Oxyaquic Vertic Haplustalfs
          c("JDBA. Palexeralfs que tienen una o ambas de las", "JDBA","JDFA"), # Vertic Palexeralfs
          c("GCBH. Otros Haplodurids que tienen, a trav\u00e9s de uno o", "GCBH","GCCF"), # Vitrandic Haplodurids
          c("LEAB. Otros Gelifluvents.", "LEAB","LDAB"), # Typic Gelifluvents
          c("KGFI. Otros Dystrudepts que tienen todas las", "KGFI","KFFI"), # Fluvaquentic Dystrudepts
          c("KFFB. Otros Haploxerepts que tienen un contacto l\\u00edtico","KFFB", "KEFB"), # Lithic Haploxerepts
          c("CECB. Otros Fragiorthods que est\u00e1n saturados con", "CECB","CECC") # Oxyaquic Fragiorthods
        )

        # fix all the bad codes
        bad.codes.idx <- lapply(bad.codes.fix, function(x) {
          idx <- grep(x[1], st$content)[1]
          st$content[idx] <<- gsub(x[2], x[3], st$content[idx])
          if (length(idx))
            return(idx)
          return(numeric(0))
        })
        message("fixed bad taxon codes on lines: ", paste0(bad.codes.idx[!is.na(bad.codes.idx)], collapse = ","))

        # general fixes
        lit.idx <- grep("Literature Cited|Literatura Citada", st$content)
        bad.lit.idx <- lit.idx[3] + 0:(grep("Key to|Clave para",
                                            st$content[lit.idx[3] + 0:10]) - 2)
        # remove the baddies
        st <- st[-c(orfix, andfix, bad.lit.idx),]

        # insert errata
        idx <- grep("LEFE. ",st$content)[1]
        if (length(idx) & language == "EN") {
          st.top <- st[1:(idx - 1),]
          st.bot <- st[idx:nrow(st),]

          # insert anthropic udorthents
          #  errata (missing in english edition only)
          new.content <- c("LEFD. Other Udorthents that have an anthropic epipedon.",
                           "Anthropic Udorthents")
          st.new <- data.frame(content = new.content,
                               chapter = 8, page = ifelse(language == "SP", 164, 147))
          st <- rbind(st.top, st.new, st.bot)
        }

        # fix dangling order labels
        dangling.orders.pat <- c("Endoaqualfs, ","Fluvents, ","Vermaquepts, ","Endoaquerts,")
        dangling.orders.idx <- as.numeric(lapply(dangling.orders.pat, grep, st$content)) + 1
        if(language == "EN")
          st <- st[-dangling.orders.idx,]

        # split by chapter
        ch <- split(st, f = st$chapter)

        # save ch 1:4 + end chapters for definitions and criteria
        st_def <- do.call('rbind', ch[c(1:4,18)])

        bad.idx <- c(
          grep("^Horizons and Characteristics Diagnostic for the Higher Categories$", st_def$content)
        )
        if (length(bad.idx))
          st_def <- st_def[-bad.idx,]

        # indexes 5 to 17 are the Keys to Order, Suborder, Great Group, Subgroup...
        #  indexes offset by 1 from their "true" chapter number in table
        keys <- lapply(ch[5:17], function(h) {
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

        ## identify indices of each taxon
        crits <- lapply(keys, function(kk) {
          crit.idx <- get_taxon_breaks(kk$content, kk$key)
          crit.to.what <- names(crit.idx)

          if (length(crit.idx) > 0 & length(crit.to.what) > 0) {
            crit.groups <- c(0, crit.idx - 1, length(kk$content))
            crit.group.names <- c("*", crit.to.what , "*")
            kk$crit <-  category_from_index(crit.groups, length(kk$content), crit.group.names)
          } else {
            kk$crit <- "None"
          }
          return(kk)
        })

        st_criteria <- do.call('rbind', crits)

        # final cleanup
        subgroup.key.l <- grepl("[Oo]rder|[Gg]roup|[\u00d3\u00f3]rden|[Gg]rupo", st_criteria$key)

        st_criteria_subgroup <- st_criteria[subgroup.key.l,]
        st_criteria_other <- st_criteria[!subgroup.key.l,]

        ## make whole ST database -- unique taxa
        crit_levels <-  decompose_taxon_ID(unique(st_criteria_subgroup$crit))
        crit_levels_u <- lapply(crit_levels, function(cl) return(cl[length(cl)]))

        st_db12_unique <- lapply(crit_levels_u, function(clu) {
          content_to_clause(subset_tree(st_criteria_subgroup, clu)[[1]], language = language)
        } )

        st_db12_taxaonly <- lapply(st_db12_unique, function(stdb) {
          subset(stdb, stdb$logic %in% c("NEW", "NUEVA", "LAST", "ULTIMA"))
        })

        ## make whole ST database
        ## first with each taxon fully constructed at each level (redundant)
        st_db12 <- lapply(unique(st_criteria_subgroup$crit), function(crit) {
          crit_levels <- decompose_taxon_ID(c(crit))
          content_to_clause(subset_tree(st_criteria_subgroup, crit_levels)[[1]])
        })

        # get full names of taxa for lookuptable
        res <- lapply(st_db12_unique, function(st_sub) {
          idx <- which(st_sub$logic %in% c("NEW", "NUEVA", "LAST", "ULTIMA"))
          st_sub[idx[length(idx)], ]
        })

        taxa.lut <- (lapply(res[unlist(lapply(res, function(res_sub) {
          length(res_sub) > 0
        }))], function(x) x$content))

        codes.lut <- names(taxa.lut)

        # process to remove page numbers
        taxchar <- as.character(taxa.lut)
        taxchar.pg.idx <- grep("^(.*), p\\..*$|^(.*), p\u00e1g\\..*$", taxchar)
        taxchar[taxchar.pg.idx] <-  gsub("^(.*), p\\..*$|^(.*), p\u00e1g\\..*$", "\\1\\2", taxchar[taxchar.pg.idx])

        # couple fixes
        taxchar <- (gsub("aqnalfs", "aqualfs", taxchar))
        taxa.lut <- taxchar
        names(taxa.lut) <- codes.lut
        names(codes.lut) <- taxchar

        # highlight taxa
        .highlightTaxa <- function(content, taxon) {
          out <- content
          idx <- grepl(sprintf("%s[^\\.]", taxon), content, fixed = TRUE)

          if (length(idx)) {
            out <- gsub(sprintf("%s", taxon), sprintf("<i>%s</i>", taxon),
                        out, fixed = TRUE)
          }
          return(out)
        }
        diagnostic_features <- get_diagnostic_search_list()

        last <- 1
        idx <- unlist(lapply(diagnostic_features, function(x) {
          res <- grep(pattern = sprintf("^%s", x), st_def$content, ignore.case = FALSE)
          if (length(res) > 1)
            res <- res[res > last][1]
          last <<- res
          return(res)
        }))

        # parse diagnostic features (english only for now)
        if (language == "EN") {

          fts <- vector('list', length(idx))
          for (i in 1:(length(idx))) {
            endidx <- ifelse(i == length(idx), nrow(st_def), idx[i + 1] - 1)
            fts[[i]] <- st_def[idx[i]:endidx,]
          }

          features <- lapply(fts, parse_feature)
          names(features) <- lapply(features, function(f) paste(f$name, f$page))

          masterfeaturenames <- c(
              "Mineral Soil Material 3",
              "Diagnostic Surface Horizons: 7",
              "Diagnostic Subsurface Horizons 11",
              "Diagnostic Soil Characteristics for Mineral Soils 17",
              "Characteristics Diagnostic for Organic Soils 23",
              "Horizons and Characteristics 26",
              "Characteristics Diagnostic for Human-Altered and Human-Transported Soils 32",
              "Family Differentiae for Mineral Soils and Mineral Layers of Some Organic Soils 317",
              "Family Differentiae for Organic Soils 331",
              "Series Differentiae Within a Family 333")

          newmasterfeaturenames <- c("Soil Materials",
                                     "Surface","Subsurface","Mineral",
                                     "Organic","Mineral or Organic",
                                     "Human","Mineral Family",
                                     "Organic Family", "Series")

          feat.idx <- c(match(masterfeaturenames, names(features)), length(features))

          mfeatures <- lapply(lapply(1:length(masterfeaturenames),
                                     function(i) feat.idx[i]:(feat.idx[i + 1] - 1)),
                              function(idx) { features[idx] })
          names(mfeatures) <- newmasterfeaturenames

          featurelist <- do.call('rbind', lapply(newmasterfeaturenames, function(mfn) {
            mf <- mfeatures[[mfn]]
            res <- cbind(group = mfn, do.call('rbind', lapply(mf, function(mff) {
              mff$criteria <- list(mff$criteria)
              tibble::as_tibble(mff)
            })))
            return(res)
          }))
          rownames(featurelist) <- NULL
          featurelist <- tibble::as_tibble(featurelist)

          # force ASCII and convert some unicode characters
          .clean_feature_string <- function(x) {
            gsub("\u001a", "", gsub("\u001a\u001a\u001a", " ",
                                    trimws(stringi::stri_enc_toascii(
                                      gsub("\u201c|\u201d", '\\"',
                                           gsub("\u2019", "'",
                                                  gsub("\u2020", " [see footnote]",
                                                       gsub("\u00bd", "1/2", x))))))))
          }

          featurelist$description <- .clean_feature_string(featurelist$description)
          featurelist$criteria <- lapply(featurelist$criteria, .clean_feature_string)

          write(convert_to_json(featurelist), file = "./inst/extdata/KST/2014_KST_EN_featurelist.json")
        }

        # use group names for matching
        names(st_db12) <- names(codes.lut)
        names(st_db12_unique) <- names(codes.lut)
        names(st_db12_taxaonly) <- names(codes.lut)

        .do_HTML_postprocess <- function(stdb) {
          lapply(names(stdb), function(stdbnm) {
            stdb <- stdb[[stdbnm]]

            newlast.idx <- which(stdb$logic %in% c("NEW","LAST","NUEVA","ULTIMA"))
            if(length(newlast.idx)) {
              stdb$content <- .highlightTaxa(stdb$content, stdbnm)
            }

            # highlight codes
            stdb$content <- gsub("^([A-Z]+[a-z]*\\.)(.*)$", "<b><u>\\1</u></b>\\2", stdb$content)
            stdb$content <- gsub("^([1-9]*\\.)(.*)$", "&nbsp;<b>\\1</b>\\2", stdb$content)
            stdb$content <- gsub("^([^A-Z][a-z]*\\.)(.*)$", "&nbsp;&nbsp;<b>\\1</b>\\2", stdb$content)
            stdb$content <- gsub("^(\\([1-9]*\\))(.*)$", "&nbsp;&nbsp;&nbsp;<b>\\1</b>\\2", stdb$content)
            stdb$content <- gsub("^(\\([a-z]*\\))(.*)$", "&nbsp;&nbsp;&nbsp;&nbsp;<b>\\1</b>\\2", stdb$content)
            stdb$content <- gsub("^(.*)(\\; and|\\; or)$", "\\1<i>\\2</i>", stdb$content)
            stdb$content <- gsub("^(.*)(\\; y|\\; o)$", "\\1<i>\\2</i>", stdb$content)
            stdb$key <- gsub("Key to |Claves* para ", "", stdb$key)
            return(stdb)
          })
        }

        st_db12_html <- .do_HTML_postprocess(st_db12)
        # st_db12_unique <- .do_HTML_postprocess(st_db12_unique)
        st_db12_taxaonly <- .do_HTML_postprocess(st_db12_taxaonly)
        st_db12_preceding <- preceding_taxon_ID(codes.lut)

        # go back to codes for output
        names(st_db12) <- codes.lut
        names(st_db12_html) <- codes.lut
        names(st_db12_unique) <- codes.lut
        names(st_db12_taxaonly) <- codes.lut
        names(st_db12_preceding) <- codes.lut

        # remove front matter if present
        if (names(st_db12[1]) == "*") {
          st_db12[[1]] <- NULL
          st_db12_unique[[1]] <- NULL
          st_db12_html[[1]] <- NULL
          st_db12_taxaonly[[1]] <- NULL
          st_db12_preceding[[1]] <- NULL
          codes.lut <- codes.lut[2:length(codes.lut)]
          taxa.lut <- names(codes.lut)
          names(taxa.lut) <- codes.lut
        } else if (names(st_db12[1]) != "A") {
          stop("somehow Gelisols are not first")
        }

        # save(st_db12,
        #      st_db12_unique,
        #      st_db12_html,
        #      st_db12_preceding,
        #      taxa.lut,
        #      codes.lut,
        #      file = sprintf("./inst/extdata/KST/2014_KST_db_%s.Rda", language))

        write(convert_to_json(st_db12),
              file = sprintf("./inst/extdata/KST/2014_KST_criteria_%s.json", language))
        write(convert_to_json(st_db12_unique),
              file = sprintf("./inst/extdata/KST/2014_KST_criteria_%s.json", language))

        # this binary file does not get version-controlled: ~15MB as json, ~1MB as rda
        save(st_db12_html, file = sprintf("./inst/extdata/KST/2014_KST_HTML_%s.rda", language))

        # can be readily calculated with ncss-tech/SoilTaxonomy package
        # write(convert_to_json(st_db12_preceding),
        #      file = sprintf("./inst/extdata/KST/2014_KST_preceding_%s.json", language))

        if (language == "EN") {
          code_lut <- data.frame(code = as.character(codes.lut),
                                 name = names(codes.lut))
          write(convert_to_json(code_lut), file = "./inst/extdata/KST/2014_KST_codes.json")
        }
    }
  })

  if (inherits(attempt, 'try-error'))
    return(FALSE)

  message("Done!")
  return(TRUE)
}

download_KST <- function(outpath = "./inst/extdata",
                         download_pdf = "ifneeded",
                         keep_pdf = FALSE,
                         language = "EN",
                         edition = "12th",
                         ...) {
  # create output path
  if (!dir.exists(file.path(outpath, "KST"))) {
    dir.create(file.path(outpath, "KST"), "KST", recursive = TRUE)
  }

  if (edition == "12th") {
    yhref <- "https://github.com/brownag/SoilKnowledgeBase-data-archive/raw/main/KST/Keys-to-Soil-Taxonomy_12th_2014.pdf"

    if (language == "SP") {
      yhref <- "https://github.com/brownag/SoilKnowledgeBase-data-archive/raw/main/KST/Keys-to-Soil-Taxonomy_Spanish_12th_2014.pdf"
    }

    fn <- sprintf("2014_KST_%s.pdf", language)
  } else {
    # hard coding 13th edition (uses same URL 12th used to)
    yhref <- "https://www.nrcs.usda.gov/sites/default/files/2022-09/Keys-to-Soil-Taxonomy.pdf"

    fn <- sprintf("2022_KST_%s.pdf", language)
  }


  if (as.character(download_pdf) == "ifneeded") {
    download_pdf <- !file.exists(fn)
  }

  if (as.logical(download_pdf)) {
    message("Downloading ", yhref, "...")
    curl::curl_download(yhref, destfile = fn, handle = .SKB_curl_handle(), ...)
  }

  if (file.exists(fn)) {
    # txt <- pdftools::pdf_text(fn)
    message("Running pdftotext on ", fn, "...")
    system(sprintf("pdftotext -raw -nodiag %s", fn))
  } else {
    message(fn, " does not exist!")
    return(file.exists(fn))
  }

  if (keep_pdf) {
    file.copy(fn, file.path(outpath, "KST", fn))
  }
  file.remove(fn)

  of <- gsub("\\.pdf",".txt", fn)
  if (file.exists(of)) {
    op <- file.path(outpath, "KST", of)

    writeLines(readLines(of), con = op)
    return(file.exists(op))
  }
  message(of, " does not exist!")
  return(FALSE)
}

get_page_breaks <- function(content) {
  # calculate page break indices in content, assign names for arabic numberal pages
  # cannot quite just use the form feed character -- variety of formats due to parsing
  #.pages.idx <- which(grepl("\\f", content))
  idx.break <- grep("\\f", content)
  ispage <- gsub("\\f[\\D]*([0-9iv]*).?", "\\1", content[idx.break])
  numbered.pages <- suppressWarnings(as.numeric(gsub("[A-Za-z]*", "", ispage)))
  .pages.idx <- idx.break
  names(.pages.idx) <- numbered.pages
  return(.pages.idx)
}

page_to_index <- function(content, page.number) {
  .pages.idx <- get_page_breaks(content)
  if (is.na(page.number) || any(page.number < 1) || any(page.number > (length(.pages.idx) + 1)))
    stop("page number outside page index")
  if (page.number %in% names(.pages.idx))
    page.number <- which(page.number == names(.pages.idx))[1]
  # the page break comes before the page
  res <- .pages.idx[page.number]
  # the first page does not start with a page break
  if (length(res) == 0)
    res <- 1
  return(res)
}

index_to_page <- function(content, index) {
  .pages.idx <- get_page_breaks(content)
  # calculate the first index to exceed
  res <- unlist(lapply(index, function(i) which(.pages.idx >= i)[1]))
  # the page number is the page before the exceeding index
  return(names(.pages.idx)[res - 1])
}

first_match_to_page <- function(pattern, content) {
  index_to_page(content, grep(pattern, content)[1])
}

# create a category for each line based on a vector of line indices
# optional: add custom values for each index
category_from_index <- function(idx, n, values = NULL) {
  group.breaks <-  diff(idx)
  #group.breaks <- c(group.breaks, n - sum(group.breaks))
  res <- numeric(0)
  n.grp <- length(group.breaks)
  if (is.null(values) | length(values) < n.grp)
    stop("foo")
  for (i in 1:n.grp) {
    if(group.breaks[i] > 0)
      res <- c(res, rep(values[i], group.breaks[i]))
  }
  return(res)
}

get_taxon_breaks <-  function(content, key) {
  crit.idx <- which(grepl("^([A-Z]+[a-z]?)\\..*$", content))
  crit.to.what <- gsub("^([A-Z]+[a-z]?)\\..*$", "\\1", content[crit.idx])
  bad.idx <- which(nchar(crit.to.what) == 1 &
                     key[crit.idx] != "Key to Soil Orders" &
                     key[crit.idx] != "Claves para \u00d3rdenes de Suelo")
  names(crit.idx) <- crit.to.what
  if (length(bad.idx) > 0)
    crit.idx <- crit.idx[-bad.idx]
  return(crit.idx)
}

decompose_taxon_ID <- function(crit) {
  clevels <- sapply(crit, function(cr) strsplit(cr, character(0)))
  clevel.sub <- lapply(clevels, function(cl) grepl("[a-z]", cl[length(cl)]))
  inter <- lapply(clevels, function(l) {
    res <- vector("list", length(l))
    for(i in 1:length(l)) {
      res[i] <- paste0(l[1:i], collapse = "")
    }
    return(res)
  })
  out <- lapply(1:length(inter), function(j) {
    res <- inter[j][[1]]
    if (clevel.sub[[names(inter[j])]]) {
      res[length(res) - 1] <- NULL
    }
    return(res)
  })
  names(out) <- crit
  return(out)
}

preceding_taxon_ID <- function(ids) {
  lapply(ids, function(i) {
    out <- vector(mode = 'list',
                  length = nchar(i))
    parenttaxon <- character(0)
    for (j in 1:nchar(i)) {
      idx <- which(LETTERS == substr(i, j, j))
      idx.ex <- which(letters == substr(i, j, j))
      if (length(idx)) {
        previoustaxa <- LETTERS[1:idx[1] - 1]
        out[[j]] <- previoustaxa
        if (length(parenttaxon) > 0) {
          if(length(previoustaxa))
            out[[j]] <- paste0(parenttaxon, previoustaxa)
          newparent <- LETTERS[idx[1]]
          if(length(newparent))
            parenttaxon <- paste0(parenttaxon, newparent)
        } else {
          parenttaxon <- LETTERS[idx[1]]
        }
      } else if (length(idx.ex)) {
        previoustaxa <- c("", letters[1:idx.ex[1]])
        out[[j]] <- previoustaxa
        if (length(parenttaxon) > 0) {
          out[[j]] <- paste0(parenttaxon, previoustaxa)
          parenttaxon <- paste0(parenttaxon, letters[idx.ex[1]])
        } else {
          parenttaxon <- letters[idx.ex[1]]
        }
      } else {
        out[[j]] <- NA
      }
    }

    return(do.call('c', out))
  })
}

subset_tree <- function(st_tree, crit_levels) {
  lapply(crit_levels, function(crit_level) {
    do.call('rbind', lapply(crit_level, function(cl) {
      st_tree[which(st_tree$crit == cl), , drop = FALSE]
    }))
  })
}

content_to_clause <- function(st_tree, language = "EN") {
  clause.en <- ";\\*? and$|;\\*? or$|[\\.:]$|p\\. [0-9]+|[:] [Ee]ither|[.:]$|\\.\\)$"
  clause.sp <- ";\\*? y$|;\\*? o$|[\\.:]$|p\u00e1g\\. [0-9]+|[:] [Yy]a sea|[.:]$|\\.\\)|artificial\\)$|ci\u00f3n\\)$"
  clause.idx <- grep(paste0(clause.en,"|",clause.sp), st_tree$content)

  st_tree$clause <- category_from_index(
    idx = c(0, clause.idx, length(st_tree$content)),
    n = length(st_tree$content),
    values = 1:(length(clause.idx) + 1)
  )

  res <- (do.call('rbind', lapply(split(st_tree, st_tree$clause),
                                  function(tsub) {
                                    newcontent <- paste0(tsub$content, collapse = " ")
                                    newtsub <-
                                      tsub[1, ] # take page where clause starts etc, assume same otherwise
                                    newtsub$content <- newcontent
                                    return(newtsub)
                                  })))

  # remove footnotes
  footnote.idx <- grep("^\u2020|^\\*|[_]+ \u2020", res$content)
  if (length(footnote.idx) > 0)
    res <- res[-footnote.idx, ]

  # classify basic logical operators on complete clauses
  logic.and <-
    grepl("and$| y$", res$content) |
    grepl("[Bb]oth.*[:]$|[Aa]mbas.*[:]", res$content) |
    grepl("[Aa]ll of.*[:]$|[Tt]odos.*[:]", res$content)
  logic.or <- (
    grepl("or$| o$", res$content) |
      grepl("[Ee]ither.*[:]$|[Oo]r.*[:]$|[Yy]a sea.*[:]$", res$content) |
      grepl("[Oo]ne or more.*[:]$|[Uu]na o m\u00e1s.*[:]$", res$content) |
      grepl("[:] [Ee]ither$|[Yy]a sea[:]$", res$content)
  ) # rare (spodosols)
  logic.endclause <-
    grepl("[.]$|or more$", res$content)
  # or more for kandic/kanhaplic ustalfs
  logic.newkey <- grepl("p\\. [0-9]+|p\u00e1g\\. [0-9]+", res$content)
  logic.none <- !any(logic.and, logic.or, logic.endclause, logic.newkey)

  lmat <-  data.frame(
    AND = logic.and,
    OR = logic.or,
    END = logic.endclause,
    NEW = logic.newkey,
    NUL = logic.none
  )

  if (language == "SP")
    colnames(lmat) <- c("Y","O","FIN","NUEVA","NULL")

  lval <- names(lmat)[apply(lmat, 1, function(ro) {
    which(ro)[1]
  })]

  firsttext <- ifelse(language == "SP", "PRIMERA", "FIRST")
  lasttext <- ifelse(language == "SP", "ULTIMA", "LAST")

  lval[is.na(lval) & 1:length(lval) == 1] <- firsttext
  lval[is.na(lval) & 1:length(lval) == length(lval)] <- lasttext

  # fix for single-criterion taxa
  if (length(lval) == 2)
    lval <- c(firsttext, lasttext)

  res$logic <- lval
  return(res)
}

parse_feature <- function(f) {
  rchar <- grep("^Required Characteristics$", f$content)
  kchar <- grep("^A\\. ", f$content)
  if(length(rchar) == 0 & length(kchar) == 0) {
    return(list(name        =  f$content[1],
                chapter     =  f$chapter[1],
                page        =  f$page[1],
                description =  paste0(f$content[2:nrow(f)], collapse = " "),
                criteria    =  ""))
  }

  startchar <- 2
  endchar <- rchar
  if(length(endchar) == 0)
    endchar <- kchar

  if(length(endchar) > 1) {
    message("possible bad parsing: ", f$content[1])
  }

  if(endchar[1] < 3) {
    if (endchar[1] == 2)
      startchar <- NA
  }

  descr <- ""
  if(!is.na(startchar))
    descr <- paste0(f$content[startchar:(endchar[1] - 1)], collapse=" ")

  list(name        =  f$content[1],
       chapter     =  f$chapter[1],
       page        =  f$page[1],
       description =  descr,
       criteria    =  content_to_clause(f[endchar[1]:nrow(f),])$content)

}

get_chapter_markers <- function(language = "EN", edition = "12th") {


  chapter.markers.en <- list(
    ch1 = "like many common words, has several",
    ch2 = "Soil taxonomy differentiates between mineral soils and",
    ch3 = "This chapter defines the horizons and characteristics of",
    ch4 = "The taxonomic class of a specific soil can be determined",
    ch5 = "Alfisols that have, in one or more horizons within 50 cm",
    ch6 = "Andisols that have either:",
    ch7 = "Aridisols that have a cryic soil temperature regime",
    ch8 = "Entisols that have a positive water potential at the soil",
    ch9 = "Gelisols that have organic soil materials that meet one or",
    ch10 = "Histosols that are saturated with water for less than 30",
    ch11 = "Inceptisols that have one or more of the following",
    ch12 = "Mollisols that have all of the following",
    ch13 = "Oxisols that have aquic conditions for some time in",
    ch14 = "Spodosols that have aquic conditions for some time in",
    ch15 = "Ultisols that have aquic conditions for some time in",
    ch16 = "Vertisols that have, in one or more horizons within 50",
    ch17 = "Families and series serve purpose",
    ch18 = "This chapter describes soil layers and genetic soil horizons",
    appendix = "Data Elements Used in Classifying Soils"
  )

  if (edition == "13th") {
    chapter.markers.en$ch2 <- "Soils are composed of both"
    chapter.markers.en$ch8 <- "Entisols that have a field observable water"
    return(chapter.markers.en)
  }

  chapter.markers.sp <- list(
    ch1 = "como muchas otras, tiene varios",
    ch2 = "En la Taxonom\u00eda de Suelos se hace una diferenciaci\u00f3n",
    ch3 = "En este cap\u00edtulo se definen los horizontes y las",
    ch4 = "La clase taxon\u00f3mica de un suelo espec\u00edfico se puede",
    ch5 = "Alfisols que tienen, en uno o m\u00e1s horizontes, dentro",
    ch6 = "Andisols que tienen ya sea:",
    ch7 = "Aridisols que tienen un r\u00e9gimen de temperatura",
    ch8 = "Entisols que tienen un potencial de agua positivo",
    ch9 = "Gelisols que tienen materiales org\u00e1nicos de suelo",
    ch10 = "Histosols que est\u00e1n saturados con agua por menos",
    ch11 = "Inceptisols que tienen una o m\u00e1s de las siguientes",
    ch12 = "Mollisols que tienen todas las siguientes",
    ch13 = "Oxisols que tienen condiciones \u00e1cuicas por alg\u00fan",
    ch14 = "Spodosols que tienen condiciones \u00e1cuicas por",
    ch15 = "Ultisols que tienen condiciones \u00e1cuicas por alg\u00fan",
    ch16 = "Vertisols que tienen, en uno o m\u00e1s horizontes",
    ch17 = "Las familias y las series sirven para prop\u00f3sitos",
    ch18 = "En este cap\u00edtulo se describen los horizontes gen\u00e9ticos",
    appendix = "M\u00e9todos de Laboratorio para la"
  )

  switch(language,
         EN = chapter.markers.en,
         SP = chapter.markers.sp)
}

get_chapter_orders <- function(language = "EN") {
  # 12th edition; same for EN/SP (language argument currently not used)
  list(
    "5" = "Alfisols",
    "6" = "Andisols",
    "7" = "Aridisols",
    "8" = "Entisols",
    "9" = "Gelisols",
    "10" = "Histosols",
    "11" = "Inceptisols",
    "12" = "Mollisols",
    "13" = "Oxisols",
    "14" = "Spodosols",
    "15" = "Ultisols",
    "16" = "Vertisols"
  )
}


get_diagnostic_search_list <- function(language = "EN") {
  # TODO: spanish language support
  stopifnot(language == "EN")

  ## quick and dirty way to get some names to begin the process (iterative)
  # st_def$content <- gsub("Required Characteristics", "Required Characteristics.", st_def$content)
  # cst_def <- content_to_clause(st_def)
  # idx <- grep("Required Characteristics", ignore.case = FALSE, cst_def$content)
  # lapply(idx, function(i) cst_def$content[(i+1)])

  # TODO: proper naming for incomplete identifiers or w/ non-alpha characters
  c("Mineral Soil Material",
    "Organic Soil Material",
    "Distinction Between Mineral Soils and Organic",
    "Soil Surface",
    "Mineral Soil Surface",
    "Definition of Mineral Soils",
    "Definition of Organic Soils",
    "Diagnostic Surface Horizons:",
    "Anthropic Epipedon",
    "Folistic Epipedon",
    "Histic Epipedon",
    "Melanic Epipedon",
    "Mollic Epipedon",
    "Ochric Epipedon",
    "Plaggen Epipedon",
    "Umbric Epipedon",
    "Diagnostic Subsurface Horizons",
    "Agric Horizon",
    "Albic Horizon",
    "Anhydritic Horizon",
    "Argillic Horizon",
    "Calcic Horizon",
    "Cambic Horizon",
    "Duripan",
    "Fragipan",
    "Glossic Horizon",
    "Gypsic Horizon",
    "Kandic Horizon",
    "Natric Horizon",
    "Ortstein",
    "Oxic Horizon",
    "Petrocalcic Horizon",
    "Petrogypsic Horizon",
    "Placic Horizon",
    "Salic Horizon",
    "Sombric Horizon",
    "Spodic Horizon",
    "Diagnostic Soil Characteristics for Mineral",
    "Abrupt Textural Change",
    "Albic Materials",
    "Andic Soil Properties",
    "Anhydrous Conditions",
    "Coefficient of Linear Extensibility \\(COLE\\)",
    "Fragic Soil Properties",
    "Free Carbonates",
    "Identifiable Secondary Carbonates",
    "Interfingering of Albic Materials",
    "Lamellae*",
    "Linear Extensibility \\(LE\\)",
    "Lithologic Discontinuities",
    "n Value",
    "Petroferric Contact",
    "Plinthite",
    "Resistant Minerals",
    "Slickensides",
    "Spodic Materials",
    "Volcanic Glass",
    "Weatherable Minerals",
    "Characteristics Diagnostic for Organic Soils",
    "Kinds of Organic Soil Materials",
    "Fibers",
    "Fibric Soil Materials",
    "Hemic Soil Materials",
    "Sapric Soil Materials",
    "Humilluvic Material",
    "Kinds of Limnic Materials",
    "Coprogenous Earth",
    "Diatomaceous Earth",
    "Marl",
    "Thickness of Organic Soil Materials",
    "Surface Tier",
    "Subsurface Tier",
    "Bottom Tier",
    "Horizons and Characteristics",
    "Aquic Conditions",
    "Cryoturbation",
    "Densic Contact",
    "Densic Materials",
    "Gelic Materials",
    "Ice Segregation",
    "Glacic Layer",
    "Lithic Contact",
    "Paralithic Contact",
    "Paralithic Materials",
    "Permafrost",
    "Soil Moisture Regimes",
    "Soil Moisture Control Section",
    "Classes of Soil Moisture Regimes",
    "Sulfidic Materials",
    "Sulfuric Horizon",
    "Characteristics Diagnostic for Human-Altered and Human-Transported Soils",
    "Anthropogenic Landforms",
    "Anthropogenic Landforms",
    "Constructional Anthropogenic Landforms",
    "Destructional Anthropogenic Landforms",
    "Anthropogenic Microfeatures",
    "Constructional Anthropogenic Microfeatures",
    "Destructional Anthropogenic Microfeatures",
    "Artifacts",
    "Human-Altered Material",
    "Human-Transported Material",
    "Manufactured Layer",
    "Manufactured Layer Contact",
    "Subgroups for Human-Altered and Human\\-",
    "Family Differentiae for Mineral Soils and",
    "Control Section for Particle-Size Classes and Their",
    "Key to the Particle-Size and Substitute Classes of Mineral",
    "Strongly Contrasting Particle-Size Classes",
    "Use of Human-Altered and Human-Transported Material",
    "Key to Human-Altered and Human-Transported Material",
    "Key to the Control Section for Human-Altered and Human-Transported Material Classes",
    "Key to Human-Altered and Human-Transported Material Classes",
    "Mineralogy Classes",
    "Control Section for Mineralogy Classes",
    "Key to Mineralogy Classes",
    "Cation-Exchange Activity Classes",
    "Use of the Cation-Exchange Activity Classes",
    "Control Section for Cation-Exchange Activity Classes",
    "Key to Cation-Exchange Activity Classes",
    "Calcareous and Reaction Classes of Mineral Soils",
    "Soil Temperature Classes",
    "Key to Soil Temperature Classes",
    "Soil Depth Classes",
    "Key to Soil Depth Classes for Mineral Soils and Histels",
    "Rupture-Resistance Classes",
    "Classes of Coatings on Sands",
    "Classes of Permanent Cracks",
    "Family Differentiae for Organic Soils",
    "Particle-Size Classes",
    "Control Section for Particle-Size Classes",
    "Key to Particle-Size Classes of Organic Soils",
    "Mineralogy Classes Applied Only to Limnic Subgroups",
    "Control Section for the Ferrihumic Mineralogy Class and",
    "Mineralogy Classes Applied Only to Terric Subgroups",
    "Control Section for Mineralogy Classes Applied Only to",
    "Key to Mineralogy Classes",
    "Reaction Classes",
    "Soil Temperature Classes",
    "Soil Depth Classes",
    "Series Differentiae Within a Family",
    "Control Section for the Differentiation of Series",
    "Key to the Control Section for the Differentiation"
  )
}
