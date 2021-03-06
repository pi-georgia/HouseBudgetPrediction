library(shiny)
# Define UI for dataset viewer application

shinyUI(
  fluidPage(theme = "bootstrap.css",
  
  # Application title
  headerPanel("Home Budget Planner"),
  
  # Sidebar with controls to select a dataset and specify the number
  # of observations to view
  sidebarPanel(
    selectInput("area", "Where in Athens do you want to buy?:", 
                choices = c("City Center", "North Suburbs", "South Suburbs")),
    br(),
    checkboxGroupInput("type", "What property are you looking for?:",
                 c("Flat" = "Flat",
                      "House" = "House",
                      "Maisonette" = "Maisonette",
                      "Other" = "Other"), selected="Flat"),
   
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
    h3('Home Budget Prediction '),
    br(),
    tags$b(textOutput('commarea')),
    tags$b(textOutput('area')),
    h5(textOutput('commsurface')),
    br(),
  
    h4(textOutput('pred_range')),
    plotOutput("HistChart"),
  
    br(),
    br(),
    br(),
   tags$i(tags$b("Disclaimer")),
   tags$i('The above results are based on market data from January 2014.The data sample is limited and therefore results are only for demonstration purposes.'),
   br(),
   tags$a(href="https://www.linkedin.com/in/psyllidou", "For any questions, click to contact me!")
  )
  ))