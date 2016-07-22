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
  
  headerPanel("Explore a Sample of Software Testers"),
  
  sidebarPanel(
    h4("Define a group of Software Testers to examine"),
    
  checkboxGroupInput("exp", 
                     label = "1. Testing Experience", 
                     # column 14 is experience
                     choices = explevels, #explevels is defined in helper.R
                     selected = c("less than a year", 
                                  "1 - 2 years", 
                                  "2 - 5 years",
                                  "5 - 10 years",
                                  "10 - 20 years",
                                  "More than 20 years"),
                     inline = FALSE, 
                     width = NULL),
  
   
    radioButtons(inputId = "happy", 
                 label = "2. States they are happy in current job", 
                 c("Both Yes and No Groups" = "b",
                   "Yes Group" = "Yes", 
                   "No Group" = "No")
                 ),
    
    checkboxGroupInput(inputId = "quals",
                       label = "3. Highest Qualification",
                       choices = quals, #quals is defined in helper.R
                       selected= c("None",
                                   "GCSEs or equivalent",
                                   "A-Levels or equivalent", 
                                   "Foundation course", 
                                   "Bachelors degree",
                                   "Masters degree",
                                   "Doctorate"),
                       inline = FALSE, 
                       width = NULL),
  
    radioButtons(inputId = "comp", 
               label = "4. States they studied computing", 
               c("Both Yes and No Groups" = "b",
                 "Yes Group" = "Yes", 
                 "No Group" = "No")
               ),
    checkboxGroupInput(inputId = "testjob",
                     label = "5. Likelihood to seek another testing job in next 12 months",
                     choices = testjoblevels, #testjoblevels is defined in helper.R
                     selected= c("Very unlikely",
                                 "Unlikely",
                                 "Not sure", 
                                 "Likely", 
                                 "Very Likely"),
                     inline = FALSE, 
                     width = NULL)
  
    
  ),
  
  
  
  mainPanel(
    
   tabsetPanel(
     
     tabPanel("Happiness Histogram",plotOutput("happyplot"),
              textOutput("text1")
              ),
     
     tabPanel("Positive 1", 
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
     
     tabPanel("Positive 2", 
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
     
     tabPanel("Negative 1",
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
     tabPanel("Negative 2",
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

