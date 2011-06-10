#plot_ex.R
# Pass a plot expression to social_plot
require(socialR)

exp <- {
  plot(rnorm(10), rnorm(10))
  curve(1*x, add=T)
}

social_plot(exp) 


