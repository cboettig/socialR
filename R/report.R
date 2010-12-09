#report.R
# Gathers run information and synthesizes common calls


## Discover tags from project directory
get_tags <- function(){
}

## all-in-one reporting
social_report <- function(files){
	log <- gitlog()
	tags <- get_tags()
	flickr(files, tags=tags, description=log$commitID)
	tweet(hashtags
}
