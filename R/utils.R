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

#' Convert a named list to JSON
#' 
#' @description The main reason for including this wrapper method is to make roxygen aware of jsonlite dependency
#'
#' @param a_list An R object to convert to JSON
#' @param pretty Add whitespace to JSON output? Default: TRUE [argument to \code{jsonlite::toJSON}]
#' @param auto_unbox Automatically "unbox" vectors of length one? Default: TRUE [argument to \code{jsonlite::toJSON}]
#' @param ... Additional arguments to \code{jsonlite::toJSON}
#'
#' @return A character string formatted as JSON
#' 
#' @export
#'
#' @importFrom jsonlite toJSON
convert_to_json <- function(a_list, pretty = TRUE, auto_unbox = TRUE, ...) {
  jsonlite::toJSON(x = a_list, pretty = pretty, auto_unbox = auto_unbox, ...)
}
