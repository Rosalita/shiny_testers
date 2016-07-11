##########################
# A shiny web app - ui.R #
##########################

setwd ("/Dev/Git/shiny_tester")

library(shiny) # load shiny

shinyUI(pageWithSidebar(
  
  headerPanel("Minimal example")
  sidebarPanel(
    
    textInput(inputID = "comment",
              label = "Say something?"
              value = "" #initial value
    )
    
  ),
  
  mainPanel(
    h3("This is you saying it"),
    textOutput("textDisplay")
  )
  
))

runApp()
