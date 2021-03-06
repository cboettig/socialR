## How can I get uploading via Rflickr to work when run in batch mode?  
## Can I store authentication credentials successfully?

require(Rflickr)
tok <- Rflickr::authenticate(getOption("flickr_api_key"), getOption("flickr_secret"), permission="write")
fauth <- flickrSession(getOption("flickr_secret"), tok, getOption("flickr_api_key"))
fauth$people.getInfo("46456847@N08")

png("silly.png")
plot(rnorm(100), rnorm(100))
dev.off()
fauth$upload(image="silly.png", description="this is a test", tags="", is_public=TRUE)

save(list="fauth", file="flickr_auth.rda")
