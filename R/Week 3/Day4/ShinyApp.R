# Data Scource: https://www.kaggle.com/lava18/google-play-store-apps
# import library
library(Shiny)

# load data
df <- read.csv('googleplaystore.csv')
df
##############

# if there are more one genres, then split genres and return first item
split_Genres <- function(string){
  strsplit(string,';')[[1]][1]
}

# remove dollar sign from price
remove_dollar_sing <- function(string){
  str_replace(string, "[$]", "")
}

# apply split_Genres function on Genres column
df$Genres <- sapply(df$Genres,split_Genres)
# apply remove_dollar_sing function on Price column 
df$Price <- sapply(df$Price,remove_dollar_sing)
# Convert Price to integer
df$Price <- sapply(df$Price,as.integer)

##############

# create Shiny 

# UI
ui <- fluidPage(
  
  # Page title 
  titlePanel("Google Play Apps"),

  #---
  # create input selection (App Type)
  selectInput(inputId="Type",
              label="Choose App Type:",
              choices=c("Free" = "Free", 
                        "Paid"= "Paid")),
 # create PlotOutput called "bar'
 plotOutput('bar') ,
 
 #---
 # create input selection (App Genres)
 selectInput(inputId="Genres",
             label="Choose App Genres ",
             choices=unique(df$Genres)),
 
 # create PlotOutput called "bar2'
 plotOutput('bar2') 
 
 
)

# server function 
server <- function(input, output, session) {
  
  # create output for bar plot
  output$bar <- renderPlot({
    title <- "bar"
    
    df1 <- df %>% filter(Type == input$Type) # filter df by the selected Type
    table <- with(df1, table(Genres)) # count apps for each Genres
    table <- table[order(table, decreasing = TRUE)] # order table 
    table <- data.frame(table) # convert table to data frame 
    table <- table %>% slice(1:20) # select top 20 Genres
    table
    
    # find the maximum value in table
    max_value = max(table$Freq)
    # colored maximum bar by darkgreen and another by gray
    colors <- ifelse(table$Freq == max_value,"darkgreen","gray")
    
    # create bar plot 
    barplot(table$Freq, beside = TRUE, las=2,border = NA, 
            names.arg = table$Genres,col=colors,space=0.5,
            main= "The top 20 Genres for free apps in the Google store")
    
  })
  
  #---
  
  # create output for bar2 plot
  output$bar2 <- renderPlot({
    title <- "bar2"
    
    df1 <- df %>% 
      filter(Genres == input$Genres) # filter df by the selected Genres
    df1 %>%
      filter(Type == "Paid" & Price > 0 ) %>% # filter df when Type equal "Paid" and Price greater than 0
      ggplot(aes(Price)) +
      ggtitle("Count of the paid apps based on the price") +
      geom_histogram( fill='darkgreen') # fill bar by darkgreen
  })
 
}

shinyApp(ui, server)