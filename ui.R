library(shiny)
# Define UI for dataset viewer application

shinyUI(
  pageWithSidebar(
  
  # Application title
  headerPanel("Real-Estate Budget Helper"),
  
  # Sidebar with controls to select a dataset and specify the number
  # of observations to view
  sidebarPanel(
    selectInput("area", "Where in Athens do you want to buy?:", 
                choices = c("City Center", "North Suburbs", "South Suburbs")),
    br(),
    checkboxGroupInput("type", "What property are you looking for?:",
                 c("Flat" = "flat",
                      "House" = "house",
                      "Maisonette" = "maisonette",
                      "Other" = "other"), selected="flat"),
   
    sliderInput("rooms", "How many rooms you'd like?:",
                min = 1, max = 10, value = c(1,10)),
    sliderInput("surface", "How many square meters you'd like?:",
                min = 10, max = 500, value = c(50,200)),
    br(),
    submitButton("Refresh Prediction", icon("refresh"))
  ),
  
  # Show a summary of the dataset and an HTML table with the requested
  # number of observations
  mainPanel(
    h2('Budget Prediction '),
    h3('We are giving you a prediction for a budget in '),
    h3(textOutput('area')),
    br(),
    h3('Your estimated budget is '),
    h2(textOutput('prediction'))
  )
  ))