library(shiny) 

houseBudget <- function(area="City Center", surface_min=30,surface_max=100, rooms=2, type="Flat") 
{
  data<-read.csv('housedata.csv')
  prediction<-c(150,200) ;  price_min<-0 ;  price_max<-0
  pred_data<- subset(data,(Area==area) &(Type %in% type)&(Surface >=surface_min) & (Surface <= surface_max),select=c(Price, Psqm, Type))
 #Plot confidence intervals
  CI <- t.test(pred_data$Price)
  price_min<- CI$conf[1]
  price_max<- CI$conf[2]
  
  #return list of boundaries as well as data for plotting
 prediction <- list(round(price_min), round(price_max), pred_data$Price, pred_data$Psqm, pred_data$Type)
}

shinyServer(
  function(input, output) {
    output$area <- renderText({input$area})
    
    #build some reactive variables
       #the type selected by the user
        thistype <- reactive({input$type})
      #Call prediction function and save returned values in reactive
       pred_results <- reactive({houseBudget(area= input$area,surface_min=as.integer(input$surface[1]), surface_max=as.integer(input$surface[2]), rooms= as.integer(input$rooms), type= input$type)})
        # Type in the dataset as returned in results :  pred_results()[[5]]
        # Price in the dataset as returned in results : pred_results()[[3]]
        # Price per square meter in the dataset as returned in results :  pred_results()[[4]]
        # MIN Price in the dataset as returned in results : pred_results()[[1]]
        # MAX Price in the dataset as returned in results : pred_results()[[2]]
    
    # other variables just in case I want to use them in output
    output$area <-thistype
    output$rooms <- renderText({input$rooms})
    output$surface <- renderText({input$surface})
    output$commsurface <- renderText({paste("Your range in terms of habitable space is ",input$surface[1], "to ",  input$surface[2]) })
    output$commarea <- renderText({c("You are looking in ",input$area, "for the following types of assets : "  )})
    output$pred_range <-renderText({ paste(" Your estimated budget ranges from", pred_results()[[1]] , " EUR to ", pred_results()[[2]], " EUR" ) })

    # Plot the distribution of prices and guidelines, as well as other informative plots
    output$HistChart<- renderPlot({
      par(mfrow=c(1,2))
      hist(pred_results()[[3]]/1000, col="wheat", border="wheat3", prob=TRUE, breaks=27, main= "Price Distribution", xlab="Price in K EUR")
      lines (density(pred_results()[[3]]/1000), col="violetred", lwd=2)  
      abline(v=pred_results()[[1]]/1000, col="violetred", lwd=4, lty=3)
      abline(v=pred_results()[[2]]/1000, col="violetred", lwd=4, lty=3)
      
      palette(c("violetred", "steelblue2", "coral", "black"))
      plot(pred_results()[[3]]/1000,pred_results()[[4]], col=pred_results()[[5]],pch=8,xlab="Price in K EUR", ylab = "Price per square meter", main="Prices and Prices per sqm")
                                   })
  
  } )