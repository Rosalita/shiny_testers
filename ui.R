##########################
# A shiny web app - ui.R #
##########################

setwd ("/Dev/Git/shiny_testers")

#install.packages("shiny") #install shiny

library(shiny) # load shiny

shinyUI(pageWithSidebar(
  
  headerPanel("Happy Testers"),
  sidebarPanel(
    
    #textInput(inputId = "comment",
    #          label = "Say something?",
    #          value = "" #initial value
    #)
    
    radioButtons(inputId = "rbutton", 
                 label = "Experience", 
                 c("> 1 year" = "happylessthanone", 
                   "1 - 2 years" = "happyonetotwo", 
                   "2 - 5 years" = "happytwotofive", 
                   "5 - 10 years" = "happyfivetoten", 
                   "10 - 20 years" = "happytentotwenty",
                   "20 + years" = "happytwentyplus" )
    )
    
    
  ),
  
  mainPanel(
   # h3("This is you saying it"),
   # textOutput("textDisplay")
    
    plotOutput("happyPlot")
  )
  
))

