#report.R
# Gathers run information and synthesizes common calls


## all-in-one reporting, uploads specified files or just tweets the data
social_report <- function(files=NULL, comment=" ", mention=NULL, tags = "", guess_tags=FALSE, commit=FALSE, gituser="cboettig", flickruser="cboettig", urls=FALSE, public=TRUE){

	if(commit) gitcommit()
	log <- gitlog()
	if(guess_tags) tags <- paste(tags, smart_tags() )
	if(!is.null(files)) tags <- paste(tags, files)
	if(urls){
		# grab the git url
		giturl <- git_url(user=gituser) 
		## Upload to flickr and grab url
		flickrurl <- flickr(files, tags=tags, description=c(comment, " ", log$commitID, giturl), user=flickruser, public=public )
		tweet(comment=paste(comment, "code:", shorturl(giturl), "fig:", shorturl(flickrurl)), tags=tags, mention=mention)
	} else {
		flickr(files, tags=tags, description=paste(comment, log$commitID), user=flickruser, public=public )
		tweet(comment=comment, tags=tags, mention=mention)
	}
}

## A function that can be wrapped around a plot command to autoreport it
social_plot <- function(plotcmd, file=NULL, comment="", mention=NULL, tags="", device=c("png"), guess_tags=FALSE, commit=TRUE, gituser="cboettig", flickruser="cboettig", public=TRUE, ...){
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
	social_report(files=file, comment=comment, mention=mention, tags=tags, guess_tags=guess_tags, commit=TRUE, flickruser=flickruser, gituser=gituser, public=public, ...)
}


