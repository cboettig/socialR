#####  socialR header info ##### 
require(socialR)
script <- "example.R" # Must specify the script name! 
gitcommit(script)     # Must commmit at start!

### Optional but a good idea:  
gitopts = list(user = "cboettig", dir = "demo", repo = "socialR") #almost requisite, if not me running in /demo
on.exit(system("git push")) #  Need for git links.  May prompt for pw, so wait till end.  
tags <- "test"  ## optional. Nice but establish a few standard ones only

tweet_errors(script, gitopts, tags)  ## tweet on error



# code code code .....
png("test.png")
  hist(rnorm(100))
dev.off()


# and we have some results to commit...
upload("test.png", script=script, gitopts=gitopts, tags="test", tweet=T) 



