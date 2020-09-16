library(ggplot2)
library(MASS)
library(shiny)
library(tidyverse)

##Load Data and the helper functions
source("helper.R")
source('select_fibers.R')
all_spectra <- read.csv("~/combined_plastic_spectra.csv")
myDataFrame <- all_spectra

##these functions return the categorical variables and
##the numeric variables, given a data.frame
##They're in helper.R

categoricalVars <- get_category_variables(myDataFrame)
numericVars <- get_numeric_variables(myDataFrame)
Intensity <- all_spectra$Intensity
Raman_Shift <- all_spectra$Raman_Shift
Polymer_type <- all_spectra$Plastic_type

##Define UI for application that plots spectra

ui <- shinyUI(
  fluidPage(sidebarLayout(
    fileInput("file1", "Choose csv file to upload", accept = ".csv"),
    selectInput("x_variable","Select X Variable",numericVars, 
                selected=numericVars[1]),
    selectInput("y_variable", "Select Y Variable", numericVars, 
                selected = numericVars[2]),

    selectInput("polymer_variable", "Select polymer Variable", 
    #            names(categoricalVars), 
    #            selected = names(categoricalVars[1])),
    
    plotOutput("scatter_plot")
  )
)

server <- function(input, output, session) {
  
  myData <- reactive({
    inFile <- input$file1
    ##need to test whether input$file1 is null or not
    if (is.null(inFile)) {
      d <- myDataFrame
    } else {
      d <- read.csv(inFile$datapath)
    }
    return(d)
  })
  
  output$scatter_plot <- renderPlot({
    ggplot(myData(), aes_string(y=input$y_variable, 
                                       x=input$x_variable# uncomment this line and next line for step 4, 
                                      # color=input$color_variable
                                       
                                    )) +  geom_point() 

  })
  
  
  ##observe runs the code whenever myData() changes
  observe({
    #get the new numeric variables when the data is loaded
    num_vars <- get_numeric_variables(myData())
    
    ##update the selectInput with choices
    updateSelectInput(session, "x_variable",
                      choices = num_vars,
                      selected = num_vars[1])
    ##make the selected different for y_variable
    updateSelectInput(session, "y_variable", 
                      choices=num_vars,
                      selected= num_vars[2])
    
    ##get the new categorical variables when the data is loaded
    #uncomment here for step 4
    #cat_vars <- names(get_category_variables(myData()))
    
    ##update selectInput("color_variable") with the new categorical
    ##variables

    #uncomment here for step 4
    #updateSelectInput(session, "color_variable",
    #choices=cat_vars,
    #                  selected=cat_vars[1])
    
  })
  

}

shinyApp(ui, server)
