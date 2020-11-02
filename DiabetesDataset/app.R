#Q1 Please select any data set from below the links or any other suitable dataset
# https://www.kaggle.com/mathchi/diabetes-data-set/notebooks

library(shiny)
library(ggplot2)
library(rsconnect)
library(here)

 
#Diabetes =  read.csv(here::here("docs"), "file:///Users/najatbelayneh/Desktop/diabetes.csv")

# Define UI for application that draws a histogram
ui <- fluidPage(
    
    
    # Sidebar with a slider input for number of bins 
    headerPanel(title = "Diabetes Dataset"),
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
shinyApp (ui = ui, server = server)

 


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





    
