library(markdown)
shinyUI(navbarPage("Heat Map Examples", 
                   
    # Application title
    tabPanel("Basic Map",
        sidebarLayout(
            # Sidebar with a slider and selection inputs
            sidebarPanel(
                sliderInput("start",
                            "Starting Year:",
                            min = 1928,  max = 2014, value = 1928, sep = "" ),
                sliderInput("end",
                            "Ending Year:",
                            min = 1929,  max = 2015,  value = 2015, sep = "" ),
                sliderInput("start.dy",
                            "Starting DOY:",
                            min = 1,  max = 365, value = 1, sep = "" ),
                sliderInput("end.dy",
                            "Ending DOY:",
                            min = 1,  max = 365,  value = 365, sep = "" ),
                checkboxInput('logF', 'Log Flow',value = FALSE)
            ),## close sidepanelLayout
            mainPanel(  plotOutput("plot1") )
                     ) 
           ),
    tabPanel("Binned by Quantiles",
        sidebarLayout(
            sidebarPanel(
                sliderInput("nQuants", "Number of Quantiles:",
                         min = 2,  max = 8,  value = 4 )
                        ),
            mainPanel(plotOutput("plot2"))            
                      )
             
             ),
    tabPanel("Threshold",
        sidebarLayout(
            sidebarPanel(
                checkboxInput('lowF', 'Flows less than threshold?',value = FALSE),
                            sliderInput("Quants",
                             "Quantile Threshold:",
                            min = 0,  max = 1,  value = 0.5 )
                             ),
            mainPanel( plotOutput("plot3"))
            )
             ),
    tabPanel("About",
             includeMarkdown("about.Rmd")
             )
    
)
)

