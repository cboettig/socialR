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
                         dir="NULL"), tags=""){
# error reporting through twitter
# Example:
#	  options(error=tweet_error(script, gitopts))
  gitaddr <- do.call(git_url, c(list(scriptname=script), gitopts))
  function(){
       tweet(paste(script, "ERROR", "source:",
          shorturl(gitaddr)), tags=tags, mention=gitopts$user)
  }
}

