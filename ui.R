##########################
# A shiny web app - ui.R #
##########################

setwd ("/Dev/Git/shiny_testers") 
#setwd("/git/shiny_testers")

getwd()

#Read data
mydata <- read.csv("C:/Dev/Git/shiny_testers/data/survey_results_raw.csv", header = TRUE, sep =",")
#mydata <- read.csv("/git/shiny_testers/data/survey_results_raw.csv", header = TRUE, sep =",")


#Include the R code in helper.R
source("helper.R")

#install.packages("shiny") #install shiny

library(shiny) # load shiny

shinyUI(pageWithSidebar(
  
  headerPanel("Happy Testers"),
  sidebarPanel(
    h4("Define the group of Software Testers to examine"),
    
  checkboxGroupInput("exp", 
                     label = "1. Experience", 
                     # column 14 is experience
                     choices = explevels,
                     selected = "less than one", 
                     inline = FALSE, 
                     width = NULL)
  
   
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
   
    plotOutput("happyplot"),
    
    fluidRow(
      
      column(4,
             plotOutput("expectations")
             ),
      column(4,
             plotOutput("team")
             ),
      column(4,
             plotOutput("decisions")
             )
    ),
    
    fluidRow(
      
      column(4,
             plotOutput("cares")
             ),
      column(4,
             plotOutput("auto")
      ),
      column(4,
             plotOutput("bugcount")
      )
    )
    
    
    
  )
  
))

