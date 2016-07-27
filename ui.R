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

shinyUI(fluidPage(
  
  titlePanel("Explore a Sample of Software Testers"),
  h5("All data collected between 4th May 2016 and 20th May 2016"),
  
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
        ),
        
        fluidRow(
          column(6,
                 checkboxGroupInput(inputId = "recommend",
                                    label = "9. Likelihood to recommend testing to others",
                                    choices = recommendlevels, #recommendlevels is defined in helper.R
                                    selected= c("Very unlikely",
                                                "Unlikely",
                                                "Not sure", 
                                                "Likely", 
                                                "Very Likely"),
                                    inline = FALSE, 
                                    width = NULL)
          ),
          column(6,
                 radioButtons(inputId = "training",
                                    label = "10. Attended training Courses",
                                    choices = c("All testers",
                                                "Rapid Software Testing", 
                                                "AST BBST Foundations",
                                                "AST BBST Bug Advocacy",
                                                "AST BBST Test Design",
                                                "ISEB/ISTQB Foundation",
                                                "ISEB/ISTQB Advanced",
                                                "ISEB/ISTQB Expert",
                                                "None of the above courses"),
                                    selected= "All testers",
                                    inline = FALSE, 
                                    width = NULL)
          )
        )
  
    )
  ),
  
  
  
  column(8,
    
   tabsetPanel(
     
     tabPanel("Happiness Histogram", 
              fluidRow(
                column(12, align="center",
                       br(),
                       h3(textOutput("text1"))
                       )
              ),
              
            
              plotOutput("happyplot"),
              
              fluidRow(
                  column(12, 
                      h3("How Workplace Happiness Index is Calculated"),
              
                      h5("Software Testers were presented with 12 positive statements 
                      about testing in their workplace such as 'When I make a decision, I feel my 
                      judgement is trusted.' and 12 negative statements such as 'I am usually excluded 
                      when decisions are made.'"),
                      
                      h5("One point was scored for answering true to a positive question and one
                      point subtracted for answering true to a negative question. Each tester 
                      achieved a score ranging from -12 to + 12. This score is the 'Workplace Happiness Index'."),
                   
                      h5("For each group of testers selected, responses to positive and negative questions can 
                      be viewed via the tabs at the top of the page.")
                  )    
              )
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

