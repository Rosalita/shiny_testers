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
    
    #generate the index to use
    index <- switch(input$exp, 
                   "less than a year" = { print("less that a year selected")
                                          make_index("less than a year", col)
                    },
                   
                   "1 - 2 years" = { print("1 - 2 years selected")
                                     make_index("less than a year", col)
                     },
                   "2 - 5 years" = make_index("less than a year", col),
                   "5 - 10 years" = make_index("less than a year", col),
                   "10 - 20 years" =  make_index("less than a year", col),
                   "More than 20 years" =  make_index("less than a year", col)
    )
       
    print(index)
                     
    #make_index(input, col)
    
   #happy_plot(data)
  })
  
  
})

