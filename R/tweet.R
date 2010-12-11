#twitter.R
tweet <- function(comment="", tags="", commitID="", mention=NULL){
	# uses RegExp to add hashtag (pound, #) symbol before each tag
	hashtags <- gsub("(\\b\\w.)", "\\#\\1", tags, perl=TRUE)
#	if(!is.null(mention)){
#		system(paste("hpc-autotweets ' @", mention, " ", comment, " ", hashtags, commitID, "'", sep="")) 
#	} else { system(paste("hpc-autotweets ' ", comment, " ", hashtags, commitID, "'", sep="")) 
#	} 
}
