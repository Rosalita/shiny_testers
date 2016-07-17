##########################
# A shiny web app - ui.R #
##########################

#setwd ("/Dev/Git/shiny_testers") 
setwd("/git/shiny_testers")
getwd()

#Read data
mydata <- read.csv("/git/shiny_testers/data/survey_results_raw.csv", header = TRUE, sep =",")

#Include the R code in helper.R
source("helper.R")

#install.packages("shiny") #install shiny

library(shiny) # load shiny

shinyUI(pageWithSidebar(
  
  headerPanel("Happy Testers"),
  sidebarPanel(
    
    selectInput("exp",
                label = "1. Experience",
                choices = list("> 1 year" = "1", 
                "1 - 2 years" = "2",
                "2 - 5 years" = "3", 
                "5 - 10 years" = "4", 
                "10 - 20 years" = "5",
                "20 + years" = "6"),
                       selected	= "1"
                       )
    
   
  #  radioButtons(inputId = "checkHappy", 
  #               label = "2. Is Happy?", 
  #               c("Both Yes and No Groups" = "yn",
  #                 "Yes Group" = "y", 
  #                 "No Group" = "n")
  #               ),
    
  #  checkboxGroupInput(inputId = "checkQual",
  #                     label = "3. Highest Qualification",
  #                     choices = list("None" = "1", 
  #                                    "GCSE or equivalent" = "2",
  #                                    "A Level or equivalent" = "3", 
  #                                    "Foundation Course or equivalent" = "4", 
  #                                    "Bachelors degree" = "5",
  #                                    "Masters degree" = "6",
  #                                    "Doctorate" = "7"),
  #                     selected	= c("1","2","3","4","5","6","7")
  #  )
  ),
  
  
  
  mainPanel(
    "Experience Group Selected:",
    textOutput("text1"),

    "This is the plot",
    plotOutput("plot")
    
  )
  
))

