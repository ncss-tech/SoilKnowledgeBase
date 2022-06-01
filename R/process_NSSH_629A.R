#' @importFrom jsonlite read_json write_json
#' @importFrom stringi stri_split_regex stri_detect_regex stri_extract_all_fixed stri_trim_both
#' @importFrom stats na.omit
process_NSSH_629A <- function(outpath = "./inst/extdata") {

  # this is a data.frame containing raw definitions content from NSSH 629A section 2
  part629a <- jsonlite::read_json(file.path(outpath, "NSSH/629/629A.json"), simplifyVector = TRUE)

  # part1 <-  part629a$`629.1`
  defs <- part629a$`629.2`
  # references <- part629a$`629.3`

  sources.idx <- grep("^[A-Z]\\. Reference Codes Sources", defs$content)
  comments.idx <- grep("^[A-Z]\\. Clarifying Comments Included With Glossary Definitions$", defs$content) + 1
  glossary.idx <- grep("^[A-Z]\\. Glossary$", defs$content) + 1

  # ## reference source codes

  # build from 629A.json
  refcodes <- strsplit(paste(defs$content[sources.idx:comments.idx], collapse = " "), " \\([ivx]+\\) ")
  srcx <- strsplit(refcodes[[1]][2:length(refcodes[[1]])], ".\\-")

  sources <- as.list(sapply(srcx, function(x) paste0(x[2:length(x)], collapse = "")))
  names(sources) <- sapply(srcx, function(x) x[1])

  # converts to reasonable JSON
  # toJSON(sources[1], pretty = TRUE, auto_unbox = TRUE)

  # save to file
  jsonlite::write_json(sources, path = file.path(outpath, "NSSH/629/sources.json"), pretty = TRUE, auto_unbox = TRUE)

  # init glossary list
  defcontent <- defs$content[glossary.idx:nrow(defs)]

  ## patches

  gloss <- lapply(defcontent, function(i) {

    ## compound definitions are delimited using the following
    # a) b) c) ...
    # (a) (b) (c) ...
    # (i) (ii) (iii) ...

    # is i a compound definition?
    cmplx.pattern <- ' \\(?[a-g]\\) | \\(i+\\) '
    cmplx <- stringi::stri_detect_regex(i, pattern = cmplx.pattern)

    if (cmplx) {
      # split on compound definition markers
      i.list <- stringi::stri_split_regex(i, pattern = cmplx.pattern)[[1]]
      # trim
      i.list <- lapply(i.list, stringi::stri_trim_both)
      # remove the first empty element
      if (i.list[[1]] == "") {
        i.list <- i.list[-1]
      } else {
        i.list <- lapply(i.list[2:length(i.list)], function(x) paste0(i.list[[1]], ".-", x))
      }
    } else {
      # convert definition to a list
      i.list <- as.list(i)
    }

    # iterate over definitions:
    # search / remove from right -> left of string
    #  -> sources
    #  -> comparisons
    #  -> obsolete and other comments
    i.list <- lapply(i.list, function(j) {

      # find sources
      s <- stringi::stri_extract_all_fixed(j, pattern = names(sources), simplify = TRUE)

      # convert matrix -> vector -> drop NA -> drop attr
      s <- unique(as.vector(na.omit(as.vector(s))))
      s <- s[nchar(s) > 0]

      # remove the sources if possible
      # note that there may be a trailing "." if this source is listed as part of a complex def
      s.txt <- stringi::stri_extract_all_regex(j, pattern = '(\\.[^.,\u2014\\-)]*\\.?)$', simplify = TRUE)
      s.txt <- as.vector(s.txt)

      # if found, replace with a period (search includes trailing period)
      if (!is.na(s.txt)) {
        j <- gsub(j, pattern = s.txt, replacement = '.', fixed = TRUE)
      }

      # if there are no sources found, then keep track of this via NA
      if (length(s) < 1) {
        s <- NA
      }

      # search for comparisons
      comp <- stringi::stri_extract_all_regex(j, pattern = 'Compare.*\\.', simplify = TRUE)
      comp <- as.vector(comp)

      # remove comparison text if found
      if (!is.na(comp)) {
        # replace with empty string
        j <- gsub(j, pattern = comp, replacement = '', fixed = TRUE)
        # clean white space
        j <- stringi::stri_trim_both(j)
      } else {
        comp <- NA_character_
      }

      # search for obsolete, not preferred
      if (length(grep("\\(obsolete - use|\\(not recommended|\\(not preferred|; not preferred", j) > 0)) {
        obspattern <- '.*obsolete - use ([A-Za-z, ]+).*|.*\\(not recommended: obsolete\\) Use ([^\\.]*).?$|.*\\(not recommended\\) Use ([^\\.]*).?$|.*\\(not preferred\\) Use ([^\\.]*).?$|.*[\\(;\\u2013\\-] ?not preferred.*[Rr]efer to ([^\\.\\)]*).?.*|.*\\(not recommended, use ([^\\.]*)\\).*'

        obsolete <- grepl("obsolete", j)
        newterms <- trimws(strsplit(gsub(obspattern, "\\1\\2\\3\\4\\5\\6", j), ",|, or")[[1]])
        if (length(grep(obspattern, j)) == 0)
          newterms <- character(0)
      } else newterms <- character(0)

      # search for colloquial
      if (length(grep("\\(colloquial:", j) > 0)) {
        coldesc <- trimws(strsplit(gsub('.*colloquial:([A-Za-z\\., ]+)[\\);\\u2013].*', "\\1", j), ",|, or")[[1]])
      } else coldesc <- character(0)

      h <- trimws(strsplit(gsub("\\(\\d+\\) ([^\\(\\)]*)\\.[\\-](.*)", "\\1::::\\2", j), "::::")[[1]])

      # pack into a list
      final <- list(
        term = h[1],
        text = h[2],
        compare = gsub("[\\.]","", trimws(strsplit(trimws(strsplit(comp, "-", fixed = TRUE)[[1]])[2], ",")[[1]])),
        sources = s,
        colloquial = length(coldesc) > 0,
        colloquloc = coldesc,
        obsolete = length(newterms) > 0,
        preferred = newterms
      )


      return(final)
    })

    ## TODO: make sure this is robust

    # check to see if there is a single source record, if so copy to all records
    all.sources <- lapply(i.list, '[[', 'sources')

    # find records missing sources
    # sources can be vectors, hence the complexity here
    missing.sources <- which(sapply(all.sources, function(z) {all(is.na(z)) }))

    if (length(missing.sources) > 0) {

      # replace with "last" source
      for (z in missing.sources) {
        i.list[[z]]$sources <- all.sources[[length(all.sources)]]
      }
    }

    return(i.list)
  })

  # split into letters of the alphabet
  gloss.split <- split(gloss, toupper(substr(sapply(gloss, function(x) x[[1]]$term), 1, 1)))

  for (letter in LETTERS) {
    # current letter / index
    txt <- gloss.split[[letter]]

    # filename
    f <- sprintf('inst/extdata/NSSH/629/GDS-glossary-%s.json', letter)

    # save
    jsonlite::write_json(txt, path = f, pretty = TRUE, auto_unbox = TRUE)
  }
}


