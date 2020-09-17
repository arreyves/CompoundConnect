library(tidymodels)
library(workflows)
library(tidyverse)
library(fs)


#### Load multiple files from the Raman Spec Analysis

file_paths <- fs::dir_ls('../Data')

file_paths


    