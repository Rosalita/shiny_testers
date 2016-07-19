##############################
# A shiny web app - server.R #
##############################

setwd ("/Dev/Git/shiny_testers")
#setwd("/git/shiny_testers")

#Read data
mydata <- read.csv("C:/Dev/Git/shiny_testers/data/survey_results_raw.csv", header = TRUE, sep =",")
#mydata <- read.csv("/git/shiny_testers/data/survey_results_raw.csv", header = TRUE, sep =",")

#Include the R code in helper.R
source("helper.R")

library(shiny) # load shiny


shinyServer(function(input, output){
 
  output$text1 <- renderText({ 
  
    paste0(input$exp)
    
  })
  
  
  output$plot <- renderPlot({
    if(is.null(input$exp))
      return()


    #print(input$exp) # list of all items currently selected
    #print(length(input$exp)) # total number of boxes checks
    #print(input$exp[1]) # name of first item in list of currently selected items
    #print(input$exp[length(input$exp)]) # name of last item in list of currently selected items
    #print(input$exp[1:length(input$exp)]) # list of all items currently selected
    
    #column containing experience data is 14
    col <- 14
    
    index_to_plot <- make_index(input$exp,col)
    
    
   
    data_to_plot <- apply_index_to_happy(index_to_plot)
  
      
    happy_plot(data_to_plot)
  })
  
  
})

