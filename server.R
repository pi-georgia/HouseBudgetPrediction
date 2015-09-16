library(shiny) 
houseBudget <- function(area="City Center", surface_min=30,surface_max=100, rooms=2, type="Flat") 
{
  data<-read.csv('housedata.csv')
  prediction<-c(150,200) ;  price_min<-0 ;  price_max<-0
  pred_data<- subset(data,(Area==area) &(Type %in% type)&(Surface >=surface_min) & (Surface <= surface_max),select=c(Price, Psqm))
  price_min<- mean(pred_data$Price) - sd(pred_data$Price)/2
  price_max<- mean(pred_data$Price) +  sd(pred_data$Price)/2
  prediction <-c(round(price_min), round(price_max))
  prediction
}

shinyServer(
  function(input, output) {
    output$area <- renderText({input$area})
    output$type <- renderText({input$type})
    output$rooms <- renderText({input$rooms})
    output$surface <- renderText({input$surface})
    output$prediction <- renderPrint({houseBudget(area= input$area,surface_min=as.integer(input$surface[1]), surface_max=as.integer(input$surface[2]), rooms= as.integer(input$rooms), type= input$type)})
  } )