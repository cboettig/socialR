
#' Define the wordpress uploader method.  
#' @param x the image to be uploaded 
#' @details Make sure url and user/password are defined in options for this to work.  
#' @import RWordPress
#' @seealso uploadFile
#' @export
.wordpress.url = function(x) {
  require(RWordPress)
  file = paste(x, collapse = '.')
  if (opts_knit$get('upload')) {
    uploadFile(file)$url
  } else file
}



#' Define the flickr uploader method using Rflickr
#' @param x the name of the image file to upload
#' @param id_only return the flickr id code? if false returns the static url
#' @param additional arguments to \link{flickr.upload}
#' @details you'll need to define your secure details in options.  
#' @import Rflickr
#' @seealso flickr.upload 
#' @export
.flickr.url = function(x, id_only = FALSE, ...) {
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
    sizes_url[[5]][[4]]
  } else file
}



#' define a wrapper to make a generic url image method html compatible
#' shouldn't be necessary once knitr is supporting custom urls
.hook_plot_html_wrapper <- function(custom_url, ...){
  function(x, options) {
    a = options$fig.align
    sprintf('<img src="%s" class="plot" %s/>\n', custom_url(x, ...),
          switch(a,
                 default = '',
                 left = 'style="float: left"',
                 right = 'style="float: right"',
                 center = 'style="margin: auto; display: block"'))
  }
}
#' define a wrapper to make a generic url image method markdown compatible
#' shouldn't be necessary once knitr is supporting custom urls
.hook_plot_md_wrapper <- function(custom_url){
  function(x, options) {
    base = opts_knit$get('base.url')
    if (is.null(base)) base = ''
      sprintf('![plot of chunk %s](%s%s) ', options$label, base, custom_url(x))
  }
}



### Old perl-based uploader #####
## Flickr uploader method using my .flickr function (calls perl script)
.flickr.id = function(x) {
  file = paste(x, collapse = '.')
  if (opts_knit$get('upload')) {
    .flickr(file)
  } else file
}
## Flickr upload actually just calls a command line tool and returns the id code
.flickr <- function(file, tags="", description="", public=TRUE){
  out <- system(paste('flickr_upload --tag="', tags, 
               ' " --description="', description, '"', ' --public ', 
               as.integer(public), file), intern=TRUE)
  gsub(".*ids=(\\d+)", "\\1", out[3])
}
## Create a hook that inserts my wordpress shortcode
.hook_plot_flickr_shortcode = function(x, options) {
    sprintf('[flickr]%s[/flickr]', .flickr.id(x))
}





render_wordpress <- function(upload=TRUE, flickr=FALSE){
  render_gfm() 
  options(width=30)
  opts_knit$set(upload = upload)
  output = function(x, options) paste("[code]\n", x, "[/code]\n", sep = "")
  warning = function(x, options) paste("[code]\n", x, "[/code]\n", sep = "")
  message = function(x, options) paste("[code]\n", x, "[/code]\n", sep = "")
  inline = function(x, options) paste("<pre>", x, "</pre>", sep = "")
  error = function(x, options) paste("[code]\n", x, "[/code]\n", sep = "")
  source = function(x, options) paste("[code lang='r']\n", x, "[/code]\n", sep = "")

  if(flickr)
    hook_plot = .hook_plot_flickr_sortcode
  else
    hook_plot = .hook_plot_html_wrapper(.wordpress.url)
  ## And here we go
  knit_hooks$set(output=output, warning=warning, message=message, 
                 inline=inline, error=error, source=source, plot = hook_plot) 
}



.post_wordpress <- function(title = format(Sys.time(), "%A"), publish = FALSE){
  require(RWordPress)
  text = paste(readLines('wordpress.md'), collapse = '\n')
  newPost(list(description = text, title = title), publish = publish)
}
