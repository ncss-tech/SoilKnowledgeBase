# draft tabulating latest taxonomy 13th ed changes
# 
library(rvest)

output_dir <- 'misc/KST/2021'

html <- read_html("https://www.nrcs.usda.gov/wps/portal/nrcs/detail/soils/survey/partnership/ncss/?cid=nrcseprd1522014")

html %>%
  html_nodes('ul') %>%
  html_nodes('a') %>%
  SoilKnowledgeBase:::bind_xml_nodeset()

ulnodes <- html %>%
  html_nodes('ul')

# find the links to eDirectives
linknodes <- which(grepl('docx$|pdf$', ulnodes %>% html_node('a') %>% xml_attr('href')))

# proposal links
proposals <- data.frame(
  href = paste0("https://www.nrcs.usda.gov",(ulnodes[linknodes[1]] %>%
                                               html_nodes('a') %>%
                                               SoilKnowledgeBase:::bind_xml_nodeset())$href),
  name = (ulnodes[linknodes[1]] %>%
            html_nodes('a') %>%
            html_text())
)

chapters <- subset(proposals, grepl("Chapter \\d", proposals$name))
chapters$name <- gsub("[:]","",chapters$name)

# create directory
dir.create(output_dir, recursive = TRUE)

# TODO: bad formatting of docx... how to download automatically? html_session+?
#       for now just do it  "manually" with browseURL and my browser
# sapply(seq_len(nrow(chapters)), function(i) browseURL(chapters$href[i]))

docx_files <- list.files(output_dir, "docx", full.names = TRUE)
new.order <- order(as.numeric(gsub("13th-Keys-Chapter(.*)\\.docx", "\\1", basename(docx_files))))
docx_files <- docx_files[new.order]

keys13 <- lapply(docx_files, textreadr::read_docx)
lapply(seq_along(keys13), 
       function(i) write(keys13[[i]], file = file.path(output_dir, sprintf("KST13_%s.txt", i))))

outframe <- do.call('rbind', lapply(seq_along(keys13), function(i) {
  raw <- keys13[[i]]
  
  short.ldx <- nchar(raw) < 10
  if (any(short.ldx))
    raw <- raw[-which(short.ldx)]
  
  meets.ldx <- grepl("meet +items? +.* +below", raw)
  idx <- which(meets.ldx)
  
  data.frame(taxon = raw[idx + 1],
             newcode = gsub(" |^R R |^T T |^I +I? *|^L ", "", 
                            gsub("([A-Z ]{4}[a-z]?)\\.? .*", "\\1", raw[idx])),
             criterion = raw[idx])
}))

groups <- data.frame(do.call('rbind', lapply(SoilTaxonomy::decompose_taxon_code(outframe$newcode), t)))
groups[] <- lapply(groups, as.character)
colnames(groups) <- c("order","suborder","greatgroup","subgroup")
groups$edition <- "13"
outframe <- cbind(groups, outframe)
write.csv(outframe, file = file.path(output_dir,"new_key_style_grouped.csv"), row.names = FALSE)

res <- split(outframe, outframe$greatgroup)

multikey <- sapply(res, function(x) which(diff( SoilTaxonomy::relative_taxon_code_position(x$newcode)) > 1))

# what taxa? (note this uses the 12th edition lookup table at great group level)
names(multikey) <- SoilTaxonomy::taxon_code_to_taxon(names(multikey))

# who has the most? Haploxerolls, Haplustolls, Paleudults, Argixerolls, Argiustolls...
sort(sapply(multikey[sapply(multikey, function(x) length(x) > 0)], length), decreasing=TRUE)
