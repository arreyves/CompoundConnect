

####### Make a Plumber API to make predictions on polymer type ##########

# makr the model
source('cluster.R')

#* @get /spectral_data_frame & input_pair 

generate_input_pair <- function (x , input_pair){
  
  stopifnot(is.data.frame(x))  # check x is a data frame
  stopifnot(is.numeric(input_pair))  # check if numeric
  raman_spec <- x[input_pair,]
  new_spec <- tribble(~Raman_Shift, ~Intensity, raman_spec[1,1], raman_spec[1,2])
 
  # create model predicition
predict(final_model, generate_input_pair(new_plastic_spec,5))  
}

