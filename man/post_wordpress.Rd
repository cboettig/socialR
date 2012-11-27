\name{post_wordpress}
\alias{post_wordpress}
\title{A function that reads posts a file to wordpress}
\usage{
  post_wordpress(file, title = format(Sys.time(), "\%A"),
    publish = FALSE)
}
\arguments{
  \item{file}{the wordpress blog post}

  \item{title}{the title for the post}

  \item{publish}{should I post as a draft or publish
  immediately?}
}
\value{
  creates a wordpress post
}
\description{
  A function that reads posts a file to wordpress
}
\details{
  Requires wordpress options be already configured, e.g.
  options(WordPressLogin = c(userid = "password"),
  WordPressURL = "http://www.yourdomain.com/xmlrpc.php")
}

