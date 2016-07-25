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

shinyUI(fluidPage(
  
  titlePanel("Explore a Sample of Software Testers"),
  
  fluidRow(
  
  column(4,
      wellPanel(   
        h4("Define a group of Software Testers to examine"),
        
        fluidRow(
          column(6,
                 checkboxGroupInput("exp", 
                                    label = "1. Testing Experience", 
                                    choices = explevels, #explevels is defined in helper.R
                                    selected = c("less than a year", 
                                                 "1 - 2 years", 
                                                 "2 - 5 years",
                                                 "5 - 10 years",
                                                 "10 - 20 years",
                                                 "More than 20 years"),
                                    inline = FALSE, 
                                    width = NULL)
                 ),
          column(6,
                 checkboxGroupInput(inputId = "quals",
                                    label = "2. Highest Qualification",
                                    choices = quals, #quals is defined in helper.R
                                    selected= c("None",
                                                "GCSEs or equivalent",
                                                "A-Levels or equivalent", 
                                                "Foundation course", 
                                                "Bachelors degree",
                                                "Masters degree",
                                                "Doctorate"),
                                    inline = FALSE, 
                                    width = NULL)
              )
        ),
        
        fluidRow(
          column(6,
                 radioButtons(inputId = "comp", 
                              label = "3. States they studied computing", 
                              c("All testers" = "b",
                                "Yes Group" = "Yes", 
                                "No Group" = "No")
                 )
          ),
          column(6,
                 radioButtons(inputId = "happy", 
                              label = "4. States they are happy in current job", 
                              c("All testers" = "b",
                                "Yes Group" = "Yes", 
                                "No Group" = "No")
                 )
          )
        ),
    
        fluidRow(
          column(6,
                 checkboxGroupInput(inputId = "testjob",
                                    label = "5. Likelihood to seek a different testing job in next 12 months",
                                    choices = testjoblevels, #testjoblevels is defined in helper.R
                                    selected= c("Very unlikely",
                                                "Unlikely",
                                                "Not sure", 
                                                "Likely", 
                                                "Very Likely"),
                                    inline = FALSE, 
                                    width = NULL)
          ),
          column(6,
                 checkboxGroupInput(inputId = "nottestjob",
                                    label = "6. Likelihood to seek a job outside of testing in next 12 months",
                                    choices = nottestjoblevels, #nottestjoblevels is defined in helper.R
                                    selected= c("Very unlikely",
                                                "Unlikely",
                                                "Not sure", 
                                                "Likely", 
                                                "Very Likely"),
                                    inline = FALSE, 
                                    width = NULL)
          )
        ),
        
        fluidRow(
          column(6,
                 radioButtons(inputId = "diffjob", 
                              label = "7. States they held a different job prior to becoming a tester", 
                              c("All testers" = "b",
                                "Yes Group" = "Yes, I had a different job before I started testing", 
                                "No Group" = "No, my very first job was a testing job.")
                 )
          ),
          column(6,
                 radioButtons(inputId = "study", 
                              label = "8. States they knew while studying they wanted to work in testing", 
                              c("All testers" = "b",
                                "Yes Group" = "Yes", 
                                "No Group" = "No")
                 )
          )
        )
  
    )
  ),
  
  
  
  column(8,
    
   tabsetPanel(
     
     tabPanel("Happiness Histogram",
              h3(textOutput("text1")),
              plotOutput("happyplot")

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
  )
))

