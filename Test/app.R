library(shiny)
ui <- fluidPage(
    titlePanel("Regression Model (Dataset: Diabetes Data Set)"),
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




#Q2: Select an algorithm suitable for the above set. 
# I chose a Diabetes Data Set : https://www.kaggle.com/mathchi/diabetes-data-set/notebooks. 
# I would suggest to start off with association rules to reveal the relationship between the different variables 
# collected. This will allow to identify the relationships between number of pregnancies and blood sugar level, 
# number of pregnancies and high blood pressure and the different variables versus the outcome. 
# We can then apply simple regression initially then if that fails, move to linear regression. 

# The objective is to predict the trend in the data based on the diagnostic measurements collected. We can use
# mathematical model to find pattern in the collected data. These patterns can then be used to build
# a model that can accurately predict the prevalence of diabetes in women above the age of 21.

# I suggest to apply the simple and linear regression algorithm on the collected data. I chose both
# algorithms because the simple regression to allow me to focus on the different variables and the outcome. 
# Using linear regression, we can observe the correlation between each of the variable and the outcome column. 
# It is also the most common algorithmic tool typically used in medical research to explore the correlation 
# between variables. Once a known correlation is observed a regression analysis can then be used to build the 
# predictive model.  

#Q3: Explain the mathematical / statistical details of the algorithm 
# total number of rows and columns
# Data set comprises of 768 observations and 9 characteristics.
# Out of which one is dependent variable and rest 8 are independent variable
# target data category is the outcome column that is assigned two values, 0 or 1. 0 indicates patient is non-diabteic 
# 1 indicates patient is diabetic. 

#We can create a model using algorithms from linear model to test the different variables.  


