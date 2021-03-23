# draft tabulating latest taxonomy 13th ed changes
# 
library(rvest)

output_dir <- 'inst/extdata/KST/2021'

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
sapply(seq_len(nrow(chapters)), function(i) browseURL(chapters$href[i]))

docx_files <- list.files(output_dir, "docx")


