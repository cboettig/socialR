#flickr.R

flickr <- function(files, tags="", description="", public=TRUE){
	tags <- format_tags(tags)
# tags -- a space separated character list of all the tags
	upload_output <- system(paste('flickr_upload --tag="', tags, 
				 ' " --description="', description, '"', ' --public ', 
         as.integer(public), 
				 files), intern=TRUE)
	flickr_id <- gsub("([^0-9]*)", "", upload_output[3])
	flickr_id
}

flickr_url <- function(flickr_id, user="cboettig")
{
	url <- paste("http://www.flickr.com/photos/", user, "/",  flickr_id, sep="")
}

#shorturl(flickr("qrcode.png")) 
