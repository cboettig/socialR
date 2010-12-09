#twitter.R
tweet <- function(text="", hashtags="", commitID="", mention_flag=FALSE){
	if(mention_flag){ mention = "@cboettig" }else{ mention = "" }
	# use RegExp to add hashtag # symbol before each hashtag
	system(paste('hpc-autotweets "', mention, text, hashtags, commitID, '"'))
}

