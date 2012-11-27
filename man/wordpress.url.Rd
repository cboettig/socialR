\name{wordpress.url}
\alias{wordpress.url}
\title{Define the wordpress uploader method.}
\usage{
  wordpress.url(file)
}
\arguments{
  \item{x}{the image to be uploaded}
}
\value{
  the url, if uploaded.  otherwise, just the name of the
  file
}
\description{
  Define the wordpress uploader method.
}
\details{
  Make sure url and user/password are defined in options
  for this to work, i.e: options(WordPressLogin = c(userid
  = "password"), WordPressURL =
  "http://www.yourdomain.com/xmlrpc.php")
}
\seealso{
  uploadFile
}

