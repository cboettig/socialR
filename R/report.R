#report.R
# Gathers run information and synthesizes common calls


## Discover tags from project directory
smart_tags <- function(){
	tag <- ""
	# see if home folder is one up
	check <- system("ls ..", intern=TRUE)	
	if(pmatch("DESCRITPION", check)){
	wd <- getwd()
	wd <- strsplit(wd, "/")[[1]]
	tag <- wd[length(wd)-1]
	} else { printf("unable to determine a smart tag") }
	tag
}

## all-in-one reporting, uploads specified files or just tweets the data
social_report <- function(files=NULL, comment="", mention=NULL, tags = "", guess_tags=FALSE, commit=TRUE){
	if(commit) gitcommit()
	log <- gitlog()
	if(guess_tags) tags <- c(tags, smart_tags() )
	flickr(files, tags=tags, description=c(comment, " ", log$commitID) )
	tweet(comment=comment, tags=tags, commitID=log$commitID, mention=mention)
}

## A function that can be wrapped around a plot command to autoreport it
social_plot <- function(plotcmd, file=NULL, comment="", mention=NULL, tags="", device=c("png"), guess_tags=FALSE, commit=TRUE, ...){
	if(is.null(file)){
		if(device == "png"){ 
			png("autoplot.png", ...)
			file <- "autoplot.png"
		}
		else { printf("device type not recognized"); return(0) }

	} else {
		if(device == "png"){ png(file, ...)}
		else { printf("device type not recognized"); return(0) }
	}
	plotcmd
	dev.off()
	social_report(files=file, comment=comment, mention=mention, tags=tags, guess_tags=guess_tags, commit=TRUE, ...)
}


