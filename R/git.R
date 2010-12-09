#git.R

## the commitID 
gitlog <- function(){
	log <- system("git log -n 1 origin", intern=TRUE)
	commitID <- log[1]
	author <- log[2]
	date <- log[3]
	short_comment <- log[5]
# Consider the shortened ID
list(commitID = commitID, author=author, date=date, short_comment=short_comment)
}

# consider allowing R to check if a commit should be done
gitcommit <- function(){
	system("git commit -a -m 'autocommit'", intern=TRUE)
}

