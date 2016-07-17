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
    
  
    paste(input$exp)
    
  })
  
  
  output$plot <- renderPlot({
    
    data <- switch(input$exp, 
                   "1" = as.numeric(happylessthanone),
                   "2" = as.numeric(happyonetotwo),
                   "3" = as.numeric(happytwotofive),
                   "4" = as.numeric(happyfivetoten),
                   "5" = as.numeric(happytentotwenty),
                   "6" = as.numeric(happytwentyplus))
    
    
   happy_plot(data)
  })
  
  
})

