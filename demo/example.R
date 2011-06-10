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
  plot(rnorm(10), rnorm(10))
  curve(1*x, add=T)
dev.off()
#})

link <- paste("<a href=\"", gitaddr, "\">code</a>",  sep="") 

flickr("test.png", description=link)
system("git push")
