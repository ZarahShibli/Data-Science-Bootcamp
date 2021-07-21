#
# Group-4 :  Zarah Shibli - Fatimah Al-Rashed - Abdulrahman Aljubaylan - Rawan Alsaedi
# Data Source: https://www.kaggle.com/radmirzosimov/telecom-users-dataset
#=====================================================================================
#
#install.packages("rlang")
#install.packages("tidyselect")
#install.packages("tidyverse")
#install.packages('scatterplot3d')
#
library(tidyverse)
#
library(ggplot2)
#
library(dplyr)
#
library(scales)
#
library(plotrix)
#
library(scatterplot3d)
#
library(DataExplorer)
#
telecom <- read_csv("C:/Users/User/Downloads/telecom_users.csv")

View(telecom)

ctelecom <- select(telecom,-1)

View(ctelecom)

dim(ctelecom)

summary(ctelecom)

summary(ctelecom$MonthlyCharges)

#filtering

seniorspills1 <- filter(ctelecom,SeniorCitizen==1,PaperlessBilling == "No" )
seniorspills2 <- filter(ctelecom,SeniorCitizen==1,PaperlessBilling == "Yes" )
citizenspills1 <- filter(ctelecom,SeniorCitizen==0,PaperlessBilling == "No" )
citizenspills2 <- filter(ctelecom,SeniorCitizen==0,PaperlessBilling == "Yes" )
View(citizenspills2)

#Percentage

cp1 <- round(nrow(seniorspills1)/nrow(ctelecom),digits = 2)*100
cp2 <- round(nrow(seniorspills2)/nrow(ctelecom),digits = 2)*100
cp3 <- round(nrow(citizenspills1)/nrow(ctelecom),digits = 2)*100
cp4 <- round(nrow(citizenspills2)/nrow(ctelecom),digits = 2)*100
cp4

#Dataframe

percent_sc <- data.frame(
  group = c("Senior=Yes | Paper=No", "Senior=Yes | Paper=Yes", "Senior=No | Paper=No","Senior=No | Paper=Yes"),
  value = c(cp1,cp2,cp3,cp4)
)
percent_sc

#levels

pay_methods <- levels(type.convert(ctelecom$PaymentMethod))
pay_methods


# mutate would add column to the dataset
yearly_charges <- mutate(ctelecom,yearly_charges = MonthlyCharges *12 )
View(yearly_charges)


# transmute show only one column 
months_period <- transmute(ctelecom,months_period = tenure )
View(months_period)


# slice Data
top_period <- slice(months_period,1:10)
top_period


# pipelines
total_monthly <- ctelecom %>% select(TotalCharges,MonthlyCharges)
yearly <- yearly_charges %>% select(yearly_charges)
periods <- months_period %>% select(months_period)

financial_Data <- data.frame(total_monthly,yearly,periods)
View(financial_Data)



# plots 

# Explain the total charges and the amount 
ctelecom %>%
  select(TotalCharges) %>%
  ggplot(aes(x=TotalCharges)) +
  geom_density() +
  scale_x_continuous(labels=dollar)


# Explain the internet service and the contract types
ctelecom %>%
  ggplot(aes(x=InternetService, fill=Contract)) +
  geom_bar(position="dodge")


# Explain the monthly charges for each contract
ggplot(ctelecom, aes(x = ctelecom$MonthlyCharges, color = Contract)) +
  geom_density(size = 2)

# Explain the months period and the total charges
plot(x = financial_Data$months_period, y = financial_Data$TotalCharges ,
     pch = 16, frame = FALSE,
     xlab = "months_period", ylab = "TotalCharges", col = "#2E9FDF")

# sample from the dataset
samp <- financial_Data[sample(nrow(financial_Data),500),]

# Explain as scatter plot from the charges
scatterplot3d(samp, pch = 8)
View(samp)

# waffle plot Explain the percentage of data
vals <- c(percent_sc$value/0.5)
val_names <- sprintf("%s (%s)", c("Senior=Yes | Paper=No", "Senior=Yes | Paper=Yes", "Senior=No | Paper=No","Senior=No | Paper=Yes"), scales::percent(round(vals/sum(vals), 2)))
names(vals) <- val_names
waffle::waffle(vals) +
  ggthemes::scale_fill_tableau(name=NULL)  

# pie chart Explain the types of the seniors and pepers with percentage
pie_ch <- percent_sc$value
pie(pie_ch, labels = paste0(pie_ch, "%"),  col = c("#FDEBD0", "#D4E6F1", "#F2D7D5","#D1F2EB"))
legend("bottom", legend = c("Senior=Yes | Paper=No", "Senior=Yes | Paper=Yes", "Senior=No | Paper=No","Senior=No | Paper=Yes"),
       inset = -0.25, xpd = TRUE, horiz = TRUE,
       fill =  c("#FDEBD0", "#D4E6F1", "#F2D7D5","#D1F2EB"))


#The period tenure for partners and are they dependents/ independent?
#Most partners are dependents
ggplot(data = telecom) + 
  geom_point(mapping = aes(x =Partner, y = tenure, color = Dependents ))

#monthly charges for internet service, are they also have a phone service?
#Everyone who has internet service has phone service, but the least among them who owns phone service is the one who owns DSL internet service
ggplot(data = telecom) + 
  geom_point(mapping = aes(x =InternetService, y = MonthlyCharges, color = PhoneService))

#A statistic of who owns multiple lines, is he a partner or not
#Partners have more multiple lines than non-partners
ggplot(data = telecom) + 
  geom_bar(mapping = aes(x = MultipleLines, fill = Partner))

#Most contract is month to month then two year
bar <- ggplot(data = telecom) + 
  geom_bar(
    mapping = aes(x = Contract, fill = Contract), 
    show.legend = FALSE,
    width = 1
  ) + 
  theme(aspect.ratio = 1) +
  labs(x = NULL, y = NULL)

bar + coord_flip()
bar + coord_polar()


#The must used of Payment Method is Elctronic check
bar <- ggplot(data = telecom) + 
  geom_bar(
    mapping = aes(x = PaymentMethod, fill = PaymentMethod), 
    show.legend = TRUE,
    width = 1
  ) + 
  theme(aspect.ratio = 1) +
  labs(x = NULL, y = NULL)

bar + coord_flip()
bar + coord_polar()

#difference between female and male, who most uses Streaming Movies pr Monthly Charges
#Almost no difference between them
ggplot(data = telecom) + 
  geom_point(mapping = aes(x = StreamingMovies, y = MonthlyCharges)) + 
  facet_wrap(~ gender,)

#The most tenure per gender
#Males are slightly more than females
ggplot(data = telecom, mapping = aes(x = gender, y = tenure)) + 
  geom_boxplot()
ggplot(data = telecom, mapping = aes(x = gender, y = tenure)) + 
  geom_boxplot() +
  coord_flip()

#Tidy data: separate of customer ID , #delete column of X1 & Churn
df1= telecom %>% 
  separate(customerID, into = c("NoID", "TxtID"))  %>% 
  subset( select = -c(X1, Churn))
view(df1)


# Exploratory Data Analysis
summary(telecom) # general statistic 
introduce(telecom) # statistic about data frame sturacture
plot_missing(telecom) # plot missing values persentage per column
str(telecom) # columns data type 

# Change data type
telecom$SeniorCitizen <- sapply(telecom$SeniorCitizen, as.character)

# How the Monthly charges distribution looks for Senior Citizen and Non- Senior Citizen? 
#     And how affect on Churn*?
telecom %>%
  ggplot(aes(y= MonthlyCharges, x= SeniorCitizen, color = Churn)) +
  geom_boxplot()

#-- Insight --
# As shows in the chart, the Churn of Senior Citizen users is
#   almost similar for the Monthly Charges. Churn of Non-Senior 
#   Citizen users is highest when  Monthly Charges is highest.

#---
# What is the most Monthly charges paid by customers with Month-to-month contract?

telecom %>%
  filter(SeniorCitizen == "1" & Contract == "Month-to-month") %>%
  ggplot(aes(MonthlyCharges, color = Churn)) +
  ggtitle("Monthly charges paid by Senior Citizen with Month-to-month contract") +
  geom_freqpoly() 

telecom %>%
  filter(SeniorCitizen == "0" & Contract == "Month-to-month") %>%
  ggplot(aes(MonthlyCharges, color = Churn)) +
  ggtitle("Monthly charges paid by Non-Senior Citizen with Month-to-month contract") +
  geom_freqpoly() 

#-- Insight --
# Most of Senior Citizen paid between 70 and 105 per month. For Non-Senior Citizen
#   there is big peak when Monthly Charges less than 25.  
# As charts illustrate, Non-Senior Citizen paid less and not churn the service. 
#   On otherwise, monthly charges for Senior Citizen a bit similar for both churn or not.  


# Explain The internet service for each gender
telecom %>%
  ggplot(aes(x=InternetService , fill=gender)) +
  geom_bar(position="dodge")+
  ggtitle("The internet service for each gender ")

# Explain Churn rate by internet service status 
telecom %>%
  ggplot(aes(x=InternetService , fill=Churn)) +
  geom_bar()+
  geom_text(aes(y = ..count.. -200,
                label = paste0(round(prop.table(..count..),4) * 100, '%')),
            stat = 'count',
            position = position_dodge(.1),
            size = 3) +
  ggtitle("Churn rate by internet service status ")


# Explain Churn rate by Total  Charges
telecom %>%
  ggplot(aes(x =TotalCharges , fill = Churn)) +
  geom_histogram(binwidth = 100) +
  labs(x = "Dollars",
       title = " Churn rate by Total  Charges")
telecom_users_1_

# Explain The Total Charges by Contract 
telecom %>%
  ggplot(aes(x =TotalCharges , fill =Contract )) +
  geom_histogram(binwidth = 100) +
  labs(x = "Dollars",
       title = "The Total Charges by Contract ")



view(telecom)