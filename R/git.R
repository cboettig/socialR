#git.R



## link to commit diffs
#https://github.com/cboettig/socialR/commit/1034380c2ac2258f92855e753dd1a23bca9b028b

## link to version
#https://github.com/cboettig/socialR/blob/1034380c2ac2258f92855e753dd1a23bca9b028b/demo/plot_ex.R

## raw
#https://raw.github.com/cboettig/socialR/f7254fca0a99bf846f5e4c0ceb7df6e1c2e9aa84/demo/plot_ex.R



## the commitID 
gitlog <- function(){
	log <- system("git log -n 1", intern=TRUE) 
	commitID <- log[1]
	author <- log[2]
	date <- log[3]
	short_comment <- log[5]
	commitID <- strsplit(commitID, " ")[[1]][2]   # Hashtag without the word "commit" before it
# Consider the shortened ID
list(commitID = commitID, author=author, date=date, short_comment=short_comment)
}

# consider allowing R to check if a commit should be done
gitcommit <- function(filename="", msg=""){
  if(filename==""){
  	system(paste("git commit -a -m", "'", msg, "autocommit", "'"), intern=TRUE)
  } else {
  	system(paste("git add", filename), intern=TRUE)
  	system(paste("git commit -m", "'", filename, msg, "autocommit", "'"), intern=TRUE)
  }
}




# get the url to the code on github.  Code still needs to be pushed before link will work!
# note that default guesses may fail, specify all options!
git_url <- function(filename, user="cboettig", repository=NULL, dir="NULL",
                    raw=FALSE, diff=FALSE){

  gitcommit(filename) 

  if(is.null(repository)) ## guesses is one directory up
    repository <-gsub(".*/(.*)/.*$", "\\1", getwd())
  if(is.null(dir)) ## guess the current directory
    dir <-gsub(".*/(.*)$", "\\1", getwd())
	log <- gitlog()
	id <- gsub("\\s", "/", log$commitID)
  domain <- "https://github.com"

  if(raw)
    out <- paste("https://raw.github.com", user, repository, id, dir, filename, sep="/") 
  else if(diff)
    out <- paste(domain, user, repository, "commit", id, sep="/") 
  else 
    out <- paste(domain, user, repository, "blob", id, dir, filename, sep="/") 
}


# Save file and data
keep_data <- function(filename){
	datafile <- paste(filename, ".Rdat", sep="")
	save(list=ls(), file=datafile)
	system(paste("git add ", datafile))
	gitcommit()
}


