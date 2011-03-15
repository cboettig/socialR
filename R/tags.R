

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


format_tags <- function(tags){
	if(length(tags) > 1){
		tags <- paste(tags, collapse=" ")  
	}
	tags
}
