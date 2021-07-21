# 
# Weekend project
#
# Group-4 :  Fatimah Al-Rashed - Zarah Shibli - Abdulrahman Aljubaylan - Rawan Alsaedi
#
# Dashboard link: https://zarah.shinyapps.io/telc/?_ga=2.193198189.1135661885.1626446894-428534872.1626446894
#=====================================================================================
#
# Data Source: https://www.kaggle.com/radmirzosimov/telecom-users-dataset  
#install.packages("DT")
#install.packages("shinyWidgets")
#install.packages("colourpicker")
#install.packages("gridExtra")
library(shiny)
library(dplyr)
library(ggplot2)
library(DT)
library(shinyWidgets)
library(colourpicker)
library(gridExtra)


ctelecom <- read.csv("telecom_users.csv")

# Change data type
ctelecom$SeniorCitizen <- sapply(ctelecom$SeniorCitizen, as.character) #---

ui <- fluidPage(
    h1("TELECOMMUNICATION COMAPNY",text="Bold", align="center", style = "color:#34495E"),
    setBackgroundColor("#F2F3F4"),
    progressBar(id = "pb1", value = 100, status = "custom"),
    tags$style(".progress-bar-custom {background-color: #34495E;}"),
    
    sidebarLayout(
        sidebarPanel(
            #   img(src = "Desktop/tel.png", height = 100, width = 200),
            DT::dataTableOutput("mytable"),
            
            selectInput(inputId = "finance",
                        label = "Financial Overview",
                        choices = c("Total Costs & subscription period","Renewal of Contracts & Monthly Costs","The Gender of The Clients "),
                        selected = "Total Costs & subscription period" ),
            textOutput("selected_var"),
            plotOutput("plot4")),
        
        mainPanel(
            
            sidebarPanel(
                width = 16,
                fluidRow(
                    column(width = 6,plotOutput("plot1")),
                    column(width = 6,plotOutput("plot2"))
                )
            ),
            ###
            
            sidebarPanel(
                width = 18,
                selectInput(
                    inputId = "Type",
                    label = "Choose Type:",
                    choices = c(
                        "Senior Citizen" = 1,
                        "Non-Senior Citizen" = 0
                    )
                ),
                
                fluidRow(
                    column(width = 5,plotOutput("plot5", height="300px")),
                    column(width = 7,plotOutput("plot6", height="300px"))
                )
            )
            #### 
            
        )
        
        
    ),
    
    ####
    sidebarPanel(
        radioButtons("PhoneService", "Do they have a Phone Service also?",
                     choices = c("Yes", "No"),
                     selected = "Yes"),
        plotOutput("plot7", height="310px")
    ),
    
    sidebarPanel(
        radioButtons("Dependents", "Are they Dependents or not?",
                     choices = c("Yes", "No"),
                     selected = "Yes"),
        plotOutput("plot8", height="310px")
    ),
    
    
    sidebarPanel(
        width = 4,
        plotOutput("plot9")
    ),
    
    
    ####
    sidebarPanel(
        width = 12,
        fluidRow(
            column(width = 6,plotOutput("plot10", height="300px")),
            column(width = 6,plotOutput("plot11", height="300px"))
        )
    )
    ####
    
)

server <- function(input, output) {
    
    
    output$plot1 <- renderPlot({
        ctelecom <- read.csv("telecom_users.csv", header = TRUE,sep = ",")
        stelecom <- data.frame(ctelecom$tenure,ctelecom$MonthlyCharges,ctelecom$TotalCharges)
        output$mytable = DT::renderDataTable(stelecom, options = list( scrollX=TRUE,pageLength = 5))
        
        ggplot( data=ctelecom, aes( x= ctelecom$tenure ) ) + geom_histogram( binwidth=8, color="black", fill="blue", alpha=0.7 ) + ggtitle( "Clients Subscription Periods" )
        
    })
    
    output$plot2 <- renderPlot({
        ctelecom <- read.csv("telecom_users.csv", header = TRUE,sep = ",")
        
        ctelecom <- aggregate( ctelecom$tenure, by=list( ctelecom$Contract ), FUN=mean )
        names( ctelecom ) <- c( "Contract", "tenure" )
        ctelecom <- ctelecom[ order( ctelecom$tenure ), ]
        ggplot( ctelecom, aes( x=Contract, y=tenure, fill=Contract ) ) + geom_bar( stat="identity", width=0.25 ) + ggtitle( "Renewal of Contracts" )
        
    })
    
    
    output$plot3 <- renderPlot({
        ctelecom <- read.csv("telecom_users.csv", header = TRUE,sep = ",")
        
        
    }
    )
    
    
    output$plot4 <- renderPlot({
        ctelecom <- read.csv("telecom_users.csv", header = TRUE,sep = ",")
        rbPal <- colorRampPalette(c('red','blue'))
        if(input$finance == "Total Costs & subscription period"){
            g <- ggplot(ctelecom, aes(y= ctelecom$TotalCharges, x=ctelecom$tenure))
            g + geom_bar(stat = "sum", color="#34495E" ) 
            
        }else if(input$finance == "Renewal of Contracts & Monthly Costs"){
            
            g <- ggplot(ctelecom, aes(y= ctelecom$MonthlyCharges, x=ctelecom$Churn))
            g + geom_bar(stat = "identity", color="#800000")
            
            
        }else{
            
            g <- ggplot(ctelecom, aes(y= ctelecom$tenure, x=ctelecom$gender))
            g + geom_bar(stat = "identity", color="purple")
            
            
            
        }
        
    }
    )
    
    ####
    output$plot5 <- renderPlot(
        { title <- "BoxplotSenior" # output title  
        if(input$Type == 1) { type_string <- "Senior Citizen" } # set the selected type (Senior or Non-Senior)
        else { type_string <- "Non-Senior Citizen" } 
        
        # filter data by selected type (Senior or Non-Senior)
        ctelecom %>% 
            filter(SeniorCitizen == input$Type) %>% 
            ggplot(
                aes(
                    y = MonthlyCharges, 
                    x = SeniorCitizen,
                    color = Churn
                )) +
            ggtitle(
                paste(
                    "Monthly charges distribution for ", 
                    type_string)
            ) + # plot title 
            geom_boxplot() # create boxplot
        })
    
    # Create box plot for answer following question: 
    # What is the most Monthly charges paid by customers with Month-to-month contract?
    output$plot6 <- renderPlot(
        { title <- "LinePlotSenior" 
        if(input$Type == 1) { type_string <- "Senior Citizen" }
        else { type_string <- "Non-Senior Citizen" } 
        
        # filter data by selected type (Senior or Non-Senior) and Contract equal "Month-to-month"
        ctelecom %>% 
            filter(SeniorCitizen == input$Type & Contract == "Month-to-month") %>% 
            ggplot(aes(MonthlyCharges, color = Churn)) + 
            ggtitle(
                paste(
                    "Monthly charges paid by ",
                    type_string,
                    " with Month-to-month contract")
            ) + 
            geom_freqpoly() # create frequance plot
        }
    )
    
    ###
    
    #Created a geom_point about Monthly charges for internet Service and if they have also a phone service or not
    output$plot7 <- renderPlot({
        ctelecom <- read.csv("telecom_users.csv")
        f= ctelecom %>%
            filter( PhoneService == input$PhoneService)
        ggplot(f, aes(y= MonthlyCharges, x= InternetService)) + 
            ggtitle("Monthly charges for internet with phone service") +
            geom_point (stat = "identity", color="#5CB3FF" ) 
        
    }
    )
    
    #Created a geom_bar for the most used of Payment Method 
    output$plot8 <- renderPlot({
        ctelecom <- read.csv("telecom_users.csv")
        ff= ctelecom %>%
            filter( Dependents == input$Dependents)
        ggplot(ff, aes(x = Partner )) + 
            ggtitle("What's the kind of most partners, are they dependents or not?") +
            geom_bar(fill="#FAAFBE")
    })
    
    #Created a geom_bar for the most used of Payment Method 
    output$plot9 <- renderPlot({
        ctelecom <- read.csv("telecom_users.csv")
        ggplot(data=ctelecom)+ geom_bar(mapping = aes(x = PaymentMethod, fill = PaymentMethod), show.legend = FALSE, width = 1) +
            theme(aspect.ratio = 1) + labs(x = NULL, y = NULL) +
            ggtitle("The most used Payment Methods") + coord_flip ()
    })
    
    
    ####
    
    set.seed(12)
    #Create the plot10
    output$plot10 = renderPlot({
        ctelecom %>% 
            ggplot(aes(x = TotalCharges , fill = Churn, main = "plot9")) +
            geom_histogram(binwidth = 100) +
            labs(x = "Dollars", title = "Churn Rate by Total Charges")
        
    })
    
    #Create the plot11
    output$plot11 = renderPlot({
        ctelecom %>%  ggplot(aes(x = TotalCharges , fill = Contract , main = "plot10")) +
            geom_histogram(binwidth = 100) + 
            labs(x ="Dollars", title = "The Total Charges by Contract Status ")
    })
    
    ###
    
    
}

# Run the application 
shinyApp(ui = ui, server = server)