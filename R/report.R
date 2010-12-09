#report.R
# Gathers run information and synthesizes common calls


## Discover tags from project directory
get_tags <- function(){
}

## all-in-one reporting, uploads specified files or just tweets the data
social_report <- function(files=NULL, comment="", mention=" "){
	log <- gitlog()
	tags <- get_tags()
	flickr(files, tags=tags, description=log$commitID)
	tweet(comment=comment, hashtags=tags, commitID=log$commitID, mention=mention)
}

## A function that can be wrapped around a plot command to autoreport it
social_plot <- function(plotcmd, comment="", mention=" ", device=c("png"), ...){
	if(device == "png"){ png("autoplot.png", ...)}
	else { printf("device type not recognized"); return(0) }
	plotcmd
	dev.off()
	social_report(files="autoplot.png", comment=comment, mention=mention)
}
