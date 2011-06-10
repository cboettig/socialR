# helper functions


get_cpu_name <- function(){
  out <- system("uname -n", intern=TRUE)
  out
}


format_tags <- function(tags){
	if(length(tags) > 1){
		tags <- paste(tags, collapse=" ")  
	}
	tags
}
