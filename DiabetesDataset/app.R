
library(shiny) 

# Define UI for application that draws a histogram
ui <- fluidPage(
    
    
    # Sidebar with a slider input for number of bins 
    headerPanel(title = "Sample Submission"),
    sidebarLayout(
        sidebarPanel(
            fileInput("file", "Upload the File"),
            h5("Max File size to upload is 5MB"),
            radioButtons("sep", "Separator", choices = c(Comma= ',', Period= ".", Tilde = "~", minus="-")),
            checkboxInput("header", "Header?")
        ),
        
        # Show a plot of the generated distribution
        mainPanel(
            tableOutput("input_file")
        )
    )
) 

# Define server logic required to draw a histogram
library(shiny)
server <- function(input, output) {
    
    output$input_file<- renderTable({
        file_to_read= input$file
        if (is.null(file_to_read)){
            return()
        }
        read.table(file_to_read$datapath, sep= input$sep, header = input$header)
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
