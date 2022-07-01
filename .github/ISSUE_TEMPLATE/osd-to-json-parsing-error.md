---
name: OSD-to-JSON Parsing Error
about: 'Document OSD->JSON parsing error '
title: ''
labels: ''
assignees: brownag

---

Run the following code and include the markdown table output containing links to the OSD and the resulting JSON for each series name.

```r
osdlist.to.table <- function(x, ...) {
  base1 <- "https://casoilresource.lawr.ucdavis.edu/sde/?series=%s"
  a <- sprintf(base1, x)
  base2 <- "https://github.com/ncss-tech/SoilKnowledgeBase/blob/main/inst/extdata/OSD/%s/%s.json"
  b <- sprintf(base2, substr(x, 0, 1), x)
  knitr::kable(data.frame(OSD=paste0("[", x, "](", a, ")"), JSON=paste0("[", basename(b), "](", b, ")")), ...)
}
osdlist.to.table(c("ARIEL", "COLEMANTOWN", "DOCENA"))
```
