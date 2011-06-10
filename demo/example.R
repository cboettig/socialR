#plot_ex.R
# Pass a plot expression to social_plot
require(socialR)

filename <- "example.R"
dir <- "demo"
repo <- "socialR"
user <- "cboettig"

gitaddr <- git_url(filename, user=user, repo=repo, dir=dir)
#social_plot({

png("test.png")
  hist(rnorm(10), rnorm(10))
dev.off()
#})

flickr("test.png", description=gitaddr)
system("git push")
