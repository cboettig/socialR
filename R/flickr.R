#flickr.R

flickr <- function(files, tags="", description="", user="cboettig"){
# tags -- a space separated character list of all the tags
	upload_output <- system(paste('flickr_upload --tag="', tags, 
				 ' " --description="', description, '"', 
				 files), intern=TRUE)
	url <- flickr_urls(upload_output, user=user)
	url
}

flickr_urls <- function(upload_output, user="cboettig"){
	n_images <- length(upload_output)-2
	figure_id <- gsub("([^0-9]*)", "", upload_output[3])
	url <- paste("http://www.flickr.com/photos/", user, "/",  figure_id, sep="")
}

#shorturl(flickr("qrcode.png")) 
