#plot_ex.R
# Pass a plot expression to social_plot
require(socialR)

script <- "example.R"
gitopts = list(user = "cboettig", dir = "demo", repo = "socialR")

upload(
{
  plot(rnorm(10), rnorm(10))
  curve(1*x, add=T)
}, script="example.R") 


on.exit(system("git push"))
