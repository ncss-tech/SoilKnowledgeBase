#' Create Keys to Soil Taxonomy (13th edition) Datasets
#'
#' @param ... arguments passed to `download_KST`
#'
#' @return TRUE if successful
#' @export
#' @importFrom tibble as_tibble
#' @importFrom stringi stri_enc_toascii
create_KST13 <- function(...) {
  args <- list(...)
  message("Creating Keys to Soil Taxonomy (13th Edition) datasets...")
  download_pdf <- TRUE
  if (!is.null(args[["download_pdf"]])) {
    download_pdf <- args[["download_pdf"]]
  }

  keep_pdf <- FALSE
  if (!is.null(args[["keep_pdf"]])) {
    keep_pdf <- args[["keep_pdf"]]
  }

  attempt <- try({
    languages <- c("EN") #, "SP") # No spanish language 13th edition currently available

    for (language in languages) {
      # markers for first page of each chapter
      chapter.markers <- get_chapter_markers(language = language, edition = "13th")
      
      # lookup table for chapter number:order name relationship
      chapter.taxon.lut <- get_chapter_orders(language = language)

      message("language: ", language)

      pdftxtfile <- file.path("./inst/extdata/KST", sprintf("2022_KST_%s.txt", language))
      # TODO: check version?

      # download PDF, convert to TXT and put in inst/extdata
      if (!download_KST(
        download_pdf = download_pdf,
        keep_pdf = keep_pdf,
        language = language,
        edition = "13th",
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

        if (is.na(chp1)) {
          message("could not find chapter marker for chapter ", p)
          return(FALSE)
        }
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

      # perform various 13th-edition specific fixes

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

      # remove page linefeed markup
      st <- st[-pgidx, ]

      # remove three-letter abbreviated headers and CHAPTER X
      st <- st[-grep("^CHAPTER|^[A-Z]$|^CAP\u00cdTULO", st$content), ]

      # remove multi underscore footnote markup (spanish)
      if (language == "SP")
        st <- st[-grep("\\_\\_+", st$content),]

      # fix dangling AND/ORs
      orfix <- grep("^or$|^o$", st$content)
      andfix <- grep("^and$|^y$", st$content)
      st$content[orfix - 1] <- paste0(st$content[orfix - 1], " or")
      st$content[andfix - 1] <- paste0(st$content[andfix - 1], " and")
      
      # remove dangling order labels (exact match for order names)
      st <- st[!st$content %in% c("Gelisols", "Histosols", "Spodosols", "Andisols", "Oxisols", 
                                 "Vertisols", "Aridisols", "Ultisols", "Mollisols", "Alfisols", 
                                 "Inceptisols", "Entisols"),]
      
      # vertisols suborder key
      st$content[grep("Key to Suborders*", st$content, fixed = TRUE)] <- "Key to Suborders"

      # thapto-humic hydraquents LBBD
      st$content[grep("^or more Holocene-age organic carbon$", st$content)] <-
                 "or more Holocene-age organic carbon."
            
      # duric xeric torrifluvents LDEG
      st$content[grep("an aridic \\(or torric\\) soil moisture regime that borders on xeric", st$content)] <- 
                 "an aridic (or torric) soil moisture regime that borders on xeric."

      # petrocalcic natrudolls IHAA
      # remove footnote about plowing
      idx <- grep("Petrocalcic Natrudolls", st$content)+(1:3)
      if (length(idx) > 0) {
        if (st$content[idx[1]] == "*")
          st <- st[-idx,]
      }
      
      # plinthic eutraquox EACB
      # remove footnote about plinthite/ironstone
      idx <- grep("Plinthic Eutraquox", st$content)+(1:5)
      if (length(idx) > 0) {
        if (st$content[idx[1]] == "*")
          st <- st[-idx,]
      }
      
      # Thapto-Humic Fibristels AACC
      # remove footnote
      idx <- grep("Thapto-Humic Fibristels", st$content)+(1:6)
      if (length(idx) > 0) {
        if (st$content[idx[1]] == "*")
          st <- st[-idx,]
      }
      
      # Sphagnic Cryofibrists BCAE
      # remove footnote
      idx <- grep("BCAE.", st$content)+(1:5)
      if (length(idx) > 0) {
        if (st$content[idx[1]] == "*")
          st <- st[-idx,]
      }
      
      # split by chapter
      ch <- split(st, f = st$chapter)

      # save ch 1:4 + end chapters for definitions and criteria
      st_def <- do.call('rbind', ch[c(1:4,18)])

      # TODO: needed?
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
        key.to.what <- gsub("^(Key to [A-Z a-z\\*]*)$|^(Claves* para .*)$",
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
            taxsub.l <- startsWith(key.to.what, "Key to Suborders") |
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

      st_db13_unique <- lapply(crit_levels_u, function(clu) {
        content_to_clause(subset_tree(st_criteria_subgroup, clu)[[1]], language = language)
      } )

      st_db13_taxaonly <- lapply(st_db13_unique, function(stdb) {
        subset(stdb, stdb$logic %in% c("NEW", "NUEVA", "LAST", "ULTIMA"))
      })

      ## make whole ST database
      ## first with each taxon fully constructed at each level (redundant)
      st_db13 <- lapply(unique(st_criteria_subgroup$crit), function(crit) {
        crit_levels <- decompose_taxon_ID(c(crit))
        content_to_clause(subset_tree(st_criteria_subgroup, crit_levels)[[1]])
      })

      # get full names of taxa for lookuptable
      res <- lapply(st_db13_unique, function(st_sub) {
        idx <- which(st_sub$logic %in% c("NEW", "NUEVA", "LAST", "ULTIMA"))
        st_sub[idx[length(idx)], ]
      })

      taxa.lut <- lapply(res[unlist(lapply(res, function(res_sub) {
        length(res_sub) > 0
      }))], function(x) x$content)

      codes.lut <- names(taxa.lut)

      # process to remove page numbers
      taxchar <- gsub("([A-Za-z]+)\\* *(.*)", "\\1\\2", trimws(taxa.lut))
      taxchar.pg.idx <- grep("^(.*), p\\..*$|^(.*), p\u00e1g\\..*$", taxchar)
      taxchar[taxchar.pg.idx] <-  gsub("^(.*), p\\..*$|^(.*), p\u00e1g\\..*$", "\\1\\2", taxchar[taxchar.pg.idx])

      taxa.lut <- taxchar
      names(taxa.lut) <- codes.lut
      names(codes.lut) <- taxa.lut

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
      # diagnostic_features <- get_diagnostic_search_list()
      # 
      # last <- 1
      # idx <- unlist(lapply(diagnostic_features, function(x) {
      #   res <- grep(pattern = sprintf("^%s", x), st_def$content, ignore.case = FALSE)
      #   if (length(res) > 1)
      #     res <- res[res > last][1]
      #   last <<- res
      #   return(res)
      # }))
      # TODO: some NA indices

      # parse diagnostic features (english only for now)
      # if (language == "EN") {
      # 
      #   fts <- vector('list', length(idx))
      #   for (i in 1:(length(idx))) {
      #     endidx <- ifelse(i == length(idx), nrow(st_def), idx[i + 1] - 1)
      #     fts[[i]] <- st_def[idx[i]:endidx,]
      #   }
      # 
      #   features <- lapply(fts, parse_feature)
      #   names(features) <- lapply(features, function(f) paste(f$name, f$page))
      # 
      #   masterfeaturenames <- c(
      #     "Mineral Soil Material 3",
      #     "Diagnostic Surface Horizons: 7",
      #     "Diagnostic Subsurface Horizons 11",
      #     "Diagnostic Soil Characteristics for Mineral Soils 17",
      #     "Characteristics Diagnostic for Organic Soils 23",
      #     "Horizons and Characteristics 26",
      #     "Characteristics Diagnostic for Human-Altered and Human-Transported Soils 32",
      #     "Family Differentiae for Mineral Soils and Mineral Layers of Some Organic Soils 317",
      #     "Family Differentiae for Organic Soils 331",
      #     "Series Differentiae Within a Family 333")
      # 
      #   newmasterfeaturenames <- c("Soil Materials",
      #                              "Surface","Subsurface","Mineral",
      #                              "Organic","Mineral or Organic",
      #                              "Human","Mineral Family",
      #                              "Organic Family", "Series")
      # 
      #   feat.idx <- c(match(masterfeaturenames, names(features)), length(features))
      # 
      #   mfeatures <- lapply(lapply(1:length(masterfeaturenames),
      #                              function(i) feat.idx[i]:(feat.idx[i + 1] - 1)),
      #                       function(idx) { features[idx] })
      #   names(mfeatures) <- newmasterfeaturenames
      # 
      #   featurelist <- do.call('rbind', lapply(newmasterfeaturenames, function(mfn) {
      #     mf <- mfeatures[[mfn]]
      #     res <- cbind(group = mfn, do.call('rbind', lapply(mf, function(mff) {
      #       mff$criteria <- list(mff$criteria)
      #       tibble::as_tibble(mff)
      #     })))
      #     return(res)
      #   }))
      #   rownames(featurelist) <- NULL
      #   featurelist <- tibble::as_tibble(featurelist)
      # 
      #   # force ASCII and convert some unicode characters
      #   .clean_feature_string <- function(x) {
      #     gsub("\u001a", "", gsub("\u001a\u001a\u001a", " ",
      #                             trimws(stringi::stri_enc_toascii(
      #                               gsub("\u201c|\u201d", '\\"',
      #                                    gsub("\u2019", "'",
      #                                         gsub("\u2020", " [see footnote]",
      #                                              gsub("\u00bd", "1/2", x))))))))
      #   }
      # 
      #   featurelist$description <- .clean_feature_string(featurelist$description)
      #   featurelist$criteria <- lapply(featurelist$criteria, .clean_feature_string)
      # 
      #   write(convert_to_json(featurelist), file = "./inst/extdata/KST/2014_KST_EN_featurelist.json")
      # }

      # use group names for matching
      names(st_db13) <- names(codes.lut)
      names(st_db13_unique) <- names(codes.lut)
      names(st_db13_taxaonly) <- names(codes.lut)

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

      st_db13_html <- .do_HTML_postprocess(st_db13)
      # st_db12_unique <- .do_HTML_postprocess(st_db12_unique)
      st_db13_taxaonly <- .do_HTML_postprocess(st_db13_taxaonly)
      st_db13_preceding <- preceding_taxon_ID(codes.lut)

      # go back to codes for output
      names(st_db13) <- codes.lut
      names(st_db13_html) <- codes.lut
      names(st_db13_unique) <- codes.lut
      names(st_db13_taxaonly) <- codes.lut
      names(st_db13_preceding) <- codes.lut

      # remove front matter (alfisols example) if present
      if (names(st_db13[1]) == "*") {
        st_db13[[1]] <- NULL
        st_db13_unique[[1]] <- NULL
        st_db13_html[[1]] <- NULL
        st_db13_taxaonly[[1]] <- NULL
        st_db13_preceding[[1]] <- NULL
        codes.lut <- codes.lut[2:length(codes.lut)]
        oi <- c(2:10, 1, 11:length(codes.lut))
        codes.lut <- codes.lut[oi]
        taxa.lut <- names(codes.lut)
        names(taxa.lut) <- codes.lut
        st_db13 <- st_db13[oi]
        st_db13_unique <- st_db13_unique[oi]
        st_db13_html <- st_db13_html[oi]
        st_db13_taxaonly <- st_db13_taxaonly[oi]
        st_db13_preceding <- st_db13_preceding[oi]
      } 

      save(st_db13,
           st_db13_unique,
           st_db13_html,
           st_db13_preceding,
           taxa.lut,
           codes.lut,
           file = sprintf("./inst/extdata/KST/2022_KST_db_%s.Rda", language))

      write(convert_to_json(st_db13),
            file = sprintf("./inst/extdata/KST/2022_KST_criteria_%s.json", language))
      write(convert_to_json(st_db13_unique),
            file = sprintf("./inst/extdata/KST/2022_KST_criteria_%s.json", language))

      # this binary file does not get version-controlled: ~15MB as json, ~1MB as rda
      save(st_db13_html, file = sprintf("./inst/extdata/KST/2022_KST_HTML_%s.rda", language))

      # can be readily calculated with ncss-tech/SoilTaxonomy package
      # write(convert_to_json(st_db13_preceding),
      #      file = sprintf("./inst/extdata/KST/2022_KST_preceding_%s.json", language))
      if (language == "EN") {
        code_lut <- data.frame(code = as.character(codes.lut),
                               name = names(codes.lut))

        write(convert_to_json(code_lut), file = "./inst/extdata/KST/2022_KST_codes.json")
      }
    }
  })

  if (inherits(attempt, 'try-error'))
    return(FALSE)

  message("Done!")
  return(TRUE)
}
