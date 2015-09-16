library(shiny) 
houseBudget <- function(area, surface, rooms, type) 
{
  data<-read.csv('housedata.csv')
  prediction<-c(150,200) ;  price_min<-0 ;  price_max<-0
  pred_data<- subset(data,(Area==area) &(Type %in% type)&(Surface %in% surface),select=c(Price, Psqm))
  price_min<- mean(pred_data$Price) - sd(pred_data$Price)/2
  price_max<- mean(pred_data$Price) +  sd(pred_data$Price)/2
  prediction <-c(price_min, price_max)
  prediction
}

shinyServer(
  function(input, output) {
    output$area <- renderText({input$area})
    output$type <- renderText({input$type})
    output$rooms <- renderText({input$rooms})
    output$surface <- renderText({input$surface})
    output$prediction <- renderPrint({houseBudget (area= input$area,surface=input$surface, rooms= input$rooms, type= input$type)})
  } )