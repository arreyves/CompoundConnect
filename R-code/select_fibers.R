
## load objects into memory for polymers extracted
all_spectra %>% select(Raman_Shift,Intensity,Plastic_type) -> temp
  
  Green_Yarn <- temp %>% filter(Plastic_type == 'Green_Yarn')%>% 
    select(Raman_Shift,Intensity)
  Red_Yarn <- temp %>% filter (Plastic_type == 'Red_Yarn') %>%
    select(Raman_Shift,Intensity)
    
    Yellow_Yarn <- temp %>% filter (Plastic_type == 'Yellow_Yarn')%>%
    select(Raman_Shift,Intensity)
    
    Purple_Yarn <- temp %>% filter (Plastic_type == 'Purple_Yarn')%>%
    select(Raman_Shift,Intensity)
    
    Pink_Yarn <- temp %>% filter (Plastic_type == 'Pink_Yarn') %>%
    select(Raman_Shift,Intensity)
    
    Orange_Yarn <- temp %>% filter (Plastic_type == 'Orange_Yarn')%>%
    select(Raman_Shift,Intensity)
    
    White_Yarn <- temp %>% filter (Plastic_type == 'White_Yarn')%>%
    select(Raman_Shift,Intensity)
    
    Orange_Fiber <- temp %>% filter (Plastic_type == 'Orange_Fiber')%>%
    select(Raman_Shift,Intensity)
    
    Yellow_Fiber <- temp %>% filter (Plastic_type == 'Yellow_Fiber')%>%
    select(Raman_Shift,Intensity)
    
    Pink_Fiber <- temp %>% filter (Plastic_type == 'Pink_Fiber')%>%
    select(Raman_Shift,Intensity)
    
    