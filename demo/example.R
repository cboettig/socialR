#####  socialR header info ##### 
require(socialR)
gitcommit(script)     # Must commmit at start!
script <- "example.R" # Must specify the script name! 

# specify the repository and directory information.  optional 
# These values will be guessed correctly only if I'm the user and run one directory up.  
gitopts = list(user = "cboettig", dir = "demo", repo = "socialR")

# Optionally, at the end we can push so that the git links work
# could do this earlier but don't want to hang,  Ideally this should check if origin is current
# this may prompt for a password at the terminal, even in batch mode
on.exit(system("git push")) 

## tags, optional but nice
tags <- "test"

## Optionally, we can use twitter for error tracking:
options(error=tweet_errors(script, gitopts, tags))


# code code code .....

# and we have some results to commit...
upload(
{
  hist(rnorm(100))
}, script=script, gitopts=gitopts, tag="test") 



