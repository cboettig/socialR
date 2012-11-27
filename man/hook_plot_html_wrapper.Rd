\name{hook_plot_html_wrapper}
\alias{hook_plot_html_wrapper}
\title{define a wrapper to make a generic url image method html compatible}
\usage{
  hook_plot_html_wrapper(custom_url, ...)
}
\arguments{
  \item{custom_url}{a function that uploads an image and
  returns a url}

  \item{...}{additional options for that function}
}
\value{
  a knitr hook for html
}
\description{
  define a wrapper to make a generic url image method html
  compatible
}
\details{
  shouldn't be necessary once knitr is supporting custom
  urls
}

