#report.R
# Gathers run information and synthesizes common calls


# could pass flickr opts with a do.call as well...
upload <- function(images, script, comment="", tags="", public=TRUE, 
                   gitopts=list(user="cboettig", repo=NULL, dir=NULL),
                   save=TRUE, tweet=FALSE){
## Uploads images with links to code, saves data matching image name
## Args:
##   images: list of .png or .jpg files to upload
##   script: name of the current script
## Example:

  gitaddr <- do.call(git_url, c(list(scriptname=script), gitopts))
  source <- paste("<a href=\"", gitaddr, "\">view sourcecode ",
                  script, "</a>", sep="") 
  flickr_id <- flickr(images, description=paste(source, comment),
                      tags=tags, public=public)
  if(tweet){
    flickraddr <- flickr_url(flickr_id, user=gitopts$user)
    tweet(paste(script, "done", "view:", shorturl(flickraddr), "source:",
          shorturl(gitaddr)), tags=tags)
  }

  if(save){
    env <- .GlobalEnv 
    save(list=ls(env), file=paste(flickr_id, ".Rdat", sep=""))
		print(paste("datafile saved as ", flickr_id, ".Rdat", sep=""))
  }
}



############ DEPRICATED ####################
## all-in-one reporting, uploads specified files or just tweets the data
social_report <- function(files=NULL, comment=" ", tags = "", guess_tags=FALSE, public=TRUE, save=TRUE, global=TRUE){

	log <- gitlog()
  flickr_id <- flickr(files, tags=tags, description=
                      paste(comment,log$commitID), public=public )
  tweet(comment=comment, tags=tags)

	if(save){
    if(global)
      env <- .GlobalEnv
    else 
      env <- parent.env(parent.env(environment())) # If this function is being called by social_plot, this is true?
    save(list=ls(env), file=paste(flickr_id, ".Rdat", sep=""))
		print(paste("datafile saved as ", flickr_id, ".Rdat", sep=""))
	}
	flickr_id
}

## A function that can be wrapped around a plot command to autoreport it
social_plot <- function(plotcmd, file=NULL, comment="", tags="",
                        device=c("png"), public=TRUE, save=TRUE, ...){
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
	social_report(files=file, comment=comment, tags=tags,
                public=public, save=save, global=FALSE)
}


