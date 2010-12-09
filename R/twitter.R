#twitter.R
tweet <- function(comment="", hashtags="", commitID="", mention=" "){
	# use RegExp to add hashtag # symbol before each hashtag
	system(paste('hpc-autotweets " @', mention, comment, hashtags, commitID, '"', sep=""))
}

