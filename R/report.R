#report.R
# Gathers run information and synthesizes common calls


## Discover tags from project directory
smart_tags <- function(){
}

## all-in-one reporting, uploads specified files or just tweets the data
social_report <- function(files=NULL, comment="", mention=" ", tags = "", guess_tags=FALSE){
	log <- gitlog()
	if(guess_tags) tags <- c(tags, smart_tags() )
	flickr(files, tags=tags, description=log$commitID)
	tweet(comment=comment, tags=tags, commitID=log$commitID, mention=mention)
}

## A function that can be wrapped around a plot command to autoreport it
social_plot <- function(plotcmd, comment="", mention=" ", tags="", device=c("png"), guess_tags=FALSE, ...){
	if(device == "png"){ png("autoplot.png", ...)}
	else { printf("device type not recognized"); return(0) }
	plotcmd
	dev.off()
	social_report(files="autoplot.png", comment=comment, mention=mention, tags=tags, guess_tags=guess_tags)
}
