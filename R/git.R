#git.R

## the commitID 
gitlog <- function(remote=FALSE){
	if(!remote){ log <- system("git log -n 1", intern=TRUE) }
	else{ log <- system("git log -n 1 origin", intern=TRUE) }
	commitID <- log[1]
	author <- log[2]
	date <- log[3]
	short_comment <- log[5]
# Consider the shortened ID
list(commitID = commitID, author=author, date=date, short_comment=short_comment)
}

# consider allowing R to check if a commit should be done
gitcommit <- function(msg=""){
	system(paste("git commit -a -m", "'", msg, "autocommit", "'"), intern=TRUE)
}

# get the url to the code on github
git_url <- function(user="cboettig"){
## get the repository name from the remote directory
	remote <- system("git remote -v", intern=TRUE)[1]
	repository <- gsub("[^/]+/([a-zA-Z]+)\\.git.*", "\\1", remote)
## get the commitid
	log <- gitlog()
	id <- gsub("\\s", "/", log$commitID)
	paste("https://github.com/", user, "/", repository, "/", id, sep="") 
}


# Save file and data
keep_data <- function(filename){
	datafile <- paste(filename, ".Rdat", sep="")
	save(list=ls(), file=datafile)
	system(paste("git add ", datafile))
	gitcommit()
}


