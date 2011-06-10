#plot_ex.R
# Pass a plot expression to social_plot
require(socialR)

social_plot({
  plot(rnorm(10), rnorm(10))
  curve(1*x, add=T)
})


