\name{flickr.url}
\alias{flickr.url}
\title{Define the flickr uploader method using Rflickr}
\usage{
  flickr.url(file)
}
\arguments{
  \item{x}{the name of the image file to upload}

  \item{...}{additional arguments to flickr.upload (public,
  description, tags)}
}
\value{
  the url, if uploaded.
}
\description{
  Define the flickr uploader method using Rflickr
}
\details{
  you'll need to define your secure details in options.
  Obtain an api_key and secret key for your account by
  registering with the flickr API. Then use Rflickr to
  establish an authentication token for this application.
  Enter each of these using "options()"
}
\seealso{
  flickr.upload
}

