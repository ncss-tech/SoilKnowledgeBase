



#   # get rendered HTML->text and save to file
#   # store gzip-compressd OSD for bulk INSERT
#   res[['fulltext']] <- memCompress(.ConvertToFullTextRecord(i, i.lines), type='gzip')
#
#   ## previously:
#   # cat(i.fulltext, file = 'fulltext-data.sql', append = TRUE)
#
#   # split data into sections for fulltext search, catch errors related to parsing sections
#   i.sections <- try(.ConvertToFullTextRecord2(i, i.lines))
#   if(class(i.sections) != 'try-error') {
#
#     # store gzip-compressed sections for bulk INSERT
#     res[['sections']] <- memCompress(i.sections, type='gzip')
#
#     ## previously:
#     # cat(i.sections, file = 'fulltext-section-data.sql', append = TRUE)




# # re-make entire fulltext table, containing an OSD per record
.makeFullTextTable <- function(fullTextList, outputFile='fulltext-data.sql') {
  # reset fulltext SQL file
  cat('DROP TABLE osd.osd_fulltext;\n', file = outputFile)
  cat('CREATE TABLE osd.osd_fulltext (series citext, fulltext text);\n',
      file = outputFile, append = TRUE)
  cat("set client_encoding to 'latin1' ;\n", file = outputFile, append = TRUE)
  
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


# # re-make sectioned fulltext table, containing an OSD per record
.makeFullTextSectionsTable <- function(fullTextList, outputFile='fulltext-section-data.sql') {
  
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
  cat("set client_encoding to 'latin1' ;\n", file = 'fulltext-section-data.sql', append = TRUE)
  
  # remove NULL elements
  idx <- which(!sapply(fullTextList, is.null))
  fullTextList <- fullTextList[idx]
  
  # iterate over list elements and write to file
  # source text is gzip compressed
  n <- lapply(fullTextList, function(i) {
    # decompress text on the fly
    txt <- memDecompress(i, type = 'gzip', asChar = TRUE)
    cat(txt, file = outputFile, append = TRUE)
  })
}


# # convert HTML text to fulltext DB table record
.ConvertToFullTextRecord <- function(s, s.lines, tablename='osd.osd_fulltext') {
  # collapse to single chunk
  s.text <- paste(s.lines, collapse = '\n')
  # convert into INSERT statement
  # note: single quotes escaped with $$:
  # http://stackoverflow.com/questions/12316953/insert-varchar-with-single-quotes-in-postgresql
  res <- paste0('INSERT INTO ', tablename, " VALUES ($$", s, "$$,$$", s.text, "$$);\n")
  return(res)
}

# # convert HTML text to an insert statement with data split by section
.ConvertToFullTextRecord2 <- function(s, s.lines, tablename='osd.osd_fulltext2') {
  # TODO: convert to use SKB sections
  # split sections to list, section titles hard-coded
  sections <- .extractSections(s.lines)
  
  # get names of all sections
  st <- names(.sectionData)
  
  # combine sections with $$ quoting
  blob <- sapply(st, function(i) {
    paste0('$$', sections[[i]], '$$')
  })
  res <- paste0('INSERT INTO ', tablename,  ' VALUES ( $$',
                s, '$$, ', paste(blob, collapse = ', '), ');\n')
  return(res)
}

