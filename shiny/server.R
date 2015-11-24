shinyServer(function(input, output, session) {
    
    # Combine the selected variables into a new data frame
    selectedData <- reactive({
        subset(dat, wy.year >= input$start & wy.year <= input$end & wy.day >= input$start.dy & wy.day <= input$end.dy )
        })
    
    output$plot1 <- renderPlot(    
    {
        if(input$logF){
            p <- ggplot(data = selectedData(), aes(x = wy.day, y = wy.year, fill = log.flow))} else{
            p <- ggplot(data = selectedData(), aes(x = wy.day, y = wy.year, fill = flow))
        } 
        
    print(    p + geom_tile() + labs(x = "Day of Year", y = "Year") +
                  scale_fill_gradient(low="yellow",  high="red", guide="colorbar") )
    } )
    
### quantile.plot
    output$plot2 <- renderPlot(    
    {
           n <- input$nQuants
           brks <- quantile(dat$flow, probs = c(0, (1:n)/(n+1), 1) )
           dat$val <- cut(dat$flow, breaks = brks,include.lowest = TRUE)
           p <- ggplot(data = dat, aes(x = wy.day, y = wy.year, fill = val) )
           
           print(p + geom_tile() + labs(x = "Day of Year", y = "Year") +
                     scale_fill_brewer(type = "seq") 
                 )       
    } ) 

output$plot3 <- renderPlot(    
{
    brks <- as.numeric(quantile(dat$flow, probs = input$Quants ) )

if(input$lowF){dat$val <- dat$flow <= brks} else{
    dat$val <- dat$flow > brks}
    p <- ggplot(data = dat, aes(x = wy.day, y = wy.year, fill = val) ) + labs(title = paste("Threshold = ", brks),
                                                                              x = "Day of Year", y = "Year" )
    
    print(p + geom_tile() 
    )       
} ) 

}
)