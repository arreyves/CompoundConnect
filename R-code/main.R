library(plumber)

r <- plumb("rest_controller1.R")
r$run(port=80, host="0.0.0.0")