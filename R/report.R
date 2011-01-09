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
social_report <- function(files=NULL, comment="", mention=NULL, tags = "", guess_tags=FALSE, commit=TRUE, gituser="cboettig", flickruser="cboettig", urls=FALSE){
	if(commit) gitcommit()
	log <- gitlog()
	if(guess_tags) tags <- c(tags, smart_tags() )
	if(urls){
		# grab the git url
		giturl <- git_url(user=gituser) 
		## Upload to flickr and grab url
		flickrurl <- flickr(files, tags=tags, description=c(comment, " ", log$commitID, giturl), user=flickruser )
		tweet(comment=paste(comment, "code:", shorturl(giturl), "fig:", shorturl(flickrurl)), tags=tags, mention=mention)
	} else {
		flickr(files, tags=tags, description=c(comment, " ", log$commitID), user=flickruser )
		tweet(comment=paste(comment, tags=tags, mention=mention), tags=tags, mention=mention)
	}
}

## A function that can be wrapped around a plot command to autoreport it
social_plot <- function(plotcmd, file=NULL, comment="", mention=NULL, tags="", device=c("png"), guess_tags=FALSE, commit=TRUE, gituser="cboettig", flickruser="cboettig", ...){
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
	social_report(files=file, comment=comment, mention=mention, tags=tags, guess_tags=guess_tags, commit=TRUE, flickruser=flickruser, gituser=gituser, ...)
}


