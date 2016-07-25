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


#define some columns used for creating indexes
#column containing experience data is 14
col1 <- 14
#column containing are you happy in current job is 8
col2 <- 8
#column containing quals is 17
col3 <- 17
#column containing computing is 18
col4 <- 18
#column containing testjob is 9
col5 <- 9
#column containing nottestjob is 10
col6 <- 10
#column containing different job is 16
col7 <- 16
#column containing want to be a tester while studying is 19
col8 <- 19

# order of inputs on UI - to do: server order match ui order
# "1. Testing Experience"
# "2. Highest Qualification"
# "3. States they studied computing"
# "4. States they are happy in current job"
# "5. Likelihood to seek a different testing job in next 12 months"
# "6. Likelihood to seek a job outside of testing in next 12 months"
# "7. States they held a different job prior to becoming a tester"
# "8. States they knew while studying they wanted to work in testing"

shinyServer(function(input, output){
 
  output$text1 <- renderText({ 
    
    #separate functions to generate each index needed
    exp_index <- make_exp_index(input$exp,col1)
    happy_index <- make_happy_index(input$happy,col2)
    quals_index <- make_quals_index(input$quals,col3)
    comp_index <- make_comp_index(input$comp, col4) 
    testjob_index <- make_testjob_index(input$testjob, col5)
    nottestjob_index <- make_nottestjob_index(input$nottestjob, col6)
    diffjob_index <- make_diffjob_index(input$diffjob, col7)
    study_index <- make_study_index(input$study, col8)
    
    #combine all indexes into a list
    list_of_indexes <- list(exp_index,
                            happy_index,
                            quals_index,
                            comp_index,
                            testjob_index,
                            nottestjob_index,
                            diffjob_index,
                            study_index)
      
    index_to_plot <- present_in_all(list_of_indexes)
    
    #column containing happiness index is 54
    data_to_plot <- apply_index(index_to_plot, 54)
   

    paste0(c("The selected group contains",length(index_to_plot), "testers"))
   
    
  })
  
  
  output$happyplot <- renderPlot({
    
    #if no checkboxes selected for experience, don't try to plot anything
    if(is.null(input$exp)){
      return()
    }
    #if no checkboxes selected for qualifications, don't try to plot anything
    if(is.null(input$quals)){
      return()
    }  

    #separate functions to generate each index needed
    exp_index <- make_exp_index(input$exp,col1)
    happy_index <- make_happy_index(input$happy,col2)
    quals_index <- make_quals_index(input$quals,col3)
    comp_index <- make_comp_index(input$comp, col4) 
    testjob_index <- make_testjob_index(input$testjob, col5)
    nottestjob_index <- make_nottestjob_index(input$nottestjob, col6)
    diffjob_index <- make_diffjob_index(input$diffjob, col7)
    study_index <- make_study_index(input$study, col8)
    
    #combine all indexes into a list
    list_of_indexes <- list(exp_index,
                            happy_index,
                            quals_index,
                            comp_index,
                            testjob_index,
                            nottestjob_index,
                            diffjob_index,
                            study_index)
    
    index_to_plot <- present_in_all(list_of_indexes)
    
    #if the index to plot contains no values, don't try to plot anything
    if(length(index_to_plot) < 1){
      return()
    }
    
    #column containing happiness index is 54
    data_to_plot <- apply_index(index_to_plot, 54)
    
    happy_plot(data_to_plot)
  })
  
  output$expectations <- renderPlot({
    
    #separate functions to generate each index needed
    exp_index <- make_exp_index(input$exp,col1)
    happy_index <- make_happy_index(input$happy,col2)
    quals_index <- make_quals_index(input$quals,col3)
    comp_index <- make_comp_index(input$comp, col4) 
    testjob_index <- make_testjob_index(input$testjob, col5)
    nottestjob_index <- make_nottestjob_index(input$nottestjob, col6)
    diffjob_index <- make_diffjob_index(input$diffjob, col7)
    study_index <- make_study_index(input$study, col8)
    
    #combine all indexes into a list
    list_of_indexes <- list(exp_index,
                            happy_index,
                            quals_index,
                            comp_index,
                            testjob_index,
                            nottestjob_index,
                            diffjob_index,
                            study_index)
    
    index_to_plot <- present_in_all(list_of_indexes)
    
    #column containing expectations data is 30
    data <- apply_index(index_to_plot, 30)
    
    make_bar(data, "Testing expectations \nplaced upon me \nare achievable")
  })
  
  output$team <- renderPlot({
    
    #separate functions to generate each index needed
    exp_index <- make_exp_index(input$exp,col1)
    happy_index <- make_happy_index(input$happy,col2)
    quals_index <- make_quals_index(input$quals,col3)
    comp_index <- make_comp_index(input$comp, col4) 
    testjob_index <- make_testjob_index(input$testjob, col5)
    nottestjob_index <- make_nottestjob_index(input$nottestjob, col6)
    diffjob_index <- make_diffjob_index(input$diffjob, col7)
    study_index <- make_study_index(input$study, col8)
    
    #combine all indexes into a list
    list_of_indexes <- list(exp_index,
                            happy_index,
                            quals_index,
                            comp_index,
                            testjob_index,
                            nottestjob_index,
                            diffjob_index,
                            study_index)
    
    index_to_plot <- present_in_all(list_of_indexes)
    
    #column containing team data is 31
    data <- apply_index(index_to_plot, 31)
    
    make_bar(data, "I feel like part\n of the team")
  })
  
  output$decisions <- renderPlot({
    
    #separate functions to generate each index needed
    exp_index <- make_exp_index(input$exp,col1)
    happy_index <- make_happy_index(input$happy,col2)
    quals_index <- make_quals_index(input$quals,col3)
    comp_index <- make_comp_index(input$comp, col4) 
    testjob_index <- make_testjob_index(input$testjob, col5)
    nottestjob_index <- make_nottestjob_index(input$nottestjob, col6)
    diffjob_index <- make_diffjob_index(input$diffjob, col7)
    study_index <- make_study_index(input$study, col8)
    
    #combine all indexes into a list
    list_of_indexes <- list(exp_index,
                            happy_index,
                            quals_index,
                            comp_index,
                            testjob_index,
                            nottestjob_index,
                            diffjob_index,
                            study_index)
    
    index_to_plot <- present_in_all(list_of_indexes)
    
    #column containing decision data is 32
    data <- apply_index(index_to_plot, 32)
    
    make_bar(data, "I am usually \nexcluded when \ndecisions are made")
  })
  
  output$cares <- renderPlot({
    
    #separate functions to generate each index needed
    exp_index <- make_exp_index(input$exp,col1)
    happy_index <- make_happy_index(input$happy,col2)
    quals_index <- make_quals_index(input$quals,col3)
    comp_index <- make_comp_index(input$comp, col4) 
    testjob_index <- make_testjob_index(input$testjob, col5)
    nottestjob_index <- make_nottestjob_index(input$nottestjob, col6)
    diffjob_index <- make_diffjob_index(input$diffjob, col7)
    study_index <- make_study_index(input$study, col8)
    
    #combine all indexes into a list
    list_of_indexes <- list(exp_index,
                            happy_index,
                            quals_index,
                            comp_index,
                            testjob_index,
                            nottestjob_index,
                            diffjob_index,
                            study_index)
    
    index_to_plot <- present_in_all(list_of_indexes)
    
    #column containing cares data is 33
    data <- apply_index(index_to_plot, 33)
    
    make_bar(data, "Absolutely everyone \nI work with cares \nabout quality")
  })
  
  output$auto <- renderPlot({
    
    #separate functions to generate each index needed
    exp_index <- make_exp_index(input$exp,col1)
    happy_index <- make_happy_index(input$happy,col2)
    quals_index <- make_quals_index(input$quals,col3)
    comp_index <- make_comp_index(input$comp, col4) 
    testjob_index <- make_testjob_index(input$testjob, col5)
    nottestjob_index <- make_nottestjob_index(input$nottestjob, col6)
    diffjob_index <- make_diffjob_index(input$diffjob, col7)
    study_index <- make_study_index(input$study, col8)
    
    #combine all indexes into a list
    list_of_indexes <- list(exp_index,
                            happy_index,
                            quals_index,
                            comp_index,
                            testjob_index,
                            nottestjob_index,
                            diffjob_index,
                            study_index)
    
    index_to_plot <- present_in_all(list_of_indexes)
    
    #column containing auto data is 34
    data <- apply_index(index_to_plot, 34)
    
    make_bar(data, "There is no \nautomated testing")
  })
  
  output$bugcount <- renderPlot({
    
    #separate functions to generate each index needed
    exp_index <- make_exp_index(input$exp,col1)
    happy_index <- make_happy_index(input$happy,col2)
    quals_index <- make_quals_index(input$quals,col3)
    comp_index <- make_comp_index(input$comp, col4) 
    testjob_index <- make_testjob_index(input$testjob, col5)
    nottestjob_index <- make_nottestjob_index(input$nottestjob, col6)
    diffjob_index <- make_diffjob_index(input$diffjob, col7)
    study_index <- make_study_index(input$study, col8)
    
    #combine all indexes into a list
    list_of_indexes <- list(exp_index,
                            happy_index,
                            quals_index,
                            comp_index,
                            testjob_index,
                            nottestjob_index,
                            diffjob_index,
                            study_index)
    
    index_to_plot <- present_in_all(list_of_indexes)
    
    #column containing bug count data is 35
    data <- apply_index(index_to_plot, 35)
    
    make_bar(data, "My performance is \nmeasured using metrics \nlike bug count")
  })
  
  output$tools <- renderPlot({
    
    #separate functions to generate each index needed
    exp_index <- make_exp_index(input$exp,col1)
    happy_index <- make_happy_index(input$happy,col2)
    quals_index <- make_quals_index(input$quals,col3)
    comp_index <- make_comp_index(input$comp, col4) 
    testjob_index <- make_testjob_index(input$testjob, col5)
    nottestjob_index <- make_nottestjob_index(input$nottestjob, col6)
    diffjob_index <- make_diffjob_index(input$diffjob, col7)
    study_index <- make_study_index(input$study, col8)
    
    #combine all indexes into a list
    list_of_indexes <- list(exp_index,
                            happy_index,
                            quals_index,
                            comp_index,
                            testjob_index,
                            nottestjob_index,
                            diffjob_index,
                            study_index)
    
    index_to_plot <- present_in_all(list_of_indexes)
    
    #column containing bug count data is 36
    data <- apply_index(index_to_plot, 36)
    
    make_bar(data, "I have access to \nall the tools and \nresources I require")
  })
  
  output$tech <- renderPlot({
    
    #separate functions to generate each index needed
    exp_index <- make_exp_index(input$exp,col1)
    happy_index <- make_happy_index(input$happy,col2)
    quals_index <- make_quals_index(input$quals,col3)
    comp_index <- make_comp_index(input$comp, col4) 
    testjob_index <- make_testjob_index(input$testjob, col5)
    nottestjob_index <- make_nottestjob_index(input$nottestjob, col6)
    diffjob_index <- make_diffjob_index(input$diffjob, col7)
    study_index <- make_study_index(input$study, col8)
    
    #combine all indexes into a list
    list_of_indexes <- list(exp_index,
                            happy_index,
                            quals_index,
                            comp_index,
                            testjob_index,
                            nottestjob_index,
                            diffjob_index,
                            study_index)
    
    index_to_plot <- present_in_all(list_of_indexes)
    
    #column containing tech data is 37
    data <- apply_index(index_to_plot, 37)
    
    make_bar(data, "I feel my employer\n values my \ntechnical skills")
  })
  
  output$kept_in_dark <- renderPlot({
    
    #separate functions to generate each index needed
    exp_index <- make_exp_index(input$exp,col1)
    happy_index <- make_happy_index(input$happy,col2)
    quals_index <- make_quals_index(input$quals,col3)
    comp_index <- make_comp_index(input$comp, col4) 
    testjob_index <- make_testjob_index(input$testjob, col5)
    nottestjob_index <- make_nottestjob_index(input$nottestjob, col6)
    diffjob_index <- make_diffjob_index(input$diffjob, col7)
    study_index <- make_study_index(input$study, col8)
    
    #combine all indexes into a list
    list_of_indexes <- list(exp_index,
                            happy_index,
                            quals_index,
                            comp_index,
                            testjob_index,
                            nottestjob_index,
                            diffjob_index,
                            study_index)
    
    index_to_plot <- present_in_all(list_of_indexes)
    
    #column containing kept in dark data is 38
    data <- apply_index(index_to_plot, 38)
    
    make_bar(data, "People dont share\n important information \nwith me")
  })
  
  output$collaboration <- renderPlot({
    
    #separate functions to generate each index needed
    exp_index <- make_exp_index(input$exp,col1)
    happy_index <- make_happy_index(input$happy,col2)
    quals_index <- make_quals_index(input$quals,col3)
    comp_index <- make_comp_index(input$comp, col4) 
    testjob_index <- make_testjob_index(input$testjob, col5)
    nottestjob_index <- make_nottestjob_index(input$nottestjob, col6)
    diffjob_index <- make_diffjob_index(input$diffjob, col7)
    study_index <- make_study_index(input$study, col8)
    
    #combine all indexes into a list
    list_of_indexes <- list(exp_index,
                            happy_index,
                            quals_index,
                            comp_index,
                            testjob_index,
                            nottestjob_index,
                            diffjob_index,
                            study_index)
    
    index_to_plot <- present_in_all(list_of_indexes)
    
    #column containing collaboration data is 39
    data <- apply_index(index_to_plot, 39)
    
    make_bar(data, "I get to work \ncollaboratively \nwith others")
  })
  
  output$techdebt <- renderPlot({
    
    #separate functions to generate each index needed
    exp_index <- make_exp_index(input$exp,col1)
    happy_index <- make_happy_index(input$happy,col2)
    quals_index <- make_quals_index(input$quals,col3)
    comp_index <- make_comp_index(input$comp, col4) 
    testjob_index <- make_testjob_index(input$testjob, col5)
    nottestjob_index <- make_nottestjob_index(input$nottestjob, col6)
    diffjob_index <- make_diffjob_index(input$diffjob, col7)
    study_index <- make_study_index(input$study, col8)
    
    #combine all indexes into a list
    list_of_indexes <- list(exp_index,
                            happy_index,
                            quals_index,
                            comp_index,
                            testjob_index,
                            nottestjob_index,
                            diffjob_index,
                            study_index)
    
    index_to_plot <- present_in_all(list_of_indexes)
    
    #column containing techdebt data is 40
    data <- apply_index(index_to_plot, 40)
    
    make_bar(data, "Technical debt is \ntaken seriously \nand addressed")
  })
  
  output$progress <- renderPlot({
    
    #separate functions to generate each index needed
    exp_index <- make_exp_index(input$exp,col1)
    happy_index <- make_happy_index(input$happy,col2)
    quals_index <- make_quals_index(input$quals,col3)
    comp_index <- make_comp_index(input$comp, col4) 
    testjob_index <- make_testjob_index(input$testjob, col5)
    nottestjob_index <- make_nottestjob_index(input$nottestjob, col6)
    diffjob_index <- make_diffjob_index(input$diffjob, col7)
    study_index <- make_study_index(input$study, col8)
    
    #combine all indexes into a list
    list_of_indexes <- list(exp_index,
                            happy_index,
                            quals_index,
                            comp_index,
                            testjob_index,
                            nottestjob_index,
                            diffjob_index,
                            study_index)
    
    index_to_plot <- present_in_all(list_of_indexes)
    
    #column containing progress data is 41
    data <- apply_index(index_to_plot, 41)
    
    make_bar(data, "I feel there are \nopportunities for \nme to progress")
  })
  output$appreciate <- renderPlot({
   
    #separate functions to generate each index needed
    exp_index <- make_exp_index(input$exp,col1)
    happy_index <- make_happy_index(input$happy,col2)
    quals_index <- make_quals_index(input$quals,col3)
    comp_index <- make_comp_index(input$comp, col4) 
    testjob_index <- make_testjob_index(input$testjob, col5)
    nottestjob_index <- make_nottestjob_index(input$nottestjob, col6)
    diffjob_index <- make_diffjob_index(input$diffjob, col7)
    study_index <- make_study_index(input$study, col8)
    
    #combine all indexes into a list
    list_of_indexes <- list(exp_index,
                            happy_index,
                            quals_index,
                            comp_index,
                            testjob_index,
                            nottestjob_index,
                            diffjob_index,
                            study_index)
    
    index_to_plot <- present_in_all(list_of_indexes)
    
    #column containing appreciate data is 42
    data <- apply_index(index_to_plot, 42)
    
    make_bar(data, "People at work don't\n appreciate the role \ntesting plays")
  })
  
  output$loyal <- renderPlot({
    
    #separate functions to generate each index needed
    exp_index <- make_exp_index(input$exp,col1)
    happy_index <- make_happy_index(input$happy,col2)
    quals_index <- make_quals_index(input$quals,col3)
    comp_index <- make_comp_index(input$comp, col4) 
    testjob_index <- make_testjob_index(input$testjob, col5)
    nottestjob_index <- make_nottestjob_index(input$nottestjob, col6)
    diffjob_index <- make_diffjob_index(input$diffjob, col7)
    study_index <- make_study_index(input$study, col8)
    
    #combine all indexes into a list
    list_of_indexes <- list(exp_index,
                            happy_index,
                            quals_index,
                            comp_index,
                            testjob_index,
                            nottestjob_index,
                            diffjob_index,
                            study_index)
    
    index_to_plot <- present_in_all(list_of_indexes)
    
    #column containing loyal data is 43
    data <- apply_index(index_to_plot, 43)
    
    make_bar(data, "There are high \nlevels of staff \nretention")
  })
  
  output$trusted <- renderPlot({
    
    #separate functions to generate each index needed
    exp_index <- make_exp_index(input$exp,col1)
    happy_index <- make_happy_index(input$happy,col2)
    quals_index <- make_quals_index(input$quals,col3)
    comp_index <- make_comp_index(input$comp, col4) 
    testjob_index <- make_testjob_index(input$testjob, col5)
    nottestjob_index <- make_nottestjob_index(input$nottestjob, col6)
    diffjob_index <- make_diffjob_index(input$diffjob, col7)
    study_index <- make_study_index(input$study, col8)
    
    #combine all indexes into a list
    list_of_indexes <- list(exp_index,
                            happy_index,
                            quals_index,
                            comp_index,
                            testjob_index,
                            nottestjob_index,
                            diffjob_index,
                            study_index)
    
    index_to_plot <- present_in_all(list_of_indexes)
    
    #column containing judgment data is 44
    data <- apply_index(index_to_plot, 44)
    
    make_bar(data, "When I make a \ndecision my judgment\n is trusted")
  })
  
  output$prodbreaks <- renderPlot({
    
    #separate functions to generate each index needed
    exp_index <- make_exp_index(input$exp,col1)
    happy_index <- make_happy_index(input$happy,col2)
    quals_index <- make_quals_index(input$quals,col3)
    comp_index <- make_comp_index(input$comp, col4) 
    testjob_index <- make_testjob_index(input$testjob, col5)
    nottestjob_index <- make_nottestjob_index(input$nottestjob, col6)
    diffjob_index <- make_diffjob_index(input$diffjob, col7)
    study_index <- make_study_index(input$study, col8)
    
    #combine all indexes into a list
    list_of_indexes <- list(exp_index,
                            happy_index,
                            quals_index,
                            comp_index,
                            testjob_index,
                            nottestjob_index,
                            diffjob_index,
                            study_index)
    
    index_to_plot <- present_in_all(list_of_indexes)
    
    #column containing prod breaks data is 45
    data <- apply_index(index_to_plot, 45)
    
    make_bar(data, "Code in production\n frequently breaks \nand needs fixing")
  })
  
  output$unpaid <- renderPlot({
    
    #separate functions to generate each index needed
    exp_index <- make_exp_index(input$exp,col1)
    happy_index <- make_happy_index(input$happy,col2)
    quals_index <- make_quals_index(input$quals,col3)
    comp_index <- make_comp_index(input$comp, col4) 
    testjob_index <- make_testjob_index(input$testjob, col5)
    nottestjob_index <- make_nottestjob_index(input$nottestjob, col6)
    diffjob_index <- make_diffjob_index(input$diffjob, col7)
    study_index <- make_study_index(input$study, col8)
    
    #combine all indexes into a list
    list_of_indexes <- list(exp_index,
                            happy_index,
                            quals_index,
                            comp_index,
                            testjob_index,
                            nottestjob_index,
                            diffjob_index,
                            study_index)
    
    index_to_plot <- present_in_all(list_of_indexes)
    
    #column containing unpaid data is 46
    data <- apply_index(index_to_plot, 46)
    
    make_bar(data, "I am expected \nto work unpaid \novertime")
  })
  
  output$dev <- renderPlot({
    
    #separate functions to generate each index needed
    exp_index <- make_exp_index(input$exp,col1)
    happy_index <- make_happy_index(input$happy,col2)
    quals_index <- make_quals_index(input$quals,col3)
    comp_index <- make_comp_index(input$comp, col4) 
    testjob_index <- make_testjob_index(input$testjob, col5)
    nottestjob_index <- make_nottestjob_index(input$nottestjob, col6)
    diffjob_index <- make_diffjob_index(input$diffjob, col7)
    study_index <- make_study_index(input$study, col8)
    
    #combine all indexes into a list
    list_of_indexes <- list(exp_index,
                            happy_index,
                            quals_index,
                            comp_index,
                            testjob_index,
                            nottestjob_index,
                            diffjob_index,
                            study_index)
    
    index_to_plot <- present_in_all(list_of_indexes)
    
    #column containing dev data is 47
    data <- apply_index(index_to_plot, 47)
    
    make_bar(data, "At work developers\n are seen as superior\n to testers")
  })
  
  output$sign <- renderPlot({
    
    #separate functions to generate each index needed
    exp_index <- make_exp_index(input$exp,col1)
    happy_index <- make_happy_index(input$happy,col2)
    quals_index <- make_quals_index(input$quals,col3)
    comp_index <- make_comp_index(input$comp, col4) 
    testjob_index <- make_testjob_index(input$testjob, col5)
    nottestjob_index <- make_nottestjob_index(input$nottestjob, col6)
    diffjob_index <- make_diffjob_index(input$diffjob, col7)
    study_index <- make_study_index(input$study, col8)
    
    #combine all indexes into a list
    list_of_indexes <- list(exp_index,
                            happy_index,
                            quals_index,
                            comp_index,
                            testjob_index,
                            nottestjob_index,
                            diffjob_index,
                            study_index)
    
    index_to_plot <- present_in_all(list_of_indexes)
    
    #column containing sign data is 48
    data <- apply_index(index_to_plot, 48)
    
    make_bar(data, "I am forced to\n sign off that there\n are no bugs")
  })
  
  output$train <- renderPlot({
    
    #separate functions to generate each index needed
    exp_index <- make_exp_index(input$exp,col1)
    happy_index <- make_happy_index(input$happy,col2)
    quals_index <- make_quals_index(input$quals,col3)
    comp_index <- make_comp_index(input$comp, col4) 
    testjob_index <- make_testjob_index(input$testjob, col5)
    nottestjob_index <- make_nottestjob_index(input$nottestjob, col6)
    diffjob_index <- make_diffjob_index(input$diffjob, col7)
    study_index <- make_study_index(input$study, col8)
    
    #combine all indexes into a list
    list_of_indexes <- list(exp_index,
                            happy_index,
                            quals_index,
                            comp_index,
                            testjob_index,
                            nottestjob_index,
                            diffjob_index,
                            study_index)
    
    index_to_plot <- present_in_all(list_of_indexes)
    
    #column containing sign data is 49
    data <- apply_index(index_to_plot, 49)
    
    make_bar(data, "My company supports \nme with training \ncourses and conferences")
  })
  
  output$difference <- renderPlot({
    
    #separate functions to generate each index needed
    exp_index <- make_exp_index(input$exp,col1)
    happy_index <- make_happy_index(input$happy,col2)
    quals_index <- make_quals_index(input$quals,col3)
    comp_index <- make_comp_index(input$comp, col4) 
    testjob_index <- make_testjob_index(input$testjob, col5)
    nottestjob_index <- make_nottestjob_index(input$nottestjob, col6)
    diffjob_index <- make_diffjob_index(input$diffjob, col7)
    study_index <- make_study_index(input$study, col8)
    
    #combine all indexes into a list
    list_of_indexes <- list(exp_index,
                            happy_index,
                            quals_index,
                            comp_index,
                            testjob_index,
                            nottestjob_index,
                            diffjob_index,
                            study_index)
    
    index_to_plot <- present_in_all(list_of_indexes)
    
    #column containing difference data is 50
    data <- apply_index(index_to_plot, 50)
    
    make_bar(data, "I feel like \nI am making a \npositive difference")
  })
  
  output$management <- renderPlot({
    
    #separate functions to generate each index needed
    exp_index <- make_exp_index(input$exp,col1)
    happy_index <- make_happy_index(input$happy,col2)
    quals_index <- make_quals_index(input$quals,col3)
    comp_index <- make_comp_index(input$comp, col4) 
    testjob_index <- make_testjob_index(input$testjob, col5)
    nottestjob_index <- make_nottestjob_index(input$nottestjob, col6)
    diffjob_index <- make_diffjob_index(input$diffjob, col7)
    study_index <- make_study_index(input$study, col8)
    
    #combine all indexes into a list
    list_of_indexes <- list(exp_index,
                            happy_index,
                            quals_index,
                            comp_index,
                            testjob_index,
                            nottestjob_index,
                            diffjob_index,
                            study_index)
    
    index_to_plot <- present_in_all(list_of_indexes)
    
    #column containing management data is 51
    data <- apply_index(index_to_plot, 51)
    
    make_bar(data, "Management does\n not understand\n testing")
  })
  
  output$time <- renderPlot({
    
    #separate functions to generate each index needed
    exp_index <- make_exp_index(input$exp,col1)
    happy_index <- make_happy_index(input$happy,col2)
    quals_index <- make_quals_index(input$quals,col3)
    comp_index <- make_comp_index(input$comp, col4) 
    testjob_index <- make_testjob_index(input$testjob, col5)
    nottestjob_index <- make_nottestjob_index(input$nottestjob, col6)
    diffjob_index <- make_diffjob_index(input$diffjob, col7)
    study_index <- make_study_index(input$study, col8)
    
    #combine all indexes into a list
    list_of_indexes <- list(exp_index,
                            happy_index,
                            quals_index,
                            comp_index,
                            testjob_index,
                            nottestjob_index,
                            diffjob_index,
                            study_index)
    
    index_to_plot <- present_in_all(list_of_indexes)
    
    #column containing time data is 52
    data <- apply_index(index_to_plot, 52)
    
    make_bar(data, "There is not enough\n time to test things\n satisfactorily")
  })
  
  output$blamed <- renderPlot({
    
    #separate functions to generate each index needed
    exp_index <- make_exp_index(input$exp,col1)
    happy_index <- make_happy_index(input$happy,col2)
    quals_index <- make_quals_index(input$quals,col3)
    comp_index <- make_comp_index(input$comp, col4) 
    testjob_index <- make_testjob_index(input$testjob, col5)
    nottestjob_index <- make_nottestjob_index(input$nottestjob, col6)
    diffjob_index <- make_diffjob_index(input$diffjob, col7)
    study_index <- make_study_index(input$study, col8)
    
    #combine all indexes into a list
    list_of_indexes <- list(exp_index,
                            happy_index,
                            quals_index,
                            comp_index,
                            testjob_index,
                            nottestjob_index,
                            diffjob_index,
                            study_index)
    
    index_to_plot <- present_in_all(list_of_indexes)
    
    #column containing blamed data is 53
    data <- apply_index(index_to_plot, 53)
    
    make_bar(data, "I am blamed\n for missed bugs")
  })
  
  
})

