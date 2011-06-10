format_tags <- function(tags){
	if(length(tags) > 1){
		tags <- paste(tags, collapse=" ")  
	}
	tags
}
