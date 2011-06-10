#plot_ex.R
# Pass a plot expression to social_plot
require(socialR)

script <- "example.R"
gitopts = list(user = "cboettig", dir = "demo", repo = "socialR")

upload(
{
  hist(rnorm(100))
}, script="example.R") 


on.exit(system("git push"))
