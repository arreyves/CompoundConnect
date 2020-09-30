# AbbaTek Group ---
# AquaHacking 2020 ---
# Polymer Analyzer App -- LAYOUT ---
# Version 1

# APPLICATION DESCRIPTION ----
# Create a basic layout in shiny showing the stock dropdown, interactive plot and commentary


# Load Libraries ----

library(shiny)
library(shinyWidgets)

library(plotly)
library(tidyquant)
library(tidyverse)

#source('cluster.R')
#load('final_model.RData')    # either run analysis file or just load the data and continue with the analyses
plastic_spec_orig <- read.csv('~/GitReps/Microplastics/CompoundConnect/Data/combined_plastic_spectra.csv', stringsAsFactors = F)

plastic_spec_df <- plastic_spec_orig %>% group_by(Plastic_type)

# UI ----

ui <- fluidPage(
      title = "Polymer Analyzer in Microplastics",
      
      # 1.0 HEADER ----
      div (
        h1("Polymer Analyser", "by AbbaTek Group"),           # we created a header here
        p("This is the first prototype completed for the finals", "AquaHacking Lake Winnipeg 2020")     # we created a paragraph here with a header descriptoin
      ),
    
    # 2.0 APPLICATION UI ----
    div (
    column(
      width = 4,
      wellPanel(
           pickerInput(
             inputId = "Plastic_type", 
             label = "Select plastic type to analyse",
             choices = plastic_spec_df$Plastic_type,
             multiple = FALSE                                       # could select multiple plastic types with TRUE
          )
        )
    ),
     column(width = 8, "Plot")
    
    )
 )
      
# SERVER  -----

server <- function(input, output, session) {
  
}

# RUN APP ----
shinyApp(ui = ui, server = server)