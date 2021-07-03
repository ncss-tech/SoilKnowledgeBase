library(jsonlite)
library(stringi)

# this is a data.frame containing raw definitions content from NSSH 629A section 2
defs <- read_json("inst/extdata/NSSH/629/629A.json", simplifyVector = TRUE)$`629.2`

# ## sources
# # copy / paste into notepad++
# # remove blank lines
# # normalize separators

# TODO: build this from 629A.json

srcx <- read.table('misc/GDS/sources.txt', sep = '\t', header = FALSE, stringsAsFactors = FALSE)

# column names
names(srcx) <- c('code', 'citation')

# re-format into a named list
sources <- lapply(1:nrow(srcx), function(x) {
  srcx[x, ]$citation
})
names(sources) <- srcx$code

# convert to reasonable JSON
toJSON(sources[1], pretty = TRUE, auto_unbox = TRUE)

# save to file
write_json(sources, path = 'misc/GDS/json/sources.json', pretty = TRUE, auto_unbox = TRUE)


# ## glossary
# # copy / paste into notepad++
# # remove blank lines
# # replaced 2 instances of wrong dash "–" (top-level delimeter)
# #
# x <- readLines('glossary.txt', encoding = 'UTF-8')
#
# # split into two parts using '–' character, will have trim whitespace
# x.split <- stri_split_fixed(x, pattern = '–', n = 2, simplify = TRUE)
#
# # work on terms
# terms <- x.split[, 1]
# # trim whitespace
# terms <- stri_trim_right(terms)
#
# # work on definitions
# defs <- x.split[, 2]
# # trim whitespace
# defs <- stri_trim_both(defs)


# init glossary list
start.idx <- grep("^[A-Z]\\. Glossary$", defs$content) + 1
defcontent <- defs$content[start.idx:nrow(defs)]

gloss <- lapply(defcontent, function(i) {

  ## compound definitions are delimited using the following
  # a) b) c) ...
  # (a) (b) (c) ...
  # (i) (ii) (iii) ...

  # is i a compound definition?
  cmplx.pattern <- ' \\(?[a-g]\\) | \\(i+\\) '
  cmplx <- stri_detect_regex(i, pattern = cmplx.pattern)

  if(cmplx) {
    # split on compound definition markers
    i.list <- stri_split_regex(i, pattern = cmplx.pattern)[[1]]
    # trim
    i.list <- lapply(i.list, stri_trim_both)
    # remove the first empty element
    if (i.list[[1]] == "")
      i.list <- i.list[-1]
    else
      i.list <- lapply(i.list[2:length(i.list)], function(x) paste(i.list[[1]], "—",x))
  } else {
    # convert definition to a list
    i.list <- as.list(i)
  }

  # iterate over definitions:
  # search / remove from right -> left of string
  #  -> sources
  #  -> comparisons
  i.list <- lapply(i.list, function(j) {

    # find sources
    s <- stri_extract_all_fixed(j, pattern = names(sources), simplify = TRUE)

    # convert matrix -> vector -> drop NA -> drop attr
    s <- as.vector(na.omit(as.vector(s)))

    # remove the sources if possible
    # note that there may be a trailing "." if this source is listed as part of a complex def
    s.txt <- stri_extract_all_regex(j, pattern = '(\\.[^.]*\\.?)$', simplify = TRUE)
    s.txt <- as.vector(s.txt)

    # if found, replace with a period (search includes trailing period)
    if(! is.na(s.txt)){
      j <- gsub(j, pattern = s.txt, replacement = '.', fixed = TRUE)
    }

    # if there are no sources found, then keep track of this via NA
    if(length(s) < 1) {
      s <- NA
    }

    # search for comparisons
    comp <- stri_extract_all_regex(j, pattern = 'Compare.*\\.', simplify = TRUE)
    comp <- as.vector(comp)

    # remove comparison text if found
    if(!is.na(comp)) {
      # replace with empty string
      j <- gsub(j, pattern = comp, replacement = '', fixed = TRUE)
      # clean white space
      j <- stri_trim_both(j)
    } else {
      comp <- NA_character_
    }

    h <- strsplit(gsub("\\(\\d+\\) (.*).[—\\(](.*)", "\\1:\\2", j), ":")[[1]]

    # pack into a list
    final <- list(
      term = h[1],
      text = h[2],
      compare = gsub("[\\.]","", trimws(strsplit(trimws(strsplit(comp, "–")[[1]])[2], ",")[[1]])),
      sources = s
    )


    return(final)
  })


  ## TODO: make sure this is robust

  # check to see if there is a single source record, if so copy to all records
  all.sources <- lapply(i.list, '[[', 'sources')

  # find records missing sources
  # sources can be vectors, hence the complexity here
  missing.sources <- which(sapply(all.sources, function(z) {all(is.na(z)) }))

  if(length(missing.sources) > 0) {

    # replace with "last" source
    for(z in missing.sources) {
      i.list[[z]]$sources <- all.sources[[length(all.sources)]]
    }
  }

  # pack into a list
  res <- list(
    def = i.list
  )

  return(res)
})


# terms are list element names
names(gloss) <- terms

# check: ok
toJSON(gloss[1:5], pretty = TRUE, auto_unbox = TRUE)

# split into letters of the alphabet
gloss.split <- split(gloss, substr(terms, 1, 1))

for(letter in letters){
  # current letter / index
  txt <- gloss.split[[letter]]
  # filename
  f <- sprintf('json/glossary-%s.json', letter)
  # save
  write_json(txt, path = f, pretty = TRUE, auto_unbox = TRUE)
}




