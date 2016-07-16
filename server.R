##############################
# A shiny web app - server.R #
##############################

#setwd ("/Dev/Git/shiny_testers")
setwd("/git/shiny_testers")

#Read data
mydata <- read.csv("/git/shiny_testers/data/survey_results_raw.csv", header = TRUE, sep =",")

#Include the R code in helper.R
source("helper.R")

library(shiny) # load shiny


shinyServer(function(input, output){
 
  output$text1 <- renderText({ 
    
  
    data <- switch(input$exp, 
                   "1" = happylessthanone,
                   "2" = happyonetotwo,
                   "3" = happytwotofive,
                   "4" = happyfivetoten,
                   "5" = happytentotwenty,
                   "6" = happytwentyplus)
    
    paste(input$exp)
    
  })
  
  
  output$plot <- renderPlot({
   happy_plot(data)
  })
  
  
})

