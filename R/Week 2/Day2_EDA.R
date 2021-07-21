# Chapter 7 from R of Data Science https://r4ds.had.co.nz/exploratory-data-analysis.html
# import library
library(tidyverse)

#############
# 7.3.4 Exercises
# 1. 
diamonds
summary(diamonds)
summary(select(diamonds,x,y,z))

# find the outliers
# x variable
plot_x <- ggplot(diamonds) +
  geom_histogram(mapping = aes(x = x))+
  ggtitle("Distribution of x variable") 
  
# y variable
plot_y <- ggplot(diamonds) +
  geom_histogram(mapping = aes(x = y))+
  ggtitle("Distribution of y variable") 

# z variable
plot_z <- ggplot(diamonds) +
  geom_histogram(mapping = aes(x = z))+
  ggtitle("Distribution of z variable") 

plot_grid(plot_x, plot_y, plot_z, ncol=2, nrow = 2)


# There are many outliers on x,y and, z
# Should remove outliers from these variable 

# remove outliers from x 
plot1 <- filter(diamonds, x > 0, x < 10) %>%
  ggplot() +
  geom_histogram(mapping = aes(x = x)) +
  scale_x_continuous(breaks = 1:10) +
  ggtitle("Distribution of x, without outliers")

# remove outliers from y
plot2 <- filter(diamonds, y > 0, y < 10) %>%
  ggplot() +
  geom_histogram(mapping = aes(x = y)) +
  scale_x_continuous(breaks = 1:10) + 
  ggtitle("Distribution of y, without outliers") 

# remove outliers from y
plot3 <- filter(diamonds, z > 0, z < 10) %>%
  ggplot() +
  geom_histogram(mapping = aes(x = z)) +
  scale_x_continuous(breaks = 1:10) +
  ggtitle("Distribution of z, without outliers")

plot_grid(plot1, plot2, plot3, ncol=2, nrow = 2)


# The x, y larger than z
# As shows on plot x larger than y. 
#   so, we can assume x will be length,
#   y will be width,
#   z is smallest values, then z will be depth

#------
# 2.
ggplot(diamonds) +
  geom_histogram(mapping = aes(x = price),binwidth= 40)+
  ggtitle("Distribution of price variable") 

filter(diamonds, price > 1000, price < 3000) %>%
  ggplot() +
  geom_histogram(mapping = aes(x = price),binwidth= 10)+
  ggtitle("Distribution of price between $1000 and $3000")

# As see on the plot, there isn't data between ~ $1450 and $1550


#------
# 3.

diamonds %>%
  filter(carat >= 0.99, carat <=1) %>%
  count(carat)

# I think some of the carat rounded up to 1 instend of 0.99

#-----
# 4.
?coord_cartesian
# Coordinate system will zoom the plot. 
ggplot(diamonds) +
  geom_histogram(mapping = aes(x = price)) +
  coord_cartesian(xlim = c(100, 5000), ylim = c(0, 3000))

ggplot(diamonds) +
  geom_histogram(mapping = aes(x = price)) +
  xlim(100, 5000) +
  ylim(0, 3000)


################
# 7.4.1 Exercises
# 1. 

# histogram 
# Null values not shows on the plot  
diamonds_2 <- diamonds %>%
  mutate(y = ifelse(z < 3 | z > 10, NA, z)) # add NA value to data
ggplot(diamonds_2, aes(x = z)) +
  geom_histogram()

# bar chart
# as shows on the plot, the null values count as "NA"
diamonds_3 <- diamonds %>%
  mutate(cut = ifelse(z < 2.5, NA, as.character(cut))) # add NA value to data
ggplot(diamonds_3, aes(x =  cut)) +
  geom_bar()

#-----
# 2. 
# na.rm = TRUE, to remove NA form vectore to calculate mean and sum
mean(c(5, 7,NA, 2, NA), na.rm = TRUE)
sum(c(5, 7,NA, 2, NA), na.rm = TRUE)