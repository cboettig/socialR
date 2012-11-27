#' Upload file to the notebook and return the full url
#' @param file path to the file
#' @return url to the file
#' @details use with opts_knit$set(upload.fun = socialR::flickr.url)
#' @export
#'
notebook.url <- function(file, cp=TRUE, sync=TRUE){
  sha <- gsub("^commit ", "", system("git log -n 1", intern=TRUE)[1])
  short_sha <- gsub("(^.{10}).*", "\\1", sha)
  date <- format(Sys.time(), "%Y-%m-%d")
  filename <- gsub("figure/(.*\\.png)", "\\1", file)
  fig.name <- paste(date, "-", short_sha, "-", filename, sep="")
  path <- paste("~/Documents/labnotebook/assets/figures/", fig.name, sep="")
  if(cp)
    system(paste("cp", file, path, sep=" "))

  url_out <- paste("http://carlboettiger.info/assets/figures/", fig.name, sep="")
  if(sync){
    if(is.character(getURL("www.google.com"))){
      system("rsync -avz ~/Documents/labnotebook/assets/figures/ carlboettiger.info:~/carlboettiger.info/assets/figures/")
    out <- url_out 
    } else
      warning("no network connection found")
  } else
    out <- path
  out
}


