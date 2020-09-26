library(tidymodels)
library(workflows)
library(tidyverse)
library(fs)


#### Load new files from the Raman Spec Analysis
############ Create new input data for the classification


file_paths <- fs::dir_ls('~/Data')

file_paths <- file_paths[1:7]

# 1.0 FOR LOOP ----

file_contents <- list()

for (i in seq_along(file_paths)) {
  file_contents[[i]] <- read.table(
    file = file_paths[[i]]
  )
}

file_contents <- set_names(file_contents, file_paths)

file_contents[1:7]

file_contents %>%  
  map_df(function(x) {
    as.data.frame(x)
    print(x)
      }) -> tmp

new_plastic_spec <- rename(tmp, Raman_shift = 'V1', Intensity = 'V2') 

##### Generate input pair from Raman Spec for predicition #############

#generate_input_pair <- function (x , input_pair){

#stopifnot(is.data.frame(x))  # check x is a data frame
#  stopifnot(is.numeric(input_pair))  # check if numeric
#  raman_spec <- x[input_pair,]
#  new_spec <- tribble(~Raman_Shift, ~Intensity, raman_spec[1,1], raman_spec[1,2])
          
#  print(new_spec)
#}

######### Function to predict polymer type based on Raman Spec Input data



#predict(final_model, generate_input_pair(x,input_pair))



    