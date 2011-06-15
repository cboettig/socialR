#twitter.R
tweet <- function(comment="", tags="", mention=NULL){
  tags <- format_tags(tags)
	hashtags <- gsub("(\\b\\w.)", "\\#\\1", tags, perl=TRUE)
	if(!is.null(mention)){
    msg <- paste("@", mention, " ", comment, " ", hashtags, sep="")
  } else {
    msg <- paste(comment, " ", hashtags, sep="")
  }
  msg <- gsub("^(.{140}).*", "\\1", msg)  ## TRUNCATE to 140
   system(paste("hpc-autotweets \" ", msg, "\"", sep="")) 
}


tweet_errors <- function(script, gitopts=list(user="cboettig", repo="NULL",
                         dir="NULL"), tags="", mention=NULL){
# error reporting through twitter
  gitaddr <- do.call(git_url, c(list(scriptname=script), gitopts))
  cpu <- get_cpu_name()
  runtime <- gettime()
  
  if(interactive()) # don't tweet from interactive sessions
    error_fn <- function() recover()
  else 
    error_fn <- function(){
       tweet(paste(script, "ERROR on ", cpu, ", source:",shorturl(gitaddr),
             "runtime: ", runtime, " ", names(runtime)),
             tags=c(paste(tags, " machine_", cpu, sep="")),
             mention=mention)
    }
  options(error=error_fn)
}


gettime <- function(){
   a <- proc.time()
  runtime <- a[3] #a[1]+a[2]+a[4]+a[5]
  formattime(runtime) 
}

formattime <- function(runtime){
  if(runtime < 60){
    runtime <- round(runtime, 3)
    names(runtime) <- "seconds"
  } else if(runtime/60 < 60){
    runtime <- runtime/60
    runtime <- round(runtime, 3)
    names(runtime) <- "minutes"
  } else if(runtime/60/60 < 24){
    runtime <- runtime/60/60
    runtime <- round(runtime, 3)
    names(runtime) <- "hours"
  }  else if(runtime/60/60 > 24){
     runtime <- runtime/60/60/24
     runtime <- round(runtime, 3)
     names(runtime) <- "days"
  }
  runtime
}

tweet_done <- function(script, gitopts=list(user="cboettig", repo="NULL",
                         dir="NULL"), tags="", mention=NULL){
  gitaddr <- do.call(git_url, c(list(scriptname=script), gitopts))
  cpu <- get_cpu_name()
  runtime <- gettime()
  
  if(interactive()) # don't tweet from interactive sessions
    recover()
  else 
     tweet(paste(script, "DONE on ", cpu, ", source:",shorturl(gitaddr),
           "runtime: ", runtime, " ", names(runtime)),
           tags=c(paste(tags, " machine_", cpu, sep="")),
           mention=mention)
}


