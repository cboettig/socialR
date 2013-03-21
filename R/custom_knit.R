#' Define the wordpress uploader method.  
#' @param x the image to be uploaded 
#' @details Make sure url and user/password are defined in options for 
#' this to work, i.e: 
#' options(WordPressLogin = c(userid = "password"), 
#'   WordPressURL = "http://www.yourdomain.com/xmlrpc.php")
#' @import RWordPress
#' @seealso uploadFile
#' @return the url, if uploaded.  otherwise, just the name of the file
#' @export
wordpress.url = function(file) {
  require(RWordPress)
  uploadFile(file)$url
}


#' Define the flickr uploader method using Rflickr
#' @param x the name of the image file to upload
#' @param ... additional arguments to flickr.upload (public, description, tags)
#' @return the url, if uploaded. 
#' @details you'll need to define your secure details in options. 
#' Obtain an api_key and secret key for your account by registering
#' with the flickr API. Then use Rflickr to establish an authentication token
#' for this application.  Enter each of these using "options()"
#' @import Rflickr
#' @seealso flickr.upload 
#' @export
flickr.url = function(file){
  require(Rflickr)
  if(is.null(getOption("flickr_title"))) 
    img_title = file 
  else 
    img_title = getOption("flickr_title")  
  sha     = gsub("^commit ", "", system("git log -n 1", intern=TRUE)[1])
  auth    = getOption("flickr_tok") 
  api_key = getOption("flickr_api_key") 
  secret  = getOption("flickr_secret")
  id <- do.call(flickr.upload, 
    c(secret = secret, auth_token = auth, api_key = api_key,
      title = img_title, 
      description =  paste(getOption("flickr_description"), sha),
      tags = getOption("flickr_tags"),
      image = file, as.list(getOption("flickrOptions"))))
  sizes_url <- flickr.photos.getSizes(secret=secret, auth_token=auth,
                                      api_key=api_key, photo_id=id)
  n <- length(sizes_url) # get original size
  orig_size_url <- sizes_url[[n-1]][[4]]
  orig_size_url
}

#' A function to set the wordpress rendering environment with code syntax highlighting
#' @param upload should images be uploaded 
#' @param image_service which image method should be used?  See details
#' @return creates a wordpress rendering environment
#' @details wordpress
#' @import knitr
#' @export
render_wordpress <- function(upload=TRUE, image_service = c("wordpress", "imgur", "flickr")){
  render_gfm() 
  options(width=50)
  opts_knit$set(upload = upload)
  output = function(x, options) paste("[code lang='r']\n", x, "[/code]\n", sep = "")
  warning = function(x, options) paste("[code lang='r']\n", x, "[/code]\n", sep = "")
  message = function(x, options) paste("[code lang='r']\n", x, "[/code]\n", sep = "")
  inline = function(x, options) paste("<pre>", x, "</pre>", sep = "")
  error = function(x, options) paste("[code lang='r']\n", x, "[/code]\n", sep = "")
  source = function(x, options) paste("[code lang='r']\n", x, "[/code]\n", sep = "")

  image_service <- match.arg(image_service)
  if(image_service == "flickr")
    opts_knit$set(upload.fun = flickr.url)
  else if(image_service == "wordpress")
    opts_knit$set(upload.fun = wordpress.url)
    
  ## And here we go
  knit_hooks$set(output=output, warning=warning, message=message, 
                 inline=inline, error=error, source=source, plot = hook_plot_html) 
}


#' A function that reads posts a file to wordpress
#' @param file the wordpress blog post
#' @param title the title for the post
#' @param publish should I post as a draft or publish immediately?
#' @return creates a wordpress post
#' @import RWordPress
#' @export
#' @details Requires wordpress options be already configured, e.g. 
#' options(WordPressLogin = c(userid = "password"), 
#'   WordPressURL = "http://www.yourdomain.com/xmlrpc.php")
post_wordpress <- function(file, title = format(Sys.time(), "%A"), publish = FALSE){
  require(RWordPress)
  text = paste(readLines(file), collapse = '\n')
  newPost(list(description = text, title = title), publish = publish)
}



#' Print a table in github-flavored markdown
#' @param x an R table object
#' @param ... aditional arguments to ascii
#' @return prints a gfm marked up table (nice ascii readable format)
#' @export
gfm_table <- function(x, ...) {
 # from ramnathv, https://gist.github.com/2050761
 require(ascii)
 y <- capture.output(print(ascii(x, ...), type = "org"))
        # substitute + with | for table markup
        y <- gsub("[+]", "|", y)
        return(writeLines(y))
}

