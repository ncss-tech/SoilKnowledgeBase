# Create OSD data structures in inst/extdata

#' Create OSD Dataset
#'
#' @param ... Arguments to \code{parse_OSD}
#' @return TRUE if successful
#' @export
create_OSD <- function(...) {

  attempt <- try({ 
    
        message("Processing OSD data snapshot from OSDRegistry...")
    
        # Download OSDRegistry snapshot
        download_OSD()
        
        # Optional: special scripts can be called from inst/scripts/OSD
        # rpath <- list.files("inst/scripts/OSD/", ".*.R", full.names = TRUE)
        
        # Find each .R file (one or more for each part) and source them
        lapply(rpath, function(filepath) {
          if (file.exists(filepath))
            source(filepath)
        })         
        
        ## TODO: dedicated/built-in methods for wrangling the OSDRegistry snapshot
        # parse_OSD(...) 

      })
  
  if (inherits(attempt, 'try-error'))
    return(FALSE)
  
  message("Done!")
  return(TRUE)
}

#' Internal method for downloading OSDRegistry snapshot 
#' 
#' @description This is an internal method for downloading the latest snapshot (or sample ZIP) containing Official Series Description (OSD) text files in an alphabetical folder structure. These files are un-zipped and processed into JSON which is stored in \code{"inst/extdata/OSD"}
#' 
#' @details Default path to OSD data snapshot is an "artifact" created by the \code{refresh-osd} workflow on the \href{https://github.com/ncss-tech/OSDRegistry}{OSDRegistry} GitHub Repository. 
#' 
#' The latest version of the snapshot can be downloaded as a ZIP file from this URL: \url{https://github.com/ncss-tech/OSDRegistry/releases/download/main/OSD-data-snapshot.zip}. 
#' 
#' Note: This is a ZIP file within a ZIP file where the internal ZIP file has a unique (weekly) date stamp.
#' 
#' @param url Path to OSD Data Snapshot
#'
#' @return TRUE if successful, try-error if download or parsing fails
#' @importFrom OSDRegistry osd_to_json
download_OSD <- function(url = 'https://github.com/ncss-tech/OSDRegistry/releases/download/main/OSD-data-snapshot.zip') {
  download.file(url, "OSD.zip")
  unzip('OSD.zip')
  file.remove('OSD.zip')
  wkzip <- list.files(pattern = "OSD_.*zip")
  unzip(wkzip)
  file.remove(wkzip)
  res <- OSDRegistry::osd_to_json(output_dir = "inst/extdata/OSD")
  stopifnot(all(res))
  unlink("OSD", recursive = TRUE)
  return(TRUE)
}
