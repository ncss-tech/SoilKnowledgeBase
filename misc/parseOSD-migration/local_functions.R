### moved all OSD HTML|TXT file getting / prep to soilDB


####### fulltext search support ###################

# re-make entire fulltext table, containing an OSD per record
makeFullTextTable <- function(fullTextList, outputFile='fulltext-data.sql') {
  # reset fulltext SQL file
  cat('DROP TABLE osd.osd_fulltext;\n', file=outputFile)
  cat('CREATE TABLE osd.osd_fulltext (series citext, fulltext text);\n', file=outputFile, append = TRUE)
  cat("set client_encoding to 'latin1' ;\n", file=outputFile, append = TRUE)
  
  # remove NULL elements
  idx <- which(! sapply(fullTextList, is.null))
  fullTextList <- fullTextList[idx]
  
  # iterate over list elements and write to file
  # source text is gzip compressed
  n <- lapply(fullTextList, function(i) {
    # decompress text on the fly
    txt <- memDecompress(i, type = 'gzip', asChar = TRUE)
    cat(txt, file = outputFile, append = TRUE)
  })
}


# re-make sectioned fulltext table, containing an OSD per record
makeFullTextSectionsTable <- function(fullTextList, outputFile='fulltext-section-data.sql') {
  
  # reset fulltext SQL file
  # need to adjust fields manually as we edit
  cat('DROP TABLE osd.osd_fulltext2;\n', file='fulltext-section-data.sql')
  cat('CREATE TABLE osd.osd_fulltext2 (
series citext,
brief_narrative text,
taxonomic_class text,
typical_pedon text,
type_location text,
ric text,
competing_series text,
geog_location text,
geog_assoc_soils text,
drainage text,
use_and_veg text,
distribution text,
remarks text,
established text,
additional_data text
    );\n', file='fulltext-section-data.sql', append = TRUE)
  cat("set client_encoding to 'latin1' ;\n", file='fulltext-section-data.sql', append = TRUE)
  
  # remove NULL elements
  idx <- which(! sapply(fullTextList, is.null))
  fullTextList <- fullTextList[idx]
  
  # iterate over list elements and write to file
  # source text is gzip compressed
  n <- lapply(fullTextList, function(i) {
    # decompress text on the fly
    txt <- memDecompress(i, type = 'gzip', asChar = TRUE)
    cat(txt, file = outputFile, append = TRUE)
  })
}




# convert HTML text to fulltext DB table record
ConvertToFullTextRecord <- function(s, s.lines, tablename='osd.osd_fulltext') {
  # collapse to single chunk
  s.text <- paste(s.lines, collapse = '\n')
  # convert into INSERT statement
  # note: single quotes escaped with $$:
  # http://stackoverflow.com/questions/12316953/insert-varchar-with-single-quotes-in-postgresql
  res <- paste0('INSERT INTO ', tablename, " VALUES ($$", s, "$$,$$", s.text, "$$);\n")
  return(res)
}


# convert HTML text to an insert statement with data split by section
ConvertToFullTextRecord2 <- function(s, s.lines, tablename='osd.osd_fulltext2') {
  # split sections to list, section titles hard-coded
  sections <- extractSections(s.lines)
  
  # get names of all sections
  st <- names(.sectionData)
  
  # combine sections with $$ quoting
  blob <- sapply(st, function(i) {paste0('$$', sections[[i]], '$$')})
  res <- paste0('INSERT INTO ', tablename,  ' VALUES ( $$', s, '$$, ', paste(blob, collapse = ', '), ');\n')
  return(res)
}


####### fulltext search support ###################





downloadParseSave <- function(i) {
  
  # get OSD from WWW pages / HTML parsing
  # result is a list
  # i.lines <- try(soilDB:::.getLiveOSD(i), silent = TRUE)
  
  # get from local OSDRegistry repository
  # result is a list
  i.lines <- try(
    soilDB:::.getLocalOSD(i, path = 'E:/working_copies/OSDRegistry/OSD'),
    silent = TRUE
  )
  
  # no OSD...
  if(class(i.lines) == 'try-error')
    return(FALSE)
  
  # output as list
  res <- list()
  
  # register section REGEX
  # this sets / updates a global variable
  setSectionREGEX(i)
  
  # get rendered HTML->text and save to file 
  # store gzip-compressd OSD for bulk INSERT
  res[['fulltext']] <- memCompress(ConvertToFullTextRecord(i, i.lines), type='gzip')
  
  ## previously:
  # cat(i.fulltext, file = 'fulltext-data.sql', append = TRUE)
  
  # split data into sections for fulltext search, catch errors related to parsing sections
  i.sections <- try(ConvertToFullTextRecord2(i, i.lines))
  if(class(i.sections) != 'try-error') {
    
    # store gzip-compressed sections for bulk INSERT
    res[['sections']] <- memCompress(i.sections, type='gzip')
    
    ## previously:
    # cat(i.sections, file = 'fulltext-section-data.sql', append = TRUE)
  }
  
  
  # append hz data to our list, catch errors related to parsing sections
  hz.data <- try(extractHzData(i.lines), silent = TRUE)
  
  # append site data to our list, catch errors related to parsing sections
  section.data <- try(extractSections(i.lines), silent = TRUE)
  site.data <- try(extractSiteData(section.data), silent = TRUE)
  
  # append if result was a data.frame
  if(class(hz.data) == 'data.frame') {
    # add seriesname to final column
    hz.data$seriesname <- i
    res[['hz']] <- hz.data
  }
  
  # append if result was a data.frame
  if(class(site.data) == 'data.frame') {
    # add seriesname to final column
    site.data$seriesname <- i
    res[['site']] <- site.data
  }
  
  return(res)
}

# use this approach to make the wrapper "safe"
downloadParseSave.safe <- purrr::safely(downloadParseSave)



testIt <- function(x) {
  # get data
  res <- soilDB:::.getLiveOSD(x)
  
  # init section REGEX: critical for locating brief narrative
  setSectionREGEX(x)
  
  # extract sections
  l <- list()
  l[['sections']] <- extractSections(res)
  l[['section-indices']] <- findSectionIndices(res)
  l[['site-data']] <- extractSiteData(l[['sections']])
  l[['hz-data']] <- extractHzData(res)
  
  return(l)
}

testItLocal <- function(x, path = 'E:/working_copies/OSDRegistry/OSD') {
  # get data
  res <- soilDB:::.getLocalOSD(x, path)
  
  # init section REGEX: critical for locating brief narrative
  setSectionREGEX(x)
  
  # extract sections
  l <- list()
  l[['sections']] <- extractSections(res)
  l[['section-indices']] <- findSectionIndices(res)
  l[['site-data']] <- extractSiteData(l[['sections']])
  l[['hz-data']] <- extractHzData(res)
  
  return(l)
}


## safely (efficiently?) find specific classes within a vector of narratives
# needle: class labels
# haystack: narrative by horizon
findClass <- function(needle, haystack) {
  # iterate over vector of horizon narratives, searching for exact matches
  test.by.hz <- lapply(haystack, stri_detect_fixed, pattern = needle, opts_fixed = list(case_insensitive=TRUE))
  
  # iterate over search results by horizon, keeping names of matching classes 
  matches <- lapply(test.by.hz, function(i) {
    needle[i]
  })
  
  # compute number of characters: longer matches are the most specific / correct
  res <- map_chr(matches, function(i) {
    
    # find the longest matching string
    idx <- which.max(nchar(i))
    
    # extract it
    m <- i[idx]
    
    # convert _nothing_ into NA
    if(length(m) > 0) {
      return(m)
    } else {
      return(NA)
    }
    
  })
  
  return(res)
}


# vectorized parsing of texture class from OSD
parse_texture <- function(text) {
  # mineral texture classes, sorted from coarse -> fine
  textures <- c('coarse sand', 'sand', 'fine sand', 'very fine sand', 'loamy coarse sand', 'loamy sand', 'loamy fine sand', 'loamy very fine sand', 'coarse sandy loam', 'sandy loam', 'fine sandy loam', 'very fine sandy loam', 'loam', 'silt loam', 'silt', 'sandy clay loam', 'clay loam', 'silty clay loam', 'sandy clay', 'silty clay', 'clay')
  
  ## TODO: this is too greedy as 'fine sand' will be found _within_ 'fine sandy loam'
  # https://github.com/dylanbeaudette/parse-osd/issues/10
  
  # combine into capturing REGEX
  # texture.regex <- paste0('(', paste(textures, collapse='|'), ')')
  # 
  # # get matches
  # m <- stri_match(text, regex = texture.regex, mode='first', opts_regex=list(case_insensitive=TRUE))
  # 
  # # fail gracefully in the case of no section data or no matches
  # if(nrow(m) < 1)
  #   return(NA)
  # 
  # # keep only matches and convert to lower case
  # m <- tolower(m[, 2])
  
  ## 2019-05-29: generalized for all non-greedy, exact matching
  m <- findClass(needle=textures, haystack=text)
  m <- tolower(m)
  
  # convert to ordered factor
  m <- factor(m, levels=textures, ordered = TRUE)
  
  return(m)
}

# vectorized parsing of horizon boundary
parse_hz_boundary <- function(text) {
  
  distinctness <- c('very abrupt', 'abrupt', 'clear', 'gradual', 'diffuse')
  topography <- c('smooth', 'wavy', 'irregular', 'broken')
  bdy <- apply(expand.grid(distinctness, topography), 1, paste, collapse=' ')
  
  
  ## TODO: this is too greedy ?
  # https://github.com/dylanbeaudette/parse-osd/issues/10
  
  # combine into capturing REGEX
  bdy.regex <- paste0('(', paste(bdy, collapse='|'), ') boundary')
  
  # get matches
  m <- stri_match(text, regex = bdy.regex, mode='first', opts_regex=list(case_insensitive=TRUE))
  
  # fail gracefully in the case of no section data or no matches
  if(nrow(m) < 1)
    return(NA)
  
  # keep only matches and convert to lower case
  m <- tolower(m[, 2])
  
  # split into pieces
  res <- data.frame(
    distinctness = findClass(needle=distinctness, haystack=m),
    topography = findClass(needle=topography, haystack=m),
    stringsAsFactors = FALSE
  )
  
  return(res)
}

# vectorized parsing of coarse fraction qty+class from OSD
parse_CF <- function(text) {
  cf.type <- c('gravelly', 'cobbly', 'stony', 'bouldery', 'channery', 'flaggy')
  cf.qty <- c('', 'very ', 'extremely ')
  cf <- apply(expand.grid(cf.qty, cf.type), 1, paste, collapse='')
  
  
  ## TODO: this is too greedy as 'fine sand' will be found _within_ 'fine sandy loam'
  # https://github.com/dylanbeaudette/parse-osd/issues/10
  
  # combine into capturing REGEX
  cf.regex <- paste0('(', paste(cf, collapse='|'), ')')
  
  # get matches
  m <- stri_match(text, regex = cf.regex, mode='first', opts_regex=list(case_insensitive=TRUE))
  
  # fail gracefully in the case of no section data or no matches
  if(nrow(m) < 1)
    return(NA)
  
  # keep only matches and convert to lower case
  m <- tolower(m[, 2])
  
  return(m)
}

# vectorized parsing of pH
parse_pH <- function(text) {
  
  # combine into capturing REGEX
  ph.regex <- '\\(ph\\s?([0-9]\\.[0-9])\\)'
  
  # get matches
  m <- stri_match(text, regex = ph.regex, mode='first', opts_regex=list(case_insensitive=TRUE))
  
  # fail gracefully in the case of no section data or no matches
  if(nrow(m) < 1)
    return(NA)
  
  # keep only matches
  m <- as.numeric(m[, 2])
  
  return(m)
}


# vectorized parsing of pH class
parse_pH_class <- function(text) {
  
  # mineral texture classes
  pH_classes <- c('ultra acid', 'extremely acid', 'very strongly acid', 'strongly acid', 'moderately acid', 'slightly acid', 'neutral', 'slightly alkaline', 'mildly alkaline', 'moderately alkaline', 'strongly alkaline', 'very strongly alkaline')
  
  ## 2019-05-29: generalized for all non-greedy, exact matching
  m <- findClass(needle=pH_classes, haystack=text)
  m <- tolower(m)
  
  # return as an ordered factor acidic -> basic
  m <- factor(m, levels=pH_classes, ordered = TRUE)
  
  return(m)
}


# vectorized parsing of drainage class
parse_drainage_class <- function(text) {
  
  # drainage classes, in order, lower case
  classes <- c("excessively", "somewhat excessively", "well", "moderately well", 
                        "somewhat poorly", "poorly", "very poorly", "subaqueous")
  
  ## TODO: this is too greedy as 'fine sand' will be found _within_ 'fine sandy loam'
  # https://github.com/dylanbeaudette/parse-osd/issues/10
  
  
  # combine into capturing REGEX
  classes.regex <- paste0('(', paste(classes, collapse='|'), ')')
  
  # get matches
  m <- stri_match(text, regex = classes.regex, mode='first', opts_regex=list(case_insensitive=TRUE))
  
  # fail gracefully in the case of no section data or no matches
  if(nrow(m) < 1)
    return(NA)
  
  # keep only matches and convert to lower case
  m <- tolower(m[, 2])
  
  # return as an ordered factor acidic -> basic
  m <- factor(m, levels=classes, ordered = TRUE)
  
  return(m)
}



### TODO: test / move into aqp ###


## this has to be done before any extraction is possible
# init the section names and REGEX search paterns
# the current series name is required for the top-most section
setSectionREGEX <- function(s) {
  ## temporary hack: storing as a global variable
  # values are REGEX that try to accommodate typos
  # names are the proper section names
  
  ## TODO:
  # consider anchoring all to left-side + optional white-space
  # "TYPICAL PEDON" REGEX is too greedy
  # "BRIEF DESCRIPTION" has date in front of "XXX SERIES" due to HTML formatting
  # date is absent in  OSDRegistry (local text file) interface
  .sectionData <<- c('BRIEF DESCRIPTION' = paste0('^([0-9/]+)?', toupper(s), ' SERIES\\s?$'),
                     'TAXONOMIC CLASS' = '^\\s*TAXONOMIC CLASS[:]? ',
                     'TYPICAL PEDON'='^\\s*TYP.*\\sPEDON[:|-|;]?\\s?',
                     'TYPE LOCATION'='^\\s*TYPE\\sLOCATION[:]?\\s?',
                     'RANGE IN CHARACTERISTICS'='^\\s*RANGE IN CHARACTERISTICS[:]? ',
                     'COMPETING SERIES'='^\\s*COMPETING SERIES[:]? ',
                     'GEOGRAPHIC SETTING'='^\\s*GEOGRAPHIC SETTING[:]? ',
                     'GEOGRAPHICALLY ASSOCIATED SOILS'='^\\s*GEOGRAPHICALLY ASSOCIATED SOILS[:]? ',
                     'DRAINAGE AND PERMEABILITY'='^\\s*DRAINAGE AND (PERMEABILITY)|(HYDRAULIC CONDUCTIVITY)[:]? ',
                     'USE AND VEGETATION'='^\\s*USE AND VEGETATION[:]? ',
                     'DISTRIBUTION AND EXTENT'='^\\s*DISTRIBUTION AND EXTENT[:]? ',
                     'REMARKS'='^\\s?REMARKS[:]? ',
                     'SERIES ESTABLISHED'='^\\s*SERIES ESTABLISHED[:]? ',
                     'ADDITIONAL DATA'='^\\s*ADDITIONAL DATA[:]? '
  )
  
}





# locate section line numbers
findSectionIndices <- function(chunk.lines) {
  # result is a list, sometimes a section REGEX will match multiple lines
  s <- lapply(.sectionData, function(st) grep(st, chunk.lines, ignore.case = TRUE))
  
  # filter out sections with no matches
  match.idx <- which(sapply(s, function(i) length(i) > 0))
  s <- s[match.idx]
  
  # keep the first match
  indices <- sapply(s, function(i) i[1])
  
  # get set of section names with parsed data
  section.names <- names(indices)
  
  return(indices)
}

# extract sections from lines of OSD
extractSections <- function(chunk.lines, collapseLines=TRUE) {
  # storage
  l <- list()
  
  # locate section lines
  # note: this will give values inclusive of the next section
  section.locations <- findSectionIndices(chunk.lines)
  section.names <- names(section.locations)
    
  # combine chunks into a list
  for(i in 1:(length(section.locations) - 1)) {
    
    # current name and landmarks
    this.name <- section.names[i]
    start.line <- section.locations[i]
    
    # this stop line overlaps with the start of the next, decrease index by 1
    stop.line <- section.locations[i+1] - 1
    
    # extract current chunk
    chunk <- chunk.lines[start.line : stop.line]
    
    # special case #1: the brief narrative is split over two lines; first line is junk
    if(this.name == 'BRIEF DESCRIPTION' & length(chunk) > 1) {
      # attempt to remove when possible
      chunk <- chunk[-1]
    }
    
    # optionally combine lines
    if(collapseLines)
      chunk <- paste(chunk, collapse='')
    
    # attempt to remove section name
    chunk <- gsub(this.name, '', chunk)
    
    # store
    l[[this.name]] <- chunk
  }
  
  return(l)
}






# parse important pieces from sections
# x: list of section chunks
extractSiteData <- function(x) {
  
  ## drainage class
  
  # this work for standard OSD format
  drainage.class <- parse_drainage_class(x[['DRAINAGE AND PERMEABILITY']])
  
  # alternative for SSR1 updated OSD format
  # https://casoilresource.lawr.ucdavis.edu/sde/?series=bordengulch
  if(is.na(drainage.class)) {
    drainage.class <- parse_drainage_class(x[['BRIEF DESCRIPTION']])
  }
  
  
  ## other things?
  
  
  # composite into a list for later
  r <- data.frame(drainage=drainage.class)
  return(r)
}


# s.lines: result of getOSD()
extractHzData <- function(s.lines) {
  options(stringsAsFactors=FALSE)
  
  ## TODO: this is kind of wasteful
  # this will not work in the presence of typos
  # new code for splitting blocks by section, lines from each section are not joined
  sections <- extractSections(s.lines, collapseLines = FALSE)
  tp <- sections[['TYPICAL PEDON']] 
  
  ## REGEX rules
  # http://regexr.com/
  ## TODO: combine top+bottom with top only rules
  # TODO: allow for OCR errors:
  #       "O" = "0"
  #       "l" = "1"
  ## ideas: http://stackoverflow.com/questions/15474741/python-regex-optional-capture-group
  # detect horizons with both top and bottom depths
  # hz.rule <- "^\\s*?([\\^\\'\\/a-zA-Z0-9]+)\\s?-+?\\s?([O0-9.]+)\\s+?to\\s+?([O0-9.]+)\\s+?(in|inches|cm|centimeters)"
  hz.rule <- "([\\^\\'\\/a-zA-Z0-9]+)\\s*-+\\s*([O0-9.]+)\\s*?to\\s+?([O0-9.]+)\\s+?(in|inches|cm|centimeters)"
  
  # detect horizons with no bottom depth
  hz.rule.no.bottom <- "([\\^\\'\\/a-zA-Z0-9]+)\\s*-+?\\s*([0-9.]+)\\s+?(in|inches|cm|centimeters)"
  
  
  ## TODO: this doesn't work when only moist colors are specified (http://casoilresource.lawr.ucdavis.edu/sde/?series=canarsie)
  ## TODO: these rules will not match neutral colors: N 2.5/
  ## TODO: toggle dry/moist assumption:
  ##
  ## Colors are for dry soil unless otherwise stated | Colors are for moist soil unless otherwise stated
  ## 
  ## E1--7 to 12 inches; very dark gray (10YR 3/1) silt loam, 50 percent gray (10YR 5/1) and 50 percent gray (10YR 6/1) dry; moderate thin platy structure parting to weak thin platy; friable, soft; common fine and medium roots throughout; common fine tubular pores; few fine distinct dark yellowish brown (10YR 4/6) friable masses of iron accumulations with sharp boundaries on faces of peds; strongly acid; clear wavy boundary.
  
  ##   A--0 to 6 inches; light gray (10YR 7/2) loam, dark grayish brown (10YR 4/2) moist; moderate coarse subangular blocky structure; slightly hard, friable, slightly sticky and slightly plastic; many very fine roots; many very fine and few fine tubular and many very fine interstitial pores; 10 percent pebbles; strongly acid (pH 5.1); clear wavy boundary. (1 to 8 inches thick)
  ##
  
  ## TODO: test this
  # establist default encoding of colors
  dry.is.default <- length(grep('for dry (soil|conditions)', tp, ignore.case = TRUE)) > 0
  moist.is.default <- length(grep('for moist (soil|conditions)', tp, ignore.case = TRUE)) > 0
  
  if(dry.is.default)
    default.moisture.state <- 'dry'
  if(moist.is.default)
    default.moisture.state <- 'moist'
  
  # if neither are specified assume moist conditions
  if((!dry.is.default & !moist.is.default))
    default.moisture.state <- 'moist'
  
  # if both are specified (?)
  if(dry.is.default & moist.is.default)
    default.moisture.state <- 'unknown'
  
  ## TODO: test this
  # get all colors matching our rule, moist and dry and unknown, 5th column is moisture state
  # interpretation is tough when multiple colors / hz are given
  # single rule, with dry/moist state
  # note that dry/moist may not always be present
  color.rule <- "\\(([0-9]?[\\.]?[0-9]?[B|G|Y|R|N]+)([ ]+?[0-9\\.]+)/([0-9])\\)\\s?(dry|moist|)"
  
  # detect moist and dry colors
  dry.color.rule <- "\\(([0-9]?[\\.]?[0-9]?[B|G|Y|R|N]+)([ ]+?[0-9\\.]+)/([0-9])\\)(?! moist)"
  moist.color.rule <- "\\(([0-9]?[\\.]?[0-9]?[B|G|Y|R|N]+)([ ]+?[0-9\\.]+)/([0-9])\\) moist"
  
  # ID actual lines of horizon information
  hz.idx <- unique(c(grep(hz.rule, tp), grep(hz.rule.no.bottom, tp)))
  
  # init empty lists to store hz data and colors
  hz.data <- list()
  dry.colors <- list()
  moist.colors <- list()
  narrative.data <- list()
  
  # iterate over identified horizons, extracting hz parts
  for(i in seq_along(hz.idx)) {
    this.chunk <- tp[hz.idx[i]]
    
    # parse hz designations and depths, keep first match
    ## hack
    # first try to find horizons with top AND bottom depths
    h <- stri_match(this.chunk, regex=hz.rule)
    # if none, then try searching for only top depths
    if(all(is.na(h))) {
      # this won't have the correct number of elements, adjust manually
      h <- stri_match(this.chunk, regex=hz.rule.no.bottom)
      h <- c(h, h[4]) # move units to 5th element
      h[4] <- NA # add fake missing bottom depth
    }
    
    # save hz data to list
    hz.data[[i]] <- h
    
    # save narrative to list
    narrative.data[[i]] <- this.chunk
    
    ## TODO: test this!
    # parse ALL colors, result is a multi-row matrix, 5th column is moisture state
    colors <- stri_match_all(this.chunk, regex=color.rule)[[1]]
    # replace missing moisture state with (parsed) default value
    colors[, 5][which(colors[, 5] == '')] <- default.moisture.state
    
    # exctract dry|moist colors, note that there may be >1 color per state
    dc <- colors[which(colors[, 5] == 'dry'), 1:4, drop=FALSE]
    mc <- colors[which(colors[, 5] == 'moist'), 1:4, drop=FALSE]
    
    # there there was at least 1 match, keep the first 1
    if(nrow(dc) > 0)
      dry.colors[[i]] <- dc[1, ]
    else
      dry.colors[[i]] <- matrix(rep(NA, times=4), nrow = 1)
    
    if(nrow(mc) > 0)
      moist.colors[[i]] <- mc[1, ]
    else
      moist.colors[[i]] <- matrix(rep(NA, times=4), nrow = 1)
  }
  
  # test for no parsed data, must be some funky formatting...
  if(length(hz.data) == 0)
    return(NULL)
  
  # convert to DF
  hz.data <- ldply(hz.data)[2:5]
  dry.colors <- ldply(dry.colors)[2:4]
  moist.colors <- ldply(moist.colors)[2:4]
  narrative.data <- ldply(narrative.data)
  
  names(hz.data) <- c('name', 'top', 'bottom', 'units')
  names(dry.colors) <- c('dry_hue', 'dry_value', 'dry_chroma')
  names(moist.colors) <- c('moist_hue', 'moist_value', 'moist_chroma')
  names(narrative.data) <- c('narrative')
  
  # cast to proper data types
  hz.data$top <- as.numeric(hz.data$top)
  hz.data$bottom <- as.numeric(hz.data$bottom)
  
  dry.colors$dry_value <- as.numeric(dry.colors$dry_value)
  dry.colors$dry_chroma <- as.numeric(dry.colors$dry_chroma)
  
  moist.colors$moist_value <- as.numeric(moist.colors$moist_value)
  moist.colors$moist_chroma <- as.numeric(moist.colors$moist_chroma)
  
  ## TODO sanity check / unit reporting: this will fail when formatting is inconsistent (PROPER series)
  # convert in -> cm using the first horizon
  if(hz.data$units[1] %in% c('inches', 'in')) {
    hz.data$top <- round(hz.data$top * 2.54)
    hz.data$bottom <- round(hz.data$bottom * 2.54)
  }
  
  # remove units column
  hz.data$units <- NULL
  
  # combine into single DF
  res <- cbind(hz.data, dry.colors, moist.colors)
  
  # parse out other elements from the narrative
  res$texture_class <- parse_texture(narrative.data$narrative)
  res$cf_class <- parse_CF(narrative.data$narrative)
  res$pH <- parse_pH(narrative.data$narrative)
  res$pH_class <- parse_pH_class(narrative.data$narrative)
  
  bdy <- parse_hz_boundary(narrative.data$narrative)
  res$distinctness <- bdy$distinctness
  res$topography <- bdy$topography
  
  # add narrative
  res <- cbind(res, narrative.data)
  
  return(res)
}


