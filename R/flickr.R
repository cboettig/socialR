#flickr.R

flickr <- function(files, tags="", description=""){
# tags -- a space separated character list of all the tags
	system(paste('flickr_upload --tag="', tags, 
				 ' " --description="', description, '"', 
				 files))
}
