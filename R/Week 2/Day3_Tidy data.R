# Exercises on Ch 12 and 13 on R for Data Science (R4DS) https://r4ds.had.co.nz/tidy-data.html
library(tidyverse)
library(ggplot2)

# Chapter 12
# 12.2.1 Exercises

#------
# 1. 
# The variables refers to the columns, each variable represent one feature about this data
# Observations refers to rows, each observation represent a vector of features of one sample


table1
# Table 1:
#   Rows: repersent country and year.
#   Columns: repersent cases and population.
table2
# Table 2:
#   Rows: repersent country, year and, type.
#   Columns: repersent count for each type.

table3 
# Table 3:
#   Rows: repersent country and year.
#   Columns: repersent rate for cases and population. 

table4a # cases
# Table 4a:
#   Rows: repersent country and cases.
#   Columns: repersent years.

table4b # population
# Table 4b:
#   Rows: repersent country and population.
#   Columns: repersent years.

#-----
# 2.
#Compute the rate for table2, and table4a + table4b. You will need to perform four operations:

# I. Extract the number of TB cases per country per year.
cases_ <- filter(table2,type=='cases') %>% # filter data by cases
  rename(cases='count') %>% # rename column name 
  arrange(country, year) # order the rows
cases_


# II. Extract the matching population per country per year.

population_ <- filter(table2,type=='population') %>% # filter data by cases
  rename(population='count') %>% # rename column name 
  arrange(country, year) # order the rows
population_

# III. Divide cases by population, and multiply by 10000.
cases_per_cap_table2 <- data.frame(
  year = cases_$year,
  country = cases_$country, 
  cases = cases_$cases,
  population = population_$population
  ) %>%
  mutate(cases_per_cap = (cases / population) * 10000) %>% # calculate the rate 
  select(country, year, cases_per_cap) # select these columns 

# add new column for type, that's help to merge these data with data on table2
cases_per_cap_table2 <- cases_per_cap_table2 %>%
  mutate(type = "cases_per_cap") %>% # create new column
  rename(count = cases_per_cap) # rename the column

cases_per_cap_table2

table2 <- rbind(table2,cases_per_cap_table2) %>%
  arrange(country, year)

table2
# IIII. Store back in the appropriate place.

table4c <-
  data.frame(
    country = table4a$country,
    `1999` = table4a[["1999"]] / table4b[["1999"]] * 10000,
    `2000` = table4a[["2000"]] / table4b[["2000"]] * 10000
     # need to add new line for each year on the dataset
  )
table4c
# XI. Which representation is easiest to work with? Which is hardest? Why?
# Answer: Table2 is easy to work on it because of all years in one column.
#         It's hard to work on Table4a and Table4b


#------
# 3.

# Compute cases per year
table2 %>% 
  count(year, wt = cases)

# Visualise changes over time
table2 %>% 
  filter(type=="cases") %>%
  ggplot(aes(year, count)) + 
  geom_line(aes(group = country), colour = "grey50") + 
  geom_point(aes(colour = country))

################
# 12.3.3 Exercises

#-----
# 1.
stocks <- tibble(
  year   = c(2015, 2015, 2016, 2016),
  half  = c(   1,    2,     1,    2),
  return = c(1.88, 0.59, 0.92, 0.17)
)
stocks %>% 
  pivot_wider(names_from = year, values_from = return) %>% 
  pivot_longer(`2015`:`2016`, names_to = "year", values_to = "return")

# In the pivot_wider, the year be columns and half be rows
# In the pivot_longer, the year and half both be rows

names_ptypes = list(year = double())
names_ptypes # return the data types

#------
# 2.
table4a %>% 
  pivot_longer(c(1999, 2000), names_to = "year", values_to = "cases")
# year 1999 and 2000 not exist on the table4a

#------
# 3.
people <- tribble(
  ~name,             ~names,  ~values,
  #-----------------|--------|------
  "Phillip Woods",   "age",       45,
  "Phillip Woods",   "height",   186,
  "Phillip Woods",   "age",       50,
  "Jessica Cordero", "age",       37,
  "Jessica Cordero", "height",   156
)
people
pivot_wider(people, names_from="name", values_from = "values") # Error

people2 <- people %>%
  group_by(name, names) %>% # Group by name and names
  mutate(obs = row_number())

# create pivot wider for new data
pivot_wider(people2, names_from="name", values_from = "values") 

# ------
# 4.
preg <- tribble(
  ~pregnant, ~male, ~female,
  "yes",     NA,    10,
  "no",      20,    12
)
preg2 <- pivot_longer(preg, c(male,female), names_to="sex", values_to = "count") 
preg2


#############
# 12.4.3 Exercises

#-----
# 1.
?separate
# extra: this controls what happens when there are too many pieces.
# fill:  this controls what happens when there are not enough pieces

tibble(x = c("a,b,c", "d,e,f,g", "h,i,j")) %>% 
  separate(x, c("one", "two", "three"), extra='warn')

tibble(x = c("a,b,c", "d,e", "f,g,i")) %>% 
  separate(x, c("one", "two", "three"), fill='right')

#-----
# 2.

?unite
# remove in both unite separate: remove input columns from an output data frame.
# if it is False, then didn't remove input from output data


#-----
# 3.

?extract()
# separate() turns a single character column into multiple columns.
# extract() uses a regular expression to specify groups in character 
#           vector and split that single character vector into multiple columns.