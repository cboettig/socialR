\name{hook_plot_md_wrapper}
\alias{hook_plot_md_wrapper}
\title{define a wrapper to make a generic url image method markdown compatible}
\usage{
  hook_plot_md_wrapper(custom_url)
}
\arguments{
  \item{custom_url}{a function that uploads an image and
  returns a url}

  \item{...}{additional options for that function}
}
\value{
  a knitr hook for markdown format
}
\description{
  define a wrapper to make a generic url image method
  markdown compatible
}
\details{
  shouldn't be necessary once knitr is supporting custom
  urls
}

