##########################
# A shiny web app - ui.R #
##########################

#setwd ("/Dev/Git/shiny_testers") 
setwd("/git/shiny_testers")

getwd()

#Read data
#mydata <- read.csv("C:/Dev/Git/shiny_testers/data/survey_results_raw.csv", header = TRUE, sep =",")
mydata <- read.csv("/git/shiny_testers/data/survey_results_raw.csv", header = TRUE, sep =",")


#Include the R code in helper.R
source("helper.R")

#install.packages("shiny") #install shiny

library(shiny) # load shiny

shinyUI(pageWithSidebar(
  
  headerPanel("Happy Testers"),
  
  sidebarPanel(
    h4("Define a group of Software Testers to examine"),
    
  checkboxGroupInput("exp", 
                     label = "1. Experience", 
                     # column 14 is experience
                     choices = explevels,
                     selected = c("less than a year", 
                                  "1 - 2 years", 
                                  "2 - 5 years",
                                  "5 - 10 years",
                                  "10 - 20 years",
                                  "More than 20 years"),
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
    
   tabsetPanel(
     
     tabPanel("Happiness Histogram",plotOutput("happyplot")),
     
     tabPanel("+ Questions 1", 
        fluidRow(
          column(4,plotOutput("expectations")),
          column(4,plotOutput("team")),
          column(4,plotOutput("cares"))
          ),
        fluidRow(
          column(4,plotOutput("tools")),
          column(4,plotOutput("tech")),
          column(4,plotOutput("collaboration"))
          )
     ),
     
     tabPanel("+ Questions 2", 
        fluidRow(
          column(4,plotOutput("techdebt")),
          column(4,plotOutput("progress")),
          column(4,plotOutput("loyal"))
          ),
        fluidRow(
          column(4,plotOutput("trusted")),
          column(4,plotOutput("train")),
          column(4,plotOutput("difference"))
        )
      ),
     
     tabPanel("- Questions 1",
        fluidRow(
          column(4,plotOutput("decisions")),
          column(4,plotOutput("auto")),
          column(4, plotOutput("bugcount"))
          ),
        fluidRow(
          column(4,plotOutput("kept_in_dark")),
          column(4,plotOutput("appreciate")),
          column(4,plotOutput("prodbreaks"))
        )
      ),
     tabPanel("- Questions 2",
        fluidRow(
          column(4,plotOutput("unpaid")),
          column(4,plotOutput("dev")),
          column(4,plotOutput("sign"))
        ),
        fluidRow(
          column(4,plotOutput("management")),
          column(4,plotOutput("time")),
          column(4,plotOutput("blamed"))
        )
     )
    )
   )
))

