

####### Make a Plumber API to make predictions on polymer type ##########

## Make model predictions

generate_input_pair <- function (x , input_pair){
  
  stopifnot(is.data.frame(x))  # check x is a data frame
  stopifnot(is.numeric(input_pair))  # check if numeric
  raman_spec <- x[input_pair,]
  new_spec <- tribble(~Raman_Shift, ~Intensity, raman_spec[1,1], raman_spec[1,2])
  
}

predict(final_model, generate_input_pair(new_plastic_spec,5)) 