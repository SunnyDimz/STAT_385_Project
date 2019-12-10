#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

CCSO <- read.csv("https://uofi.box.com/shared/static/9elozjsg99bgcb7gb546wlfr3r2gc9b7.csv")

library(shiny)

# Define UI for application that draws a histogram
ui <- fluidPage(
   
   # Application title
   titlePanel("Champaign County Jail (2011-2016)"),
   
   sidebarLayout(
      sidebarPanel(
        fileInput("CCSO", "File Name",
                  accept = c(
                    "text/csv",
                    "text/comma-separated-values,text/plain",
                    ".csv")
        ),
        tags$hr(),
        checkboxInput("header", "Header", TRUE)
      ),
      mainPanel(
        tableOutput("contents")
      )
   ),
   
   sidebarLayout(
     sidebarPanel(
       sliderInput(inputId = "Days in Jail",
                   label = "Days in Jail:",
                   min = min(CCSO$Days.in.Jail),
                   max = max(CCSO$Days.in.Jail),
                   value = 10)
     ),
     mainPanel(
       tableOutput("contents")
     )
   )
)


# Define server logic required to draw a histogram
server <- function(input, output) {
   
   output$distPlot <- renderPlot({
      # generate bins based on input$bins from ui.R
      x    <- faithful[, 2] 
      bins <- seq(min(x), max(x), length.out = input$bins + 1)
      
      # draw the histogram with the specified number of bins
      hist(x, breaks = bins, col = 'darkgray', border = 'white')
   })
   options(shiny.maxRequestSize=30*1024^2)
}

# Run the application 
shinyApp(ui = ui, server = server)

