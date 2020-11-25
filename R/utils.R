#' Convert an xml_nodeset containing <a> elements into a tbl_df
#'
#' @param xmln xml_nodeset produced by e.g. \code{html_nodes(page, 'a')}
#'
#' @return A tbl_df of information derived from the XML attributes of a nodeset.
#' @importFrom xml2 xml_attrs
#' @importFrom dplyr bind_rows
bind_xml_nodeset <- function(xmln) {
  dplyr::bind_rows(lapply(xml2::xml_attrs(xmln), function(x) data.frame(as.list(x))))
}