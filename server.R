##############################
# A shiny web app - server.R #
##############################

#setwd ("/Dev/Git/shiny_testers")
setwd("/git/shiny_testers")

#Read data
#mydata <- read.csv("C:/Dev/Git/shiny_testers/data/survey_results_raw.csv", header = TRUE, sep =",")
mydata <- read.csv("/git/shiny_testers/data/survey_results_raw.csv", header = TRUE, sep =",")

#Include the R code in helper.R
source("helper.R")

library(shiny) # load shiny


shinyServer(function(input, output){
 
  output$text1 <- renderText({ 
    
    #column containing experience data is 14
    col <- 14
    
    index_to_plot <- make_index(input$exp,col)
    
    #column containing happiness index is 54
    data_to_plot <- apply_index(index_to_plot, 54)
    
    paste0(data_to_plot)
  })
  
  
  output$happyplot <- renderPlot({
    if(is.null(input$exp))
      return()

    #column containing experience data is 14
    col <- 14
    
    index_to_plot <- make_index(input$exp,col)
    
    #column containing happiness index is 54
    data <- apply_index(index_to_plot, 54)
    
    happy_plot(data)
  })
  
  output$expectations <- renderPlot({
    
    #column containing experience data is 14
    col <- 14
    index_to_plot <- make_index(input$exp, col)
    
    #column containing expectations data is 30
    data <- apply_index(index_to_plot, 30)
    
    make_bar(data, "Testing expectations \nplaced upon me \nare achievable")
  })
  
  output$team <- renderPlot({
    
    #column containing experience data is 14
    col <- 14
    index_to_plot <- make_index(input$exp, col)
    
    #column containing team data is 31
    data <- apply_index(index_to_plot, 31)
    
    make_bar(data, "I feel like part\n of the team")
  })
  
  output$decisions <- renderPlot({
    
    #column containing experience data is 14
    col <- 14
    index_to_plot <- make_index(input$exp, col)
    
    #column containing decision data is 32
    data <- apply_index(index_to_plot, 32)
    
    make_bar(data, "I am usually \nexcluded when \ndecisions are made")
  })
  
  
})

