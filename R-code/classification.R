##We will be begin by examining some numerical and graphical siummaries of the spectral data
##which is being developed in CompoundConnect libraries.

####plot of each individual spectra ###

Plastic_type <- function(input1,input2){
  
  temp <- read.csv(list.files(pattern = "input1.csv",full.names = T ))  #read input1
  temp1 <- temp %>% select(R_Shift, Intensity, Plastic_type) %>% 
  filter(Plastic_type == input2)
 
   temp1 %>% select(R_Shift, Intensity) %>% 
  ggplot(aes(x = R_Shift, y = Intensity)) + geom_line()+ geom_point()

   }

Plastic_type(combined_plastic_spectra.csv, )

train <- all_spectra[c(1:400),]

Plastic_type.train <- train[,3]

train <- as.vector(train)

lda(Plastic_type ~ R_Shift + Intensity, data = all_spectra, subset = test)
