\name{notebook.url}
\alias{notebook.url}
\title{Upload file to the notebook and return the full url}
\usage{
  notebook.url(file, cp = TRUE, sync = TRUE)
}
\arguments{
  \item{file}{path to the file}
}
\value{
  url to the file
}
\description{
  Upload file to the notebook and return the full url
}
\details{
  use with opts_knit$set(upload.fun = socialR::flickr.url)
}

