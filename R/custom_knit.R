
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
wordpress.url = function(x) {
  require(RWordPress)
  file = paste(x, collapse = '.')
  if (opts_knit$get('upload')) {
    uploadFile(file)$url
  } else file
}


#' Define the flickr uploader method using Rflickr
#' @param x the name of the image file to upload
#' @param id_only return the flickr id code? if false returns the static url
#' @param ... additional arguments to flickr.upload (public, description, tags)
#' @return the url, if uploaded.  otherwise, just the name of the file. 
#'  Optionally will return just the flickr id if id_only is TRUE
#' @details you'll need to define your secure details in options. 
#' Obtain an api_key and secret key for your account by registering
#' with the flickr API. Then use Rflickr to establish an authentication token
#' for this application.  Enter each of these using "options()"
#' @import Rflickr
#' @seealso flickr.upload 
#' @export
flickr.url = function(x, id_only = FALSE, ...){
  require(Rflickr)
  file = paste(x, collapse = '.')
  if (opts_knit$get('upload')) {
    auth=getOption("flickr_tok") 
    api_key=getOption("flickr_api_key") 
    secret=getOption("flickr_secret")
    id <- flickr.upload(secret=secret, auth_token=auth,
                        api_key=api_key, image=file, ...)
    sizes_url <- flickr.photos.getSizes(secret=secret, auth_token=auth,
                                        api_key=api_key, photo_id=id)
    if(id_only) 
      out <- id
    else 
      out <- sizes_url[[5]][[4]]
    out
  } else file
}


#' Create a hook that inserts my wordpress shortcode
hook_plot_flickr_shortcode = function(x, options) {
    sprintf('[flickr]%s[/flickr]', flickr.url(x, id_only=TRUE))
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
  options(width=30)
  opts_knit$set(upload = upload)
  output = function(x, options) paste("[code]\n", x, "[/code]\n", sep = "")
  warning = function(x, options) paste("[code]\n", x, "[/code]\n", sep = "")
  message = function(x, options) paste("[code]\n", x, "[/code]\n", sep = "")
  inline = function(x, options) paste("<pre>", x, "</pre>", sep = "")
  error = function(x, options) paste("[code]\n", x, "[/code]\n", sep = "")
  source = function(x, options) paste("[code lang='r']\n", x, "[/code]\n", sep = "")

  image_service <- match.arg(image_service)
  if(image_service == "flickr")
   opts_knit$get("flickr.url")
  else if(image_service == "wordpress")
   opts_knit$get("wordpress.url")
    
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


