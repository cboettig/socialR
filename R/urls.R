# uses a bash script to shorten urls with google url shortener

shorturl <- function(url){
	out <- system(paste("shorturl", url), intern=TRUE)
#	out <- strsplit(out, "\"")[[1]][1]
	out
}


