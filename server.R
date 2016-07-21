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
    col1 <- 14
    
    #column containing are you happy in current job is 8
    col2 <- 8
    
    index_to_plot <- make_index(input$exp,input$happy,col1,col2)
    
    
    #column containing happiness index is 54
    data_to_plot <- apply_index(index_to_plot, 54)
    
    paste0(data_to_plot)
  })
  
  
  output$happyplot <- renderPlot({
    if(is.null(input$exp))
      return()

    #column containing experience data is 14
    col1 <- 14
    
    #column containing are you happy in current job is 8
    col2 <- 8
    
    index_to_plot <- make_index(input$exp,input$happy,col1,col2)
    
    #column containing happiness index is 54
    data <- apply_index(index_to_plot, 54)
    
    happy_plot(data)
  })
  
  output$expectations <- renderPlot({
    
    #column containing experience data is 14
    col1 <- 14
    #column containing are you happy in current job is 8
    col2 <- 8
    
    index_to_plot <- make_index(input$exp,input$happy,col1,col2)
    
    #column containing expectations data is 30
    data <- apply_index(index_to_plot, 30)
    
    make_bar(data, "Testing expectations \nplaced upon me \nare achievable")
  })
  
  output$team <- renderPlot({
    
    #column containing experience data is 14
    col1 <- 14
    #column containing are you happy in current job is 8
    col2 <- 8
    
    index_to_plot <- make_index(input$exp,input$happy,col1,col2)
    
    #column containing team data is 31
    data <- apply_index(index_to_plot, 31)
    
    make_bar(data, "I feel like part\n of the team")
  })
  
  output$decisions <- renderPlot({
    
    #column containing experience data is 14
    col1 <- 14
    #column containing are you happy in current job is 8
    col2 <- 8
    
    index_to_plot <- make_index(input$exp,input$happy,col1,col2)
    
    #column containing decision data is 32
    data <- apply_index(index_to_plot, 32)
    
    make_bar(data, "I am usually \nexcluded when \ndecisions are made")
  })
  
  output$cares <- renderPlot({
    
    #column containing experience data is 14
    col1 <- 14
    #column containing are you happy in current job is 8
    col2 <- 8
    
    index_to_plot <- make_index(input$exp,input$happy,col1,col2)
    
    #column containing cares data is 33
    data <- apply_index(index_to_plot, 33)
    
    make_bar(data, "Absolutely everyone \nI work with cares \nabout quality")
  })
  
  output$auto <- renderPlot({
    
    #column containing experience data is 14
    col1 <- 14
    #column containing are you happy in current job is 8
    col2 <- 8
    
    index_to_plot <- make_index(input$exp,input$happy,col1,col2)
    
    #column containing auto data is 34
    data <- apply_index(index_to_plot, 34)
    
    make_bar(data, "There is no \nautomated testing")
  })
  
  output$bugcount <- renderPlot({
    
    #column containing experience data is 14
    col1 <- 14
    #column containing are you happy in current job is 8
    col2 <- 8
    
    index_to_plot <- make_index(input$exp,input$happy,col1,col2)
    
    #column containing bug count data is 35
    data <- apply_index(index_to_plot, 35)
    
    make_bar(data, "My performance is \nmeasured using metrics \nlike bug count")
  })
  
  output$tools <- renderPlot({
    
    #column containing experience data is 14
    col1 <- 14
    #column containing are you happy in current job is 8
    col2 <- 8
    
    index_to_plot <- make_index(input$exp,input$happy,col1,col2)
    
    #column containing bug count data is 36
    data <- apply_index(index_to_plot, 36)
    
    make_bar(data, "I have access to \nall the tools and \nresources I require")
  })
  
  output$tech <- renderPlot({
    
    #column containing experience data is 14
    col1 <- 14
    #column containing are you happy in current job is 8
    col2 <- 8
    
    index_to_plot <- make_index(input$exp,input$happy,col1,col2)
    
    #column containing tech data is 37
    data <- apply_index(index_to_plot, 37)
    
    make_bar(data, "I feel my employer\n values my \ntechnical skills")
  })
  
  output$kept_in_dark <- renderPlot({
    
    #column containing experience data is 14
    col1 <- 14
    #column containing are you happy in current job is 8
    col2 <- 8
    
    index_to_plot <- make_index(input$exp,input$happy,col1,col2)
    
    #column containing kept in dark data is 38
    data <- apply_index(index_to_plot, 38)
    
    make_bar(data, "People dont share\n important information \nwith me")
  })
  
  output$collaboration <- renderPlot({
    
    #column containing experience data is 14
    col1 <- 14
    #column containing are you happy in current job is 8
    col2 <- 8
    
    index_to_plot <- make_index(input$exp,input$happy,col1,col2)
    
    #column containing collaboration data is 39
    data <- apply_index(index_to_plot, 39)
    
    make_bar(data, "I get to work \ncollaboratively \nwith others")
  })
  
  output$techdebt <- renderPlot({
    
    #column containing experience data is 14
    col1 <- 14
    #column containing are you happy in current job is 8
    col2 <- 8
    
    index_to_plot <- make_index(input$exp,input$happy,col1,col2)
    
    #column containing techdebt data is 40
    data <- apply_index(index_to_plot, 40)
    
    make_bar(data, "Technical debt is \ntaken seriously \nand addressed")
  })
  
  output$progress <- renderPlot({
    
    #column containing experience data is 14
    col1 <- 14
    #column containing are you happy in current job is 8
    col2 <- 8
    
    index_to_plot <- make_index(input$exp,input$happy,col1,col2)
    
    #column containing progress data is 41
    data <- apply_index(index_to_plot, 41)
    
    make_bar(data, "I feel there are \nopportunities for \nme to progress")
  })
  output$appreciate <- renderPlot({
    
    #column containing experience data is 14
    col1 <- 14
    #column containing are you happy in current job is 8
    col2 <- 8
    
    index_to_plot <- make_index(input$exp,input$happy,col1,col2)
    
    #column containing appreciate data is 42
    data <- apply_index(index_to_plot, 42)
    
    make_bar(data, "People at work don't\n appreciate the role \ntesting plays")
  })
  
  output$loyal <- renderPlot({
    
    #column containing experience data is 14
    col1 <- 14
    #column containing are you happy in current job is 8
    col2 <- 8
    
    index_to_plot <- make_index(input$exp,input$happy,col1,col2)
    
    #column containing loyal data is 43
    data <- apply_index(index_to_plot, 43)
    
    make_bar(data, "There are high \nlevels of staff \nretention")
  })
  
  output$trusted <- renderPlot({
    
    #column containing experience data is 14
    col1 <- 14
    #column containing are you happy in current job is 8
    col2 <- 8
    
    index_to_plot <- make_index(input$exp,input$happy,col1,col2)
    
    #column containing judgment data is 44
    data <- apply_index(index_to_plot, 44)
    
    make_bar(data, "When I make a \ndecision my judgment\n is trusted")
  })
  
  output$prodbreaks <- renderPlot({
    
    #column containing experience data is 14
    col1 <- 14
    #column containing are you happy in current job is 8
    col2 <- 8
    
    index_to_plot <- make_index(input$exp,input$happy,col1,col2)
    
    #column containing prod breaks data is 45
    data <- apply_index(index_to_plot, 45)
    
    make_bar(data, "Code in production\n frequently breaks \nand needs fixing")
  })
  
  output$unpaid <- renderPlot({
    
    #column containing experience data is 14
    col1 <- 14
    #column containing are you happy in current job is 8
    col2 <- 8
    
    index_to_plot <- make_index(input$exp,input$happy,col1,col2)
    
    #column containing unpaid data is 46
    data <- apply_index(index_to_plot, 46)
    
    make_bar(data, "I am expected \nto work unpaid \novertime")
  })
  
  output$dev <- renderPlot({
    
    #column containing experience data is 14
    col1 <- 14
    #column containing are you happy in current job is 8
    col2 <- 8
    
    index_to_plot <- make_index(input$exp,input$happy,col1,col2)
    
    #column containing dev data is 47
    data <- apply_index(index_to_plot, 47)
    
    make_bar(data, "At work developers\n are seen as superior\n to testers")
  })
  
  output$sign <- renderPlot({
    
    #column containing experience data is 14
    col1 <- 14
    #column containing are you happy in current job is 8
    col2 <- 8
    
    index_to_plot <- make_index(input$exp,input$happy,col1,col2)
    
    #column containing sign data is 48
    data <- apply_index(index_to_plot, 48)
    
    make_bar(data, "I am forced to\n sign off that there\n are no bugs")
  })
  
  output$train <- renderPlot({
    
    #column containing experience data is 14
    col1 <- 14
    #column containing are you happy in current job is 8
    col2 <- 8
    
    index_to_plot <- make_index(input$exp,input$happy,col1,col2)
    
    #column containing sign data is 49
    data <- apply_index(index_to_plot, 49)
    
    make_bar(data, "My company supports \nme with training \ncourses and conferences")
  })
  
  output$difference <- renderPlot({
    
    #column containing experience data is 14
    col1 <- 14
    #column containing are you happy in current job is 8
    col2 <- 8
    
    index_to_plot <- make_index(input$exp,input$happy,col1,col2)
    
    #column containing difference data is 50
    data <- apply_index(index_to_plot, 50)
    
    make_bar(data, "I feel like \nI am making a \npositive difference")
  })
  
  output$management <- renderPlot({
    
    #column containing experience data is 14
    col1 <- 14
    #column containing are you happy in current job is 8
    col2 <- 8
    
    index_to_plot <- make_index(input$exp,input$happy,col1,col2)
    
    #column containing management data is 51
    data <- apply_index(index_to_plot, 51)
    
    make_bar(data, "Management does\n not understand\n testing")
  })
  
  output$time <- renderPlot({
    
    #column containing experience data is 14
    col1 <- 14
    #column containing are you happy in current job is 8
    col2 <- 8
    
    index_to_plot <- make_index(input$exp,input$happy,col1,col2)
    
    #column containing time data is 52
    data <- apply_index(index_to_plot, 52)
    
    make_bar(data, "There is not enough\n time to test things\n satisfactorily")
  })
  
  output$blamed <- renderPlot({
    
    #column containing experience data is 14
    col1 <- 14
    #column containing are you happy in current job is 8
    col2 <- 8
    
    index_to_plot <- make_index(input$exp,input$happy,col1,col2)
    
    #column containing blamed data is 53
    data <- apply_index(index_to_plot, 53)
    
    make_bar(data, "I am blamed\n for missed bugs")
  })
  
  
})

