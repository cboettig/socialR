#report.R
# Gathers run information and synthesizes common calls

## all-in-one reporting, uploads specified files or just tweets the data
social_report <- function(files=NULL, comment=" ", mention=NULL, tags = "", guess_tags=FALSE, commit=FALSE, gituser="cboettig", flickruser="cboettig", urls=FALSE, public=TRUE, save=TRUE){

	if(commit)
		gitcommit()
	log <- gitlog()
	if(guess_tags)
		tags <- paste(tags, smart_tags() )
	if(!is.null(files))
		tags <- paste(tags, files)
	if(urls){
		# grab the git url
		giturl <- git_url(user=gituser) 
		## Upload to flickr and grab url
		flickr_id <- flickr(files, tags=tags, description=c(comment, " ", log$commitID, giturl), public=public )
		flickrurl <- flickr_url(flickr_id, user=flickruser)
		tweettext <- paste(comment, "code:", shorturl(giturl), "fig:", shorturl(flickrurl))
		tweet(comment=tweettext, tags=tags, mention=mention)
	} else {
		flickr_id <- flickr(files, tags=tags, description=paste(comment, log$commitID), public=public )
		tweet(comment=comment, tags=tags, mention=mention)
	}

	if(save){
    env <- parent(parent.env(environment())) # If this function is being called by social_plot, this is true?
    save(list=ls(env), file=paste(flickr_id, ".Rdat", sep=""))
		print(paste("datafile saved as ", flickr_id, ".Rdat", sep=""))
	}
	flickr_id
}

## A function that can be wrapped around a plot command to autoreport it
social_plot <- function(plotcmd, file=NULL, comment="", mention=NULL, tags="",
                        device=c("png"), guess_tags=FALSE, commit=TRUE, 
                        gituser="cboettig", flickruser="cboettig", public=TRUE,
                        save=TRUE, ...){
	if(is.null(file)){
		if(device == "png"){ 
			png("autoplot.png", ...)
			file <- "autoplot.png"
		}
		else { 
      printf("device type not recognized") 
      return(0) 
    }
	} else {
		if(device == "png"){
      png(file, ...)
    } else { 
      printf("device type not recognized") 
      return(0) 
    }
	}
	plotcmd
	dev.off()
	social_report(files=file, comment=comment, mention=mention, tags=tags,
                guess_tags=guess_tags, commit=TRUE, flickruser=flickruser,
                gituser=gituser, public=public, save=save)
}


