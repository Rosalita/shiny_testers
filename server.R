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
    
    #column containing experience data is 14
    col <- 14
    
    index_to_plot <- make_index(input$exp,col)
    
    data_to_plot <- apply_index_to_happy(index_to_plot)
    
    paste0(data_to_plot)
  })
  
  
  output$plot <- renderPlot({
    if(is.null(input$exp))
      return()

    #column containing experience data is 14
    col <- 14
    
    index_to_plot <- make_index(input$exp,col)
    
    data <- apply_index_to_happy(index_to_plot)
    
    happy_plot(data)
  })
  
  
})

