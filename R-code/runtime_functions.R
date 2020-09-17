library(tidymodels)
library(workflows)
library(tidyverse)
library(fs)


#### Load multiple files from the Raman Spec Analysis

file_paths <- fs::dir_ls('../Data')

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

############ Create new Data frame for Testing


new_plastic_spec <- rename(tmp, Raman_shift = 'V1', Intensity = 'V2') %>% head()



    