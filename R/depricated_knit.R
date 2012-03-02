
########## DEPRICATED METHODS ############# 

#' define a wrapper to make a generic url image method html compatible
#' @param custom_url a function that uploads an image and returns a url
#' @param ... additional options for that function
#' @return a knitr hook for html 
#' @details shouldn't be necessary once knitr is supporting custom urls
hook_plot_html_wrapper <- function(custom_url, ...){
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
#' @param custom_url a function that uploads an image and returns a url
#' @param ... additional options for that function
#' @return a knitr hook for markdown format 
#' @details shouldn't be necessary once knitr is supporting custom urls
hook_plot_md_wrapper <- function(custom_url){
  function(x, options) {
    base = opts_knit$get('base.url')
    if (is.null(base)) base = ''
      sprintf('![plot of chunk %s](%s%s) ', options$label, base, custom_url(x))
  }
}



### Old perl-based uploader #####
## Flickr uploader method using my .flickr function (calls perl script)
flickr.id = function(x) {
  file = paste(x, collapse = '.')
  if (opts_knit$get('upload')) {
    flickr(file)
  } else file
}
## Flickr upload actually just calls a command line tool and returns the id code
flickr <- function(file, tags="", description="", public=TRUE){
  out <- system(paste('flickr_upload --tag="', tags, 
               ' " --description="', description, '"', ' --public ', 
               as.integer(public), file), intern=TRUE)
  gsub(".*ids=(\\d+)", "\\1", out[3])
}
## Create a hook that inserts my wordpress shortcode
hook_plot_flickr_shortcode_perl = function(x, options) {
    sprintf('[flickr]%s[/flickr]', .flickr.id(x))
}


