#twitter.R
tweet <- function(comment="", tags="", commitID="", mention=NULL){
	# uses RegExp to add hashtag (pound, #) symbol before each tag
	hashtags <- gsub("(\\b\\w.)",    "\\#\\1", tags, perl=TRUE)
	if(!is.null(mention)){ system(paste("hpc-autotweets \" @", mention, " ", comment, " ", hashtags, commitID, "\"", sep="")) }
	else {system(paste("hpc-autotweets \" ", comment, " ", hashtags, " ", commitID, "\"", sep="")) } 
}


## error reporting
tweet_errors <- function(tags="", gitID=TRUE, mention=NULL, guess_tags=FALSE){
	if(gitID){ commitID <- gitlog()$commitID }
	else{ commitID="" }
	if(guess_tags) tags <- c(tags, smart_tags() )
	myerror <- function() tweet(comment="Error", tags=tags, commitID=commitID, mention=mention)
	options(error=myerror)
}

no_tweet_errors <- function(){
	options(error=NULL)
}
