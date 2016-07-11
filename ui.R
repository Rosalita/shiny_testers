##########################
# A shiny web app - ui.R #
##########################

setwd ("/Dev/Git/shiny_testers")

#install.packages("shiny") #install shiny

library(shiny) # load shiny

shinyUI(pageWithSidebar(
  
  headerPanel("Happy Testers"),
  sidebarPanel(
    
    radioButtons(inputId = "rbutton", 
                 label = "Experience", 
                 c("> 1 year" = "lessthanone", 
                   "1 - 2 years" = "onetotwo", 
                   "2 - 5 years" = "twotofive", 
                   "5 - 10 years" = "fivetoten", 
                   "10 - 20 years" = "tentotwenty",
                   "20 + years" = "twentyplus" )
    )
    
    
  ),
  
  mainPanel(
    h3("This is the output of textDisplay"),
    textOutput("textDisplay"),
    
    plotOutput("happyPlot")
  )
  
))

