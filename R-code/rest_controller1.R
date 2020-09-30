

####### Make a Plumber API to make predictions on polymer type ##########

# make the model
#source('cluster.R')

#<<<<<<< HEAD
#* @get /input_pair 
#=======
#* @get /spectral_dataframe_&_input_pair 
#>>>>>>> 394bd2f6d6d7e33c59cc48490e4ff415d2c93cc1



generate_input_pair <- function (x , input_pair){

  

  stopifnot(is.data.frame(x))  # check x is a data frame
  stopifnot(is.numeric(input_pair))  # check if numeric
  raman_spec <- x[input_pair,]
  new_spec <- tribble(~Raman_Shift, ~Intensity, raman_spec[1,1], raman_spec[1,2])
 
  # create model predicition
predict(final_model, generate_input_pair(new_plastic_spec,5))  
}

