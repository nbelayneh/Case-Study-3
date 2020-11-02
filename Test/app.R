library(shiny)
ui <- fluidPage(
    titlePanel("Regression Model (Dataset: Swiss)"),
    sidebarLayout(
        sidebarPanel(
            selectInput("outcome", label = h3("Outcome"),
                        choices = list("Pregnancies" = "Pregnancies",
                                       "Glucose" = "Glucose",
                                       "Blood Pressure" = "Blood Pressure",
                                       "Skin Thickness" = "Skin Thickness",
                                       "Insulin" = "Insulin",
                                       "BMI" = "BMI", "Diabetes Pedigree Function" = "Diabetes Pedigree Function",
                                       "Age"= "Age", "Outcome"= "Outcome"), selected = 1),
            
            selectInput("indepvar", label = h3("Explanatory variable"),
                        choices = list("Pregnancies" = "Pregnancies",
                                       "Glucose" = "Glucose",
                                       "Blood Pressure" = "Blood Pressure",
                                       "Skin Thickness" = "Skin Thickness",
                                       "Insulin" = "Insulin",
                                       "BMI" = "BMI", "Diabetes Pedigree Function" = "Diabetes Pedigree Function",
                                       "Age"= "Age", "Outcome"= "Outcome"), selected = 1),
        ),
        
        mainPanel(
            
            tabsetPanel(type = "tabs",
                        
                        tabPanel("Scatterplot", plotOutput("scatterplot")), # Plot
                        tabPanel("Distribution", # Plots of distributions
                                 fluidRow(
                                     column(6, plotOutput("distribution1")),
                                     column(6, plotOutput("distribution2")))
                        ),
                        tabPanel("Model Summary", verbatimTextOutput("summary")), # Regression output
                        tabPanel("Data", DT::dataTableOutput('tbl')) # Data as datatable
                        
            )
        )
    ))



# SERVER
server <- function(input, output) {
    
    # Regression output
    output$summary <- renderPrint({
        fit <- lm(Diabetes[,input$outcome] ~ Diabetes[,input$indepvar])
        names(fit$coefficients) <- c("Intercept", input$var2)
        summary(fit)
    })
    
    # Data output
    output$tbl = DT::renderDataTable({
        DT::datatable(Diabetes, options = list(lengthChange = FALSE))
    })
    
    
    # Scatterplot output
    output$scatterplot <- renderPlot({
        plot(Diabetes[,input$indepvar], Diabetes[,input$outcome], main="Scatterplot",
             xlab=input$indepvar, ylab=input$outcome, pch=19)
        abline(lm(Diabetes[,input$outcome] ~ Diabetes[,input$indepvar]), col="red")
        lines(lowess(Diabetes[,input$indepvar],Diabetes[,input$outcome]), col="blue")
    }, height=400)
    
    
    # Histogram output var 1
    output$distribution1 <- renderPlot({
        hist(Diabetes[,input$outcome], main="", xlab=input$outcome)
    }, height=300, width=300)
    
    # Histogram output var 2
    output$distribution2 <- renderPlot({
        hist(Diabetes[,input$indepvar], main="", xlab=input$indepvar)
    }, height=300, width=300)
}

shinyApp(ui = ui, server = server)