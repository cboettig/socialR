#twitter.R
tweet <- function(comment="", tags="", mention=NULL){
  tags <- format_tags(tags)
	hashtags <- gsub("(\\b\\w.)", "\\#\\1", tags, perl=TRUE)
	if(!is.null(mention)){ 
    system(paste("hpc-autotweets \" @", mention, " ", comment, " ", hashtags,
                 "\"", sep="")) 
    }
	else {
    system(paste("hpc-autotweets \" ", comment, " ", hashtags, " ", 
                 "\"", sep="")) } 
}


tweet_errors <- function(script, gitopts=list(user="cboettig", repo="NULL",
                         dir="NULL"), tags="", mention=NULL){
# error reporting through twitter
# Example:
#	  options(error=tweet_error(script, gitopts))
  gitaddr <- do.call(git_url, c(list(scriptname=script), gitopts))
  cpu <- get_cpu_name()
  if(interactive()) # don't tweet from interactive sessions
    error_fn <- function() recover()
  else 
    error_fn <- function(){
       tweet(paste(script, "ERROR on ", cpu, ", source:",shorturl(gitaddr)),
             tags=c(paste(tags, " machine_", cpu, sep="")),
             mention=mention)
    }
  options(error=error_fn)
}





